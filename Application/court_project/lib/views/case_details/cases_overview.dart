import 'package:court_project/models/case_lookup.dart';
import 'package:court_project/utils/nav_bar.dart';
import 'package:court_project/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CaseOverView extends StatefulWidget {
  const CaseOverView({Key? key}) : super(key: key);

  @override
  State<CaseOverView> createState() => _CaseOverViewState();
}

class _CaseOverViewState extends State<CaseOverView> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final sidebarDecoration = BoxDecoration(
        gradient: LinearGradient(
            colors: [Color(0xff00B4DB), Color(0xff0083B0)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter));

    return Scaffold(
        body: Responsive(
      mobile: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Container(
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
  List<CaseLookup> caseList = [
    CaseLookup(
        caseId: "123",
        hearingDate: DateTime.now(),
        petName: "Hello",
        resName: "World",
        caseType: CaseType.civil,
        filingDate: DateTime.now(),
        caseAge: 2,
        caseDescription:
            "lorem loremloremloremloremloremloremloremloremloremlorem"),
    CaseLookup(
        caseId: "124",
        hearingDate: DateTime.now(),
        petName: "Hello",
        resName: "World",
        caseType: CaseType.civil,
        filingDate: DateTime.now(),
        caseAge: 2,
        caseDescription:
            "lorem loremloremloremloremloremloremloremloremloremlorem")
  ];
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = widget.isMobile! ? 1100 : MediaQuery.of(context).size.width;

    return Container(
      height: height,
      width: width,
      color: Colors.white,
      child: Column(
        children: [
          NavBar(),
          ToolBar(
            isMobile: widget.isMobile,
          ),
          Container(
            height: height * 0.8,
            child: ListView.separated(
              padding: const EdgeInsets.all(8),
              itemCount: caseList.length,
              itemBuilder: (BuildContext context, int index) {
                return CaseLookupTile(
                  item: caseList[index],
                  isMobile: widget.isMobile,
                );
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(),
            ),
          )
        ],
      ),
    );
  }
}

class CaseLookupTile extends StatefulWidget {
  CaseLookup item;
  bool? isMobile;
  CaseLookupTile({required this.item, this.isMobile = false});

  @override
  State<CaseLookupTile> createState() => _CaseLookupTileState();
}

class _CaseLookupTileState extends State<CaseLookupTile> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = widget.isMobile! ? 1100 : MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: !isExpanded
          ? GestureDetector(
              onTap: () {
                setState(() {
                  print("Here");
                  isExpanded = !isExpanded;
                  print(isExpanded);
                });
              },
              child: Container(
                height: 60,
                decoration: BoxDecoration(
                    color: Color(0xff12294C),
                    borderRadius: BorderRadius.circular(8)),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Text(
                        "Case ID: " + widget.item.caseId,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w200),
                      ),
                      Expanded(child: Container()),
                      Text(
                        "Hearing Date: " +
                            DateFormat('dd-MM-yyyy')
                                .format(widget.item.hearingDate),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w200),
                      ),
                    ],
                  ),
                ),
              ),
            )
          : Container(
              height: 350,
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        print("Here");
                        isExpanded = !isExpanded;
                        print(isExpanded);
                      });
                    },
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                          color: Color(0xff12294C),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8),
                              topRight: Radius.circular(8))),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            Text(
                              "Case ID: " + widget.item.caseId,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w200),
                            ),
                            Expanded(child: Container()),
                            Text(
                              "Hearing Date: " +
                                  DateFormat('dd-MM-yyyy')
                                      .format(widget.item.hearingDate),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w200),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 290,
                    decoration: BoxDecoration(
                        color: Color(0xffDADFE7),
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(8),
                            bottomRight: Radius.circular(8))),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Container(
                                width: width * 0.45,
                                child: Text(
                                  "Petitioner Name: " + widget.item.petName,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              Container(
                                width: width * 0.45,
                                child: Text(
                                  "Respondent Name: " + widget.item.resName,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Container(
                                width: width * 0.45,
                                child: Text(
                                  "Case Type: " + widget.item.caseType.name,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              Container(
                                width: width * 0.45,
                                child: Text(
                                  "Filing Date: " +
                                      DateFormat('dd-MM-yyyy')
                                          .format(widget.item.filingDate),
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            child: Text(
                              "Case Age: " + widget.item.caseAge.toString(),
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            child: Text(
                              "Case Description: " +
                                  widget.item.caseDescription,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Row(
                            children: [
                              Expanded(child: Container()),
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
                                      "Document",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Icon(
                                      Icons.add,
                                      color: Colors.white,
                                    ),
                                    Expanded(child: Container()),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              GestureDetector(
                                onTap: () {
                                  showGeneralDialog(
                                    barrierLabel: "Label",
                                    barrierDismissible: true,
                                    barrierColor: Colors.black.withOpacity(0),
                                    transitionDuration:
                                        Duration(milliseconds: 700),
                                    context: context,
                                    pageBuilder: (context, anim1, anim2) {
                                      return Align(
                                        alignment: Alignment.bottomRight,
                                        child: Container(
                                          height: 400,
                                          width: 300,
                                          child: Material(
                                            color: Color(0xffE9F0FA),
                                            child: Column(
                                              children: [
                                                Container(
                                                  height: 40,
                                                  width: 300,
                                                  color: Color(0xffFFCE22),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 10),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                          'Notes',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 18),
                                                        ),
                                                        Expanded(
                                                            child: Container()),
                                                        IconButton(
                                                            onPressed: () {},
                                                            icon: Icon(
                                                                Icons.upload)),
                                                        IconButton(
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            icon: Icon(
                                                                Icons.close))
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  height: 360,
                                                  width: 300,
                                                  child: Center(
                                                    child: SizedBox(
                                                      height: 340,
                                                      width: 280,
                                                      child: TextField(
                                                        maxLines: 16,
                                                        decoration:
                                                            InputDecoration(
                                                          hintText:
                                                              "Add your note here...",
                                                          border:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5),
                                                            borderSide:
                                                                BorderSide(
                                                              width: 0,
                                                              style: BorderStyle
                                                                  .none,
                                                            ),
                                                          ),
                                                          filled: true,
                                                          fillColor:
                                                              Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          margin: EdgeInsets.only(
                                              bottom: 50, left: 12, right: 12),
                                          decoration: BoxDecoration(
                                            color: Color(0xffE9F0FA),
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                        ),
                                      );
                                    },
                                    transitionBuilder:
                                        (context, anim1, anim2, child) {
                                      return SlideTransition(
                                        position: Tween(
                                                begin: Offset(0, 1),
                                                end: Offset(0, 0))
                                            .animate(anim1),
                                        child: child,
                                      );
                                    },
                                  );
                                },
                                child: Container(
                                  width: 150,
                                  height: 40,
                                  decoration: BoxDecoration(
                                      color: Color(0xff12294C),
                                      borderRadius: BorderRadius.circular(5)),
                                  alignment: Alignment.center,
                                  child: Row(
                                    children: [
                                      Expanded(child: Container()),
                                      Text(
                                        "Notes",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Icon(
                                        Icons.add,
                                        color: Colors.white,
                                      ),
                                      Expanded(child: Container()),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Container(
                                width: 150,
                                height: 40,
                                decoration: BoxDecoration(
                                    color: Color(0xffFFCE22),
                                    borderRadius: BorderRadius.circular(5)),
                                alignment: Alignment.center,
                                child: Row(
                                  children: [
                                    Expanded(child: Container()),
                                    Text(
                                      "View More...",
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 20),
                                    ),
                                    Expanded(child: Container()),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
    );
  }
}

class ToolBar extends StatefulWidget {
  bool? isMobile;
  ToolBar({this.isMobile = false});

  @override
  State<ToolBar> createState() => _ToolBarState();
}

class _ToolBarState extends State<ToolBar> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height * 0.09;
    double width = widget.isMobile! ? 1100 : MediaQuery.of(context).size.width;

    return Container(
      height: height,
      color: Color(0xffEEEEEE),
      child: Row(
        children: [
          SizedBox(
            width: width * 0.05,
          ),
          Container(
            width: width * 0.5,
            height: 40,
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search Here...",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                  ),
                ),
                filled: true,
                fillColor: Color(0xFFDADFE7),
              ),
            ),
          ),
          SizedBox(
            width: width * 0.02,
          ),
          Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Color(0xff12294C),
            ),
            child: Icon(
              Icons.search,
              color: Colors.white,
            ),
          ),
          SizedBox(
            width: width * 0.02,
          ),
          Icon(
            Icons.layers_sharp,
            color: Color(0xff12294C),
          ),
          SizedBox(
            width: width * 0.02,
          ),
          Icon(
            Icons.filter_alt_outlined,
            color: Color(0xff12294C),
          ),
          SizedBox(
            width: width * 0.02,
          ),
          Container(
            width: width * 0.25,
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
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                SizedBox(
                  width: width * 0.02,
                ),
                Icon(
                  Icons.cloud_download_sharp,
                  color: Colors.white,
                ),
                Expanded(child: Container()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
