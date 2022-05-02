import 'package:court_project/utils/nav_bar.dart';
import 'package:court_project/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';

enum TimelineType { caseFiled, nextHearing, documentUploaded, caseDisposal }

class CaseDetail extends StatefulWidget {
  const CaseDetail({Key? key}) : super(key: key);

  @override
  State<CaseDetail> createState() => _CaseDetailState();
}

class _CaseDetailState extends State<CaseDetail> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    const sidebarDecoration = BoxDecoration(
        gradient: LinearGradient(
            colors: [Color(0xff00B4DB), Color(0xff0083B0)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter));

    return Scaffold(
        body: Responsive(
      mobile: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SizedBox(
          width: 1100,
          child: MainWidget(
            isMobile: true,
          ),
        ),
      ),
      desktop: MainWidget(),
    ));
  }
}

class MainWidget extends StatefulWidget {
  bool? isMobile;
  MainWidget({this.isMobile = false});

  @override
  State<MainWidget> createState() => _MainWidgetState();
}

class _MainWidgetState extends State<MainWidget> {
  int selectedItem = 0;
  List timelineList = [
    TimelineItem(
        timelineType: TimelineType.caseDisposal,
        time: DateTime.now(),
        information: "Petioner files case ....some text"),
    TimelineItem(
        timelineType: TimelineType.caseFiled,
        time: DateTime.now(),
        information: "Petioner files case ....some text"),
    TimelineItem(
        timelineType: TimelineType.documentUploaded,
        time: DateTime.now(),
        information: "Petioner files case ....some text"),
    TimelineItem(
        timelineType: TimelineType.nextHearing,
        time: DateTime.now(),
        information: "Petioner files case ....some text"),
    TimelineItem(
        timelineType: TimelineType.caseDisposal,
        time: DateTime.now(),
        information: "Petioner files case ....some text"),
    TimelineItem(
        timelineType: TimelineType.caseDisposal,
        time: DateTime.now(),
        information: "Petioner files case ....some text"),
    TimelineItem(
        timelineType: TimelineType.caseFiled,
        time: DateTime.now(),
        information: "Petioner files case ....some text"),
    TimelineItem(
        timelineType: TimelineType.documentUploaded,
        time: DateTime.now(),
        information: "Petioner files case ....some text"),
    TimelineItem(
        timelineType: TimelineType.nextHearing,
        time: DateTime.now(),
        information: "Petioner files case ....some text"),
    TimelineItem(
        timelineType: TimelineType.caseDisposal,
        time: DateTime.now(),
        information: "Petioner files case ....some text"),
    TimelineItem(
        timelineType: TimelineType.caseDisposal,
        time: DateTime.now(),
        information: "Petioner files case ....some text"),
    TimelineItem(
        timelineType: TimelineType.caseFiled,
        time: DateTime.now(),
        information: "Petioner files case ....some text"),
    TimelineItem(
        timelineType: TimelineType.documentUploaded,
        time: DateTime.now(),
        information: "Petioner files case ....some text"),
    TimelineItem(
        timelineType: TimelineType.nextHearing,
        time: DateTime.now(),
        information: "Petioner files case ....some text"),
    TimelineItem(
        timelineType: TimelineType.caseDisposal,
        time: DateTime.now(),
        information: "Petioner files case ....some text"),
  ];
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
                const Text(
                  'Case Details',
                  style: TextStyle(
                      color: Color(0xff12294C),
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                Expanded(child: Container()),
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
                  height: height * 0.9 - 80,
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Case ID:',
                          style: TextStyle(
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
                              data: "1234567890",
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
                                  Text(
                                    "Share",
                                    style: TextStyle(
                                        color: Color(0xff12294C), fontSize: 20),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Icon(
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
                                  Text(
                                    "Download",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Icon(
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
                        PetitionerInfo(),
                        const SizedBox(
                          height: 20,
                        ),
                        RespondentInfo(),
                        const SizedBox(
                          height: 20,
                        ),
                        CaseInfo(),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ))
              : Container(
                  width: width,
                  height: height * 0.9 - 120,
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: SingleChildScrollView(
                      child: Column(
                    children: [...timelineList],
                  )),
                ),
        ]));
  }
}

class TimelineItem extends StatelessWidget {
  TimelineType timelineType;
  DateTime time;
  String information;
  TimelineItem(
      {required this.timelineType,
      required this.time,
      required this.information});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          DateFormat('dd-MM-yyyy hh:mm').format(time),
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          width: 10,
        ),
        Column(
          children: [
            Container(
              height: 30,
              child: VerticalDivider(
                color: Colors.black,
                thickness: 2,
              ),
            ),
            SvgPicture.asset(
              timelineType == TimelineType.nextHearing
                  ? "assets/next_hearing_indi.svg"
                  : timelineType == TimelineType.caseFiled
                      ? "assets/case_filed_indi.svg"
                      : timelineType == TimelineType.caseDisposal
                          ? "assets/case_disposal_indi.svg"
                          : "assets/documents_uploaded_indi.svg",
              height: 15,
            ),
            Container(
              height: 30,
              child: VerticalDivider(
                color: Colors.black,
                thickness: 2,
              ),
            ),
          ],
        ),
        const SizedBox(
          width: 10,
        ),
        Text(
          information,
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}

class PetitionerInfo extends StatelessWidget {
  bool isMobile;
  PetitionerInfo({this.isMobile = false});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = isMobile ? 1100 : MediaQuery.of(context).size.width;

    return Container(
      width: width,
      height: 200,
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
                  "Name: ",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.w600),
                ),
              ),
              Container(
                width: width * 0.45,
                child: Text(
                  "Date Of Birth:",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.w600),
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
                  "Father/Husband Name:",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.w600),
                ),
              ),
              Container(
                width: width * 0.45,
                child: Text(
                  "Address:",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.w600),
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
                  "Gender:",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.w600),
                ),
              ),
              Container(
                width: width * 0.45,
                child: Text(
                  "Age:",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.w600),
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
  RespondentInfo({this.isMobile = false});
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = isMobile ? 1100 : MediaQuery.of(context).size.width;

    return Container(
      width: width,
      height: 200,
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
                  "Name: ",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.w600),
                ),
              ),
              Container(
                width: width * 0.45,
                child: Text(
                  "Date Of Birth:",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.w600),
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
                  "Father/Husband Name:",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.w600),
                ),
              ),
              Container(
                width: width * 0.45,
                child: Text(
                  "Address:",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.w600),
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
                  "Gender:",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.w600),
                ),
              ),
              Container(
                width: width * 0.45,
                child: Text(
                  "Age:",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.w600),
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
  CaseInfo({this.isMobile = false});

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
                  "Case Number: ",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.w600),
                ),
              ),
              Container(
                width: width * 0.45,
                child: Text(
                  "Petitioner’s Advocate:",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.w600),
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
                  "Diary Number:",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.w600),
                ),
              ),
              Container(
                width: width * 0.45,
                child: Text(
                  "Respondent’s Advocate:",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.w600),
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
                  "Next Hearing:",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.w600),
                ),
              ),
              Container(
                width: width * 0.45,
                child: Text(
                  "Filing Date:",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.w600),
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
                  "Judgement By:",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.w600),
                ),
              ),
              Container(
                width: width * 0.45,
                child: Text(
                  "Case Age:",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.w600),
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
                  "Court:",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.w600),
                ),
              ),
              Container(
                width: width * 0.45,
                child: Text(
                  "Status:",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
