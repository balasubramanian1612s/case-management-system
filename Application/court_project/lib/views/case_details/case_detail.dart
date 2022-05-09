import 'dart:convert';
import 'dart:html';
import 'package:excel/excel.dart';
import 'package:http/http.dart' as http;
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
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
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher_web/url_launcher_web.dart' as url_launcher;

TextStyle commonInfoStyle = const TextStyle(
    color: Colors.black, fontSize: 17, fontWeight: FontWeight.w600);

pw.TextStyle pwcommonInfoStyle = pw.TextStyle();

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
  int selectedItem = 1;
  List<TimelineModel> timelineListSample = [];
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

  List<PetitionerModel> petitionersList = [];
  List<RespondantModel> respondentList = [];
  CaseModel? caseModel;

  final TextEditingController _shortNoteController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  @override
  void initState() {
    petitionersList = widget.caseDetail.petitionersList;
    respondentList = widget.caseDetail.respondantList;
    caseModel = widget.caseDetail.caseModel;
    getTimeLine("case12345");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                          "Case ID: " + caseModel!.caseId,
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
                              data: caseModel!.caseId,
                              version: QrVersions.auto,
                              size: 150.0,
                            ),
                            Expanded(child: Container()),
                            GestureDetector(
                              onTap: () async {
                                await _generatePDF(true);
                              },
                              child: Container(
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
                                          color: Color(0xff12294C),
                                          fontSize: 20),
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
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            GestureDetector(
                              onTap: () async {
                                showDialog(
                                    context: context,
                                    barrierDismissible: true,
                                    builder: (context) => Dialog(
                                          child: Container(
                                              height: 200,
                                              width: 200,
                                              alignment: Alignment.center,
                                              child: Center(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    TextButton(
                                                        onPressed: () async {
                                                          await _generatePDF(
                                                              false);
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: const Text(
                                                            "As PDF")),
                                                    TextButton(
                                                        onPressed: () async {
                                                          await _generateExcel();
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: const Text(
                                                            "As Excel")),
                                                  ],
                                                ),
                                              )),
                                        ));
                              },
                              child: Container(
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
                        CaseInfo(model: caseModel!),
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
                                          controller: _shortNoteController,
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
                                          controller: _noteController,
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
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      //TODO:
                                    },
                                    child: Container(
                                      width: 180,
                                      height: 40,
                                      decoration: BoxDecoration(
                                          color: Color(0xff12294C),
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      alignment: Alignment.center,
                                      child: Row(
                                        children: [
                                          Expanded(child: Container()),
                                          const Text(
                                            "Submit",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20),
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
                                  ),
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

  _generatePDF(bool isSharing) async {
    CaseModel model = caseModel!;
    final pdf = pw.Document();
    pw.MemoryImage img = pw.MemoryImage(
      (await rootBundle.load('assets/logo.png')).buffer.asUint8List(),
    );
    pdf.addPage(
      pw.MultiPage(header: ((pw.Context context) {
        return pw.Column(children: [
          pw.Row(children: [
            pw.Text(
              "DISTRICT COURT  TIRUPUR",
              style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 18),
            ),
            pw.Expanded(child: pw.Container()),
            pw.Image(img, height: 40, width: 40)
          ]),
          pw.Divider()
        ]);
      }), build: (pw.Context context) {
        return [
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                "Case Number: " + model.caseId,
                style: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold,
                    fontSize: 18,
                    color: PdfColors.green800),
              ),
              pw.SizedBox(
                height: 10,
              ),
              pw.Text(
                "Case Details",
                style: pw.TextStyle(fontSize: 16, color: PdfColors.brown),
              ),
              pw.SizedBox(
                height: 10,
              ),
              pw.Container(
                child: pw.Text(
                  "Case Number: " + model.caseId,
                  style: pwcommonInfoStyle,
                ),
              ),
              pw.Container(
                child: pw.Text(
                  "Petitioner Advocate: " + model.petAdv,
                  style: pwcommonInfoStyle,
                ),
              ),
              pw.Container(
                child: pw.Text(
                  "Diary Number: " + model.diaryNo.toString(),
                  style: pwcommonInfoStyle,
                ),
              ),
              pw.Container(
                child: pw.Text(
                  "Respondent Advocate: " + model.resAdv,
                  style: pwcommonInfoStyle,
                ),
              ),
              pw.Container(
                child: pw.Text(
                  "Next Hearing: " + model.nextHearing,
                  style: pwcommonInfoStyle,
                ),
              ),
              pw.Container(
                child: pw.Text(
                  "Filing Date: " + model.filing,
                  style: pwcommonInfoStyle,
                ),
              ),
              pw.Container(
                child: pw.Text(
                  "Judgement By: " + model.judgementBy,
                  style: pwcommonInfoStyle,
                ),
              ),
              pw.Container(
                child: pw.Text(
                  "Case Age: " + model.age.toString(),
                  style: pwcommonInfoStyle,
                ),
              ),
              pw.Container(
                child: pw.Text(
                  "Status: " + model.status,
                  style: pwcommonInfoStyle,
                ),
              ),
            ],
          ),
          pw.SizedBox(
            height: 10,
          ),
          ...petitionersList
              .map<pw.Widget>((ele) => pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                        "Petitioner Details",
                        style:
                            pw.TextStyle(fontSize: 16, color: PdfColors.brown),
                      ),
                      pw.SizedBox(
                        height: 10,
                      ),
                      pw.Container(
                        child: pw.Text(
                          "Name: " + ele.name,
                          style: pwcommonInfoStyle,
                        ),
                      ),
                      pw.Container(
                        child: pw.Text(
                          "Individual/Dept: " + ele.inddep.toString(),
                          style: pwcommonInfoStyle,
                        ),
                      ),
                      pw.Container(
                        child: pw.Text(
                          "Father/Husband Name: " + ele.fhName,
                          style: pwcommonInfoStyle,
                        ),
                      ),
                      pw.Container(
                        child: pw.Text(
                          "Relation: " + ele.relation.toString(),
                          style: pwcommonInfoStyle,
                        ),
                      ),
                      pw.Container(
                        child: pw.Text(
                          "Age: " + ele.age.toString(),
                          style: pwcommonInfoStyle,
                        ),
                      ),
                      pw.Container(
                        child: pw.Text(
                          "Gender: " + ele.gender.toString(),
                          style: pwcommonInfoStyle,
                        ),
                      ),
                      pw.Container(
                        child: pw.Text(
                          "Occupation: " + ele.occupation.toString(),
                          style: pwcommonInfoStyle,
                        ),
                      ),
                      pw.Container(
                        child: pw.Text(
                          "Caste: " + ele.caste.toString(),
                          style: pwcommonInfoStyle,
                        ),
                      ),
                      pw.Container(
                        child: pw.Text(
                          "Address: " +
                              ele.address +
                              ", " +
                              ele.city +
                              ", " +
                              ele.district +
                              ", " +
                              ele.state +
                              ", " +
                              ele.pinCode.toString(),
                          style: pwcommonInfoStyle,
                        ),
                      ),
                      pw.Container(
                        child: pw.Text(
                          "Education Qualification: " + ele.edu.toString(),
                          style: pwcommonInfoStyle,
                        ),
                      ),
                      pw.Container(
                        child: pw.Text(
                          "Mobile Number: " + ele.mobile.toString(),
                          style: pwcommonInfoStyle,
                        ),
                      ),
                      pw.Container(
                        child: pw.Text(
                          "Email: " + ele.email.toString(),
                          style: pwcommonInfoStyle,
                        ),
                      ),
                      pw.Container(
                        child: pw.Text(
                          "Status: " + ele.status.toString(),
                          style: pwcommonInfoStyle,
                        ),
                      ),
                      pw.SizedBox(
                        height: 10,
                      ),
                    ],
                  ))
              .toList(),
          ...respondentList
              .map<pw.Widget>((ele) => pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                        "Respondant Details",
                        style:
                            pw.TextStyle(fontSize: 16, color: PdfColors.brown),
                      ),
                      pw.SizedBox(
                        height: 10,
                      ),
                      pw.Container(
                        child: pw.Text(
                          "Name: " + ele.name,
                          style: pwcommonInfoStyle,
                        ),
                      ),
                      pw.Container(
                        child: pw.Text(
                          "Individual/Dept: " + ele.inddep.toString(),
                          style: pwcommonInfoStyle,
                        ),
                      ),
                      pw.Container(
                        child: pw.Text(
                          "Father/Husband Name: " + ele.fhName,
                          style: pwcommonInfoStyle,
                        ),
                      ),
                      pw.Container(
                        child: pw.Text(
                          "Relation: " + ele.relation.toString(),
                          style: pwcommonInfoStyle,
                        ),
                      ),
                      pw.Container(
                        child: pw.Text(
                          "Age: " + ele.age.toString(),
                          style: pwcommonInfoStyle,
                        ),
                      ),
                      pw.Container(
                        child: pw.Text(
                          "Gender: " + ele.gender.toString(),
                          style: pwcommonInfoStyle,
                        ),
                      ),
                      pw.Container(
                        child: pw.Text(
                          "Occupation: " + ele.occupation.toString(),
                          style: pwcommonInfoStyle,
                        ),
                      ),
                      pw.Container(
                        child: pw.Text(
                          "Caste: " + ele.caste.toString(),
                          style: pwcommonInfoStyle,
                        ),
                      ),
                      pw.Container(
                        child: pw.Text(
                          "Address: " +
                              ele.address +
                              ", " +
                              ele.city +
                              ", " +
                              ele.district +
                              ", " +
                              ele.state +
                              ", " +
                              ele.pinCode.toString(),
                          style: pwcommonInfoStyle,
                        ),
                      ),
                      pw.Container(
                        child: pw.Text(
                          "Education Qualification: " + ele.edu.toString(),
                          style: pwcommonInfoStyle,
                        ),
                      ),
                      pw.Container(
                        child: pw.Text(
                          "Mobile Number: " + ele.mobile.toString(),
                          style: pwcommonInfoStyle,
                        ),
                      ),
                      pw.Container(
                        child: pw.Text(
                          "Email: " + ele.email.toString(),
                          style: pwcommonInfoStyle,
                        ),
                      ),
                      pw.Container(
                        child: pw.Text(
                          "Status: " + ele.status.toString(),
                          style: pwcommonInfoStyle,
                        ),
                      ),
                      pw.SizedBox(
                        height: 10,
                      ),
                    ],
                  ))
              .toList(),
        ];
      }),
    );

    if (isSharing) {
      // Uint8List temp = await pdf.save();
      // List<int> intArray = List.from(temp);
      // if (!await launchUrl(Uri.parse(
      //     "data:application/octet-stream;base64,${base64Encode(List.from(intArray))}")))
      //   throw 'Could not launch';
    } else {
      Uint8List temp = await pdf.save();
      List<int> intArray = List.from(temp);
      AnchorElement(
          href:
              "data:application/octet-stream;charset=utf-16le;base64,${base64.encode(List.from(intArray))}")
        ..setAttribute("download", caseModel!.caseId + ".pdf")
        ..click();
    }
  }

  _generateExcel() {
    var excel =
        Excel.createExcel(); // automatically creates 1 empty sheet: Sheet1
    Sheet sheetObject = excel['Sheet1'];
    sheetObject.merge(
        CellIndex.indexByString("A1"), CellIndex.indexByString("A7"),
        customValue: "S.no.1");
    CellStyle cellStyle = CellStyle(verticalAlign: VerticalAlign.Center);
    var cell = sheetObject.cell(CellIndex.indexByString("A1"));
    cell.cellStyle = cellStyle;
    sheetObject.cell(CellIndex.indexByString("B1")).value = "Diary Number";
    sheetObject.cell(CellIndex.indexByString("C1")).value = caseModel!.diaryNo;
    sheetObject.cell(CellIndex.indexByString("B2")).value = "Case Number";
    sheetObject.cell(CellIndex.indexByString("C2")).value = caseModel!.caseId;
    sheetObject.cell(CellIndex.indexByString("B3")).value = "Petitioner Name";
    sheetObject.cell(CellIndex.indexByString("C3")).value =
        petitionersList[0].name;
    sheetObject.cell(CellIndex.indexByString("B4")).value = "Respondent Name";
    sheetObject.cell(CellIndex.indexByString("C4")).value =
        respondentList[0].name;
    sheetObject.cell(CellIndex.indexByString("B5")).value =
        "Petitioner's Advocate";
    sheetObject.cell(CellIndex.indexByString("C5")).value = caseModel!.petAdv;
    sheetObject.cell(CellIndex.indexByString("B6")).value =
        "Respondent's Advocate";
    sheetObject.cell(CellIndex.indexByString("C6")).value = caseModel!.resAdv;
    sheetObject.cell(CellIndex.indexByString("B7")).value = "Judgment By";
    sheetObject.cell(CellIndex.indexByString("C7")).value =
        caseModel!.judgementBy;

    excel.save(
        fileName:
            caseModel!.caseId + ".xlsx"); // dynamic values support provided;
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
