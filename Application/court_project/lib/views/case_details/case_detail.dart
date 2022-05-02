import 'package:court_project/utils/nav_bar.dart';
import 'package:court_project/utils/responsive.dart';
import 'package:flutter/material.dart';

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
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = widget.isMobile! ? 1100 : MediaQuery.of(context).size.width;

    return Container(
        height: height,
        width: width,
        color: Colors.white,
        child: Column(children: [
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
                    child: Text(
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
        ]));
  }
}
