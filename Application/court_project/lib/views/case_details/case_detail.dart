import 'dart:convert';

import 'package:court_project/models/case_model.dart';
import 'package:court_project/models/complete_case_model.dart';
import 'package:court_project/models/note_model.dart';
import 'package:court_project/models/petitioner_model.dart';
import 'package:court_project/models/respondent_model.dart';
import 'package:court_project/models/timeline_model.dart';
import 'package:court_project/utils/nav_bar.dart';
import 'package:court_project/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:http/http.dart' as http;

eventType parseEventType(String type) {
  if (type == "case_filed") {
    return eventType.caseFiled;
  } else if (type == "case_disposed") {
    return eventType.caseDisposed;
  } else if (type == "document_uploaded") {
    return eventType.documentUploaded;
  } else if (type == "next_hearing") {
    return eventType.nextHearing;
  } else if (type == "hearing") {
    return eventType.hearing;
  } else {
    return eventType.hearing;
  }
}

TextStyle commonInfoStyle = const TextStyle(
    color: Colors.black, fontSize: 17, fontWeight: FontWeight.w600);

class CaseDetail extends StatefulWidget {
  final CompleteCaseModel caseDetail;
  const CaseDetail({Key? key, required this.caseDetail}) : super(key: key);

  @override
  State<CaseDetail> createState() => _CaseDetailState();
}

class _CaseDetailState extends State<CaseDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Responsive(
      mobile: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            width: 1100,
            child: MainWidget(
              isMobile: true,
              caseDetail: widget.caseDetail,
            ),
          ),
        ),
      ),
      desktop: MainWidget(
        caseDetail: widget.caseDetail,
      ),
    ));
  }
}

class MainWidget extends StatefulWidget {
  bool? isMobile;
  final CompleteCaseModel caseDetail;
  MainWidget({this.isMobile = false, required this.caseDetail});

  @override
  State<MainWidget> createState() => _MainWidgetState();
}

class _MainWidgetState extends State<MainWidget> {
  TextEditingController hearingDateController = TextEditingController();
  int selectedItem = 0;
  List<TimelineModel> timelineListSample = [];
  // List timelineWidgetList = [
  //   TimelineItem(
  //       timelineType: eventType.caseFiled,
  //       time: DateTime.now(),
  //       information: "Petioner files case ....some text"),
  //   TimelineItem(
  //     timelineType: eventType.hearing,
  //     time: DateTime.now(),
  //     information: "Petioner files case ....some text",
  //   ),
  //   TimelineItem(
  //       timelineType: eventType.hearing,
  //       time: DateTime.now(),
  //       information: "Petioner files case ....some text"),
  //   TimelineItem(
  //       timelineType: eventType.hearing,
  //       time: DateTime.now(),
  //       information: "Petioner files case ....some text"),
  //   TimelineItem(
  //       timelineType: eventType.documentUploaded,
  //       time: DateTime.now(),
  //       information: "Petioner files case ....some text"),
  //   TimelineItem(
  //       timelineType: eventType.hearing,
  //       time: DateTime.now(),
  //       information: "Petioner files case ....some text"),
  //   TimelineItem(
  //       timelineType: eventType.hearing,
  //       time: DateTime.now(),
  //       information: "Petioner files case ....some text"),
  //   TimelineItem(
  //       timelineType: eventType.hearing,
  //       time: DateTime.now(),
  //       information: "Petioner files case ....some text"),
  //   TimelineItem(
  //       timelineType: eventType.documentUploaded,
  //       time: DateTime.now(),
  //       information: "Petioner files case ....some text"),
  //   TimelineItem(
  //       timelineType: eventType.hearing,
  //       time: DateTime.now(),
  //       information: "Petioner files case ....some text"),
  //   TimelineItem(
  //       timelineType: eventType.nextHearing,
  //       time: DateTime.now(),
  //       information: "Petioner files case ....some text"),
  //   TimelineItem(
  //       timelineType: eventType.caseDisposed,
  //       time: DateTime.now(),
  //       information: "Petioner files case ....some text"),
  // ];

  TimelineModel? selectedModel;

  void getTimeLine(String caseId) async {
    List<TimelineModel> _events = [];

    var response = await http.post(
      Uri.parse("http://127.0.0.1/cms/get_events.php"),
      body: {"case_id": caseId},
    );

    var _parsedEventData = jsonDecode(response.body);

    for (int i = 0; i < _parsedEventData.length; i++) {
      var event = _parsedEventData[i];
      _events.add(
        TimelineModel(
          eventId: event["event_id"],
          caseId: event["case_id"],
          eventDate: DateTime.parse(event["event_date"]),
          eventtype: i == _parsedEventData.length - 1 &&
                  event["event_type"] == "hearing"
              ? parseEventType("next_hearing")
              : parseEventType(event["event_type"]),
          note: event["notes"] != null
              ? NoteModel(
                  noteId: event["notes"]["note_id"],
                  caseId: event["case_id"],
                  eventId: event["event_id"],
                  heading: event["notes"]["heading"],
                  content: event["notes"]["content"],
                )
              : null,
        ),
      );
    }

    setState(() {
      timelineListSample = _events;
    });
  }

  @override
  void initState() {
    getTimeLine("case12345");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<PetitionerModel> petitionersList = widget.caseDetail.petitionersList;
    List<RespondantModel> respondentList = widget.caseDetail.respondantList;
    CaseModel caseModel = widget.caseDetail.caseModel;
    double height = MediaQuery.of(context).size.height;
    double width = widget.isMobile! ? 1100 : MediaQuery.of(context).size.width;

    return Container(
        height: height,
        width: width,
        color: Colors.white,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          NavBar(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 50),
            child: Row(
              children: [
                Text(
                  selectedItem == 2 ? "Case Summary" : 'Case Details',
                  style: TextStyle(
                      color: Color(0xff12294C),
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                Expanded(child: Container()),
                GestureDetector(
                  onTap: () {
                    AlertDialog alert = AlertDialog(
                      title: Text("22/04/2020"),
                      content: Text(
                          "Please verify the date you are updating the status."),
                      actions: [
                        TextButton(
                            onPressed: () {
                              setState(() {
                                selectedItem = 2;
                              });
                              Navigator.pop(context);
                            },
                            child: Text('Okay')),
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('Cancel')),
                      ],
                    );

                    showDialog(context: context, builder: (context) => alert);
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Color(0xff12294C),
                        border: Border(
                            bottom: BorderSide(
                                width: selectedItem == 2 ? 4 : 2,
                                color: Color(0xffB1B8C2)))),
                    child: Text(
                      'Update Case Status',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(
                  width: 30,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedItem = 0;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                width: selectedItem == 0 ? 4 : 0,
                                color: Color(0xffB1B8C2)))),
                    child: Text(
                      'Timeline',
                      style: TextStyle(
                          color: Color(0xff12294C),
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(
                  width: 30,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedItem = 1;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                width: selectedItem == 1 ? 4 : 0,
                                color: Color(0xffB1B8C2)))),
                    child: const Text(
                      'Report',
                      style: TextStyle(
                          color: Color(0xff12294C),
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
          selectedItem == 0
              ? Row(
                  children: [
                    Expanded(child: Container()),
                    SvgPicture.asset(
                      "assets/next_hearing_indi.svg",
                      height: 15,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text('Next Hearing'),
                    const SizedBox(
                      width: 20,
                    ),
                    SvgPicture.asset(
                      "assets/case_filed_indi.svg",
                      height: 15,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text('Case Filed'),
                    const SizedBox(
                      width: 20,
                    ),
                    SvgPicture.asset(
                      "assets/case_disposal_indi.svg",
                      height: 15,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text('Case Disposal'),
                    const SizedBox(
                      width: 20,
                    ),
                    SvgPicture.asset(
                      "assets/documents_uploaded_indi.svg",
                      height: 15,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text('Documents/Notes Uploaded'),
                    const SizedBox(
                      width: 20,
                    ),
                  ],
                )
              : Container(),
          selectedItem == 1
              ? Container(
                  width: width,
                  height: height * 0.9 - 30 - 70,
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Case ID: " + caseModel.caseId,
                          style: const TextStyle(
                              color: Color(0xff12294C),
                              fontSize: 19,
                              fontWeight: FontWeight.bold),
                        ),
                        const Divider(
                          thickness: 6,
                          color: Color(0xffB4B4B4),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            QrImage(
                              data: caseModel.caseId,
                              version: QrVersions.auto,
                              size: 150.0,
                            ),
                            Expanded(child: Container()),
                            Container(
                              width: 160,
                              height: 40,
                              decoration: BoxDecoration(
                                  color: Color(0xffE8E8E8),
                                  borderRadius: BorderRadius.circular(5)),
                              alignment: Alignment.center,
                              child: Row(
                                children: [
                                  Expanded(child: Container()),
                                  const Text(
                                    "Share",
                                    style: TextStyle(
                                        color: Color(0xff12294C), fontSize: 20),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  const Icon(
                                    Icons.share,
                                    color: Color(0xff12294C),
                                  ),
                                  Expanded(child: Container()),
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Container(
                              width: 180,
                              height: 40,
                              decoration: BoxDecoration(
                                  color: Color(0xff12294C),
                                  borderRadius: BorderRadius.circular(5)),
                              alignment: Alignment.center,
                              child: Row(
                                children: [
                                  Expanded(child: Container()),
                                  const Text(
                                    "Download",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  const Icon(
                                    Icons.cloud_download,
                                    color: Colors.white,
                                  ),
                                  Expanded(child: Container()),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        for (PetitionerModel pet in petitionersList)
                          Column(
                            children: [
                              PetitionerInfo(
                                model: pet,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        const SizedBox(
                          height: 20,
                        ),
                        for (RespondantModel res in respondentList)
                          Column(
                            children: [
                              RespondentInfo(
                                model: res,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        const SizedBox(
                          height: 20,
                        ),
                        CaseInfo(model: caseModel),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ))
              : selectedItem == 0
                  ? Container(
                      width: width,
                      height: height * 0.9 - 120,
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: width * 0.3,
                            child: SingleChildScrollView(
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children:
                                        timelineListSample.map<Widget>((e) {
                                      return TimelineItem(
                                        model: e,
                                        selectedItemTrigger:
                                            (TimelineModel selected) {
                                          setState(() {
                                            selectedModel = selected;
                                          });
                                        },
                                      );
                                    }).toList()

                                    //  [...timelineList.m timelineWidgetList],
                                    )),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          const VerticalDivider(
                            color: Colors.black,
                            thickness: 2,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          selectedModel != null
                              ? Container(
                                  width: width < 1150
                                      ? width * 0.6 - 50
                                      : width * 0.6,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Hearing Date: " +
                                            selectedModel!.eventDate.toString(),
                                        style: const TextStyle(
                                            color: Color(0xff12294C),
                                            fontSize: 19,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      const Text(
                                        "Case Overview: ",
                                        style: TextStyle(
                                            color: Color(0xff12294C),
                                            fontSize: 23,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        padding: EdgeInsets.all(10),
                                        child:
                                            Text(selectedModel!.note!.content,
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                )),
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                width: 1, color: Colors.black),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                      ),
                                    ],
                                  ),
                                )
                              : Container()
                        ],
                      ),
                    )
                  : Container(
                      width: width,
                      height: height * 0.9 - 90 - 8,
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: SingleChildScrollView(
                          child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                child: Text(
                                  "Hearing Date: " + "04/12/2020",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Container(
                                width: width * 0.1,
                                child: Text(
                                  "Next-Hearing Date",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                              ),
                              Container(
                                width: width * 0.2,
                                child: TextField(
                                  controller: hearingDateController,
                                  onTap: () {
                                    showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(2019, 1),
                                        lastDate: DateTime.now(),
                                        builder: (context, picker) {
                                          return Theme(
                                            data: ThemeData.dark().copyWith(
                                              colorScheme: ColorScheme.dark(),
                                            ),
                                            child: picker!,
                                          );
                                        }).then((selectedDate) {
                                      if (selectedDate != null) {
                                        setState(() {
                                          hearingDateController.text =
                                              selectedDate
                                                  .toString()
                                                  .substring(0, 10);
                                        });
                                      }
                                    });
                                  },
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            height: 220,
                            width: width,
                            child: Material(
                              color: Color(0xffE9F0FA),
                              child: Column(
                                children: [
                                  Container(
                                    height: 40,
                                    width: width,
                                    color: Color(0xffCDFFF6),
                                    child: Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      child: Row(
                                        children: [
                                          Text(
                                            'Notes in Short',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18),
                                          ),
                                          Expanded(child: Container()),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 180,
                                    width: width - width * 0.1,
                                    child: Center(
                                      child: SizedBox(
                                        height: 160,
                                        width: width - 100,
                                        child: TextField(
                                          maxLines: 6,
                                          decoration: InputDecoration(
                                            hintText: "Add your note here...",
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              borderSide: BorderSide(
                                                width: 0,
                                                style: BorderStyle.none,
                                              ),
                                            ),
                                            filled: true,
                                            fillColor: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            decoration: BoxDecoration(
                              color: Color(0xffE9F0FA),
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            height: 400,
                            width: width,
                            child: Material(
                              color: Color(0xffE9F0FA),
                              child: Column(
                                children: [
                                  Container(
                                    height: 40,
                                    width: width,
                                    color: Color(0xffFFCE22),
                                    child: Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      child: Row(
                                        children: [
                                          Text(
                                            'Notes',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18),
                                          ),
                                          Expanded(child: Container()),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 360,
                                    width: width - width * 0.1,
                                    child: Center(
                                      child: SizedBox(
                                        height: 340,
                                        width: width - 100,
                                        child: TextField(
                                          maxLines: 16,
                                          decoration: InputDecoration(
                                            hintText: "Add your note here...",
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              borderSide: BorderSide(
                                                width: 0,
                                                style: BorderStyle.none,
                                              ),
                                            ),
                                            filled: true,
                                            fillColor: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            decoration: BoxDecoration(
                              color: Color(0xffE9F0FA),
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ],
                      )),
                    ),
        ]));
  }
}

class TimelineItem extends StatelessWidget {
  // eventType timelineType;
  // DateTime time;
  // String information;
  TimelineModel model;
  Function selectedItemTrigger;
  TimelineItem({required this.model, required this.selectedItemTrigger});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          DateFormat('dd-MM-yyyy hh:mm').format(model.eventDate),
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          width: 10,
        ),
        Column(
          children: [
            Container(
              height: 30,
              child: const VerticalDivider(
                color: Colors.black,
                thickness: 2,
              ),
            ),
            SvgPicture.asset(
              model.eventtype == eventType.nextHearing
                  ? "assets/next_hearing_indi.svg"
                  : model.eventtype == eventType.caseFiled
                      ? "assets/case_filed_indi.svg"
                      : model.eventtype == eventType.caseDisposed
                          ? "assets/case_disposal_indi.svg"
                          : model.eventtype == eventType.documentUploaded
                              ? "assets/documents_uploaded_indi.svg"
                              : "assets/hearing.svg",
              height: 15,
            ),
            Container(
              height: 30,
              child: const VerticalDivider(
                color: Colors.black,
                thickness: 2,
              ),
            ),
          ],
        ),
        const SizedBox(
          width: 10,
        ),
        Row(
          children: [
            Text(
              model.eventtype == eventType.hearing
                  ? model.note!.heading.length < 28
                      ? model.note!.heading
                      : model.note!.heading.substring(0, 24) + "..."
                  : "Information",
              softWrap: true,
              overflow: TextOverflow.fade,
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
            model.eventtype == eventType.hearing
                ? TextButton(
                    onPressed: () {
                      selectedItemTrigger(model);
                    },
                    child: Text('View More...',
                        style: TextStyle(color: Color(0xff5785CA))),
                  )
                : Container()
          ],
        )
      ],
    );
  }
}

class PetitionerInfo extends StatelessWidget {
  bool isMobile;
  PetitionerModel model;
  PetitionerInfo({this.isMobile = false, required this.model});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = isMobile ? 1100 : MediaQuery.of(context).size.width;

    return Container(
      width: width,
      height: 350,
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
          color: Color(0xffE8E8E8), borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Petitioner Details",
            style: TextStyle(
                color: Color(0xff12294C),
                fontWeight: FontWeight.bold,
                fontSize: 18),
          ),
          const Divider(
            color: Color(0xff12294C),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Container(
                width: width * 0.45,
                child: Text(
                  "Name: " + model.name,
                  style: commonInfoStyle,
                ),
              ),
              Container(
                width: width * 0.45,
                child: Text(
                  "Individual/Dept: " + model.inddep.toString(),
                  style: commonInfoStyle,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            children: [
              Container(
                width: width * 0.45,
                child: Text(
                  "Father/Husband Name: " + model.fhName,
                  style: commonInfoStyle,
                ),
              ),
              Container(
                width: width * 0.45,
                child: Text(
                  "Relation: " + model.relation,
                  style: commonInfoStyle,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            children: [
              Container(
                width: width * 0.45,
                child: Text(
                  "Age: " + model.age.toString(),
                  style: commonInfoStyle,
                ),
              ),
              Container(
                width: width * 0.45,
                child: Text(
                  "Gender: " + model.gender,
                  style: commonInfoStyle,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            children: [
              Container(
                width: width * 0.45,
                child: Text(
                  "Occupation: " + model.occupation,
                  style: commonInfoStyle,
                ),
              ),
              Container(
                width: width * 0.45,
                child: Text(
                  "Caste: " + model.caste,
                  style: commonInfoStyle,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            children: [
              Container(
                width: width * 0.9,
                child: Text(
                  "Address: " +
                      model.address +
                      ", " +
                      model.city +
                      ", " +
                      model.district +
                      ", " +
                      model.state +
                      ", " +
                      model.pinCode.toString(),
                  style: commonInfoStyle,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            children: [
              Container(
                width: width * 0.45,
                child: Text(
                  "Education Qualification: " + model.edu,
                  style: commonInfoStyle,
                ),
              ),
              Container(
                width: width * 0.45,
                child: Text(
                  "Mobile Number: " + model.mobile.toString(),
                  style: commonInfoStyle,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            children: [
              Container(
                width: width * 0.45,
                child: Text(
                  "Email: " + model.email,
                  style: commonInfoStyle,
                ),
              ),
              Container(
                width: width * 0.45,
                child: Text(
                  "Status: " + model.status,
                  style: commonInfoStyle,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class RespondentInfo extends StatelessWidget {
  bool isMobile;
  RespondantModel model;
  RespondentInfo({this.isMobile = false, required this.model});
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = isMobile ? 1100 : MediaQuery.of(context).size.width;

    return Container(
      width: width,
      height: 350,
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
          color: Color(0xffE8E8E8), borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Respondent Details",
            style: TextStyle(
                color: Color(0xff12294C),
                fontWeight: FontWeight.bold,
                fontSize: 18),
          ),
          const Divider(
            color: Color(0xff12294C),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Container(
                width: width * 0.45,
                child: Text(
                  "Name: " + model.name,
                  style: commonInfoStyle,
                ),
              ),
              Container(
                width: width * 0.45,
                child: Text(
                  "Individual/Dept: " + model.inddep.toString(),
                  style: commonInfoStyle,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            children: [
              Container(
                width: width * 0.45,
                child: Text(
                  "Father/Husband Name: " + model.fhName,
                  style: commonInfoStyle,
                ),
              ),
              Container(
                width: width * 0.45,
                child: Text(
                  "Relation: " + model.relation,
                  style: commonInfoStyle,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            children: [
              Container(
                width: width * 0.45,
                child: Text(
                  "Age: " + model.age.toString(),
                  style: commonInfoStyle,
                ),
              ),
              Container(
                width: width * 0.45,
                child: Text(
                  "Gender: " + model.gender,
                  style: commonInfoStyle,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            children: [
              Container(
                width: width * 0.45,
                child: Text(
                  "Occupation: " + model.occupation,
                  style: commonInfoStyle,
                ),
              ),
              Container(
                width: width * 0.45,
                child: Text(
                  "Caste: " + model.caste,
                  style: commonInfoStyle,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            children: [
              Container(
                width: width * 0.9,
                child: Text(
                  "Address: " +
                      model.address +
                      ", " +
                      model.city +
                      ", " +
                      model.district +
                      ", " +
                      model.state +
                      ", " +
                      model.pinCode.toString(),
                  style: commonInfoStyle,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            children: [
              Container(
                width: width * 0.45,
                child: Text(
                  "Education Qualification: " + model.edu,
                  style: commonInfoStyle,
                ),
              ),
              Container(
                width: width * 0.45,
                child: Text(
                  "Mobile Number: " + model.mobile.toString(),
                  style: commonInfoStyle,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            children: [
              Container(
                width: width * 0.45,
                child: Text(
                  "Email: " + model.email,
                  style: commonInfoStyle,
                ),
              ),
              Container(
                width: width * 0.45,
                child: Text(
                  "Status: " + model.status,
                  style: commonInfoStyle,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CaseInfo extends StatelessWidget {
  bool isMobile;
  CaseModel model;
  CaseInfo({this.isMobile = false, required this.model});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = isMobile ? 1100 : MediaQuery.of(context).size.width;

    return Container(
      width: width,
      height: 240,
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
          color: Color(0xffE8E8E8), borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Case Details",
            style: TextStyle(
                color: Color(0xff12294C),
                fontWeight: FontWeight.bold,
                fontSize: 18),
          ),
          const Divider(
            color: Color(0xff12294C),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Container(
                width: width * 0.45,
                child: Text(
                  "Case Number: " + model.caseId,
                  style: commonInfoStyle,
                ),
              ),
              Container(
                width: width * 0.45,
                child: Text(
                  "Petitioner’s Advocate: " + model.petAdv,
                  style: commonInfoStyle,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            children: [
              Container(
                width: width * 0.45,
                child: Text(
                  "Diary Number: " + model.diaryNo.toString(),
                  style: commonInfoStyle,
                ),
              ),
              Container(
                width: width * 0.45,
                child: Text(
                  "Respondent’s Advocate: " + model.resAdv,
                  style: commonInfoStyle,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            children: [
              Container(
                width: width * 0.45,
                child: Text(
                  "Next Hearing: " + model.nextHearing,
                  style: commonInfoStyle,
                ),
              ),
              Container(
                width: width * 0.45,
                child: Text(
                  "Filing Date: " + model.filing,
                  style: commonInfoStyle,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            children: [
              Container(
                width: width * 0.45,
                child: Text(
                  "Judgement By: " + model.judgementBy,
                  style: commonInfoStyle,
                ),
              ),
              Container(
                width: width * 0.45,
                child: Text(
                  "Case Age: " + model.age.toString(),
                  style: commonInfoStyle,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            children: [
              Container(
                width: width * 0.45,
                child: Text(
                  "Status: " + model.status,
                  style: commonInfoStyle,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
