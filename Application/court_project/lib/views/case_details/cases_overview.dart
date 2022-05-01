import 'package:court_project/utils/nav_bar.dart';
import 'package:court_project/utils/responsive.dart';
import 'package:flutter/material.dart';

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
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = widget.isMobile! ? 1100 : MediaQuery.of(context).size.width;

    return Container(
      height: height,
      width: width,
      color: Colors.white,
      child: Column(
        children: [NavBar(), ToolBar()],
      ),
    );
  }
}

class ToolBar extends StatefulWidget {
  const ToolBar({Key? key}) : super(key: key);

  @override
  State<ToolBar> createState() => _ToolBarState();
}

class _ToolBarState extends State<ToolBar> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height * 0.09;
    double width = MediaQuery.of(context).size.width;

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
            width: width * 0.01,
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
            width: width * 0.01,
          ),
          Icon(
            Icons.layers_sharp,
            color: Color(0xff12294C),
          ),
          SizedBox(
            width: width * 0.01,
          ),
          Icon(
            Icons.filter_alt_outlined,
            color: Color(0xff12294C),
          ),
        ],
      ),
    );
  }
}
