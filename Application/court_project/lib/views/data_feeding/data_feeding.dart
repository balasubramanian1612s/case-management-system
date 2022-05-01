import 'package:court_project/utils/nav_bar.dart';
import 'package:court_project/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class DataFeeding extends StatelessWidget {
  const DataFeeding({Key? key}) : super(key: key);

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
          child: MainWidgrt(
            isMobile: true,
          ),
        ),
      ),
      desktop: MainWidgrt(),
    ));
  }
}

class MainWidgrt extends StatefulWidget {
  bool? isMobile;
  MainWidgrt({this.isMobile = false});

  @override
  State<MainWidgrt> createState() => _MainWidgrtState();
}

class _MainWidgrtState extends State<MainWidgrt> {
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
          Padding(
            padding: EdgeInsets.all(30),
            child: Container(
              height: height * 0.91 - 60,
              width: width,
              child: ListView(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Case Details",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  PetitionerDetails(
                    isMobile: widget.isMobile,
                  ),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  RespondentDetails(
                    isMobile: widget.isMobile,
                  ),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  CaseDetails(
                    isMobile: widget.isMobile,
                  ),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  Row(
                    children: [
                      Container(
                        width: width * 0.1,
                        child: Text(
                          "Case Status",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                      ),
                      Container(
                        width: width * 0.2,
                        child: TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'User Name',
                            hintText: 'Enter Your Name',
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height * 0.02,
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
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'User Name',
                            hintText: 'Enter Your Name',
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Row(
                    children: [
                      Container(
                        width: width * 0.1,
                        child: Text(
                          "Case Age",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                      ),
                      Container(
                        width: width * 0.2,
                        child: TextField(
                          decoration: InputDecoration(
                            fillColor: Colors.grey,
                            border: OutlineInputBorder(),
                            labelText: 'User Name',
                            hintText: 'Enter Your Name',
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Row(
                    children: [
                      Container(
                        width: width * 0.1,
                        child: Text(
                          "Filing Date",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                      ),
                      Container(
                        width: width * 0.2,
                        child: TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'User Name',
                            hintText: 'Enter Your Name',
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class PetitionerDetails extends StatelessWidget {
  bool? isMobile;
  PetitionerDetails({this.isMobile = false});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = isMobile! ? 800 : MediaQuery.of(context).size.width;

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Petitioner Details",
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
          ),
          Divider(
            color: Colors.black,
          ),
          Container(
            width: width,
            height: 80,
            child: Row(
              children: [
                Container(
                  width: width * 0.2,
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'User Name',
                      hintText: 'Enter Your Name',
                    ),
                  ),
                ),
                SizedBox(
                  width: width * 0.3,
                ),
                Container(
                  width: width * 0.2,
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'User Name',
                      hintText: 'Enter Your Name',
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: width,
            height: 80,
            child: Row(
              children: [
                Container(
                  width: width * 0.2,
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'User Name',
                      hintText: 'Enter Your Name',
                    ),
                  ),
                ),
                SizedBox(
                  width: width * 0.3,
                ),
                Container(
                  width: width * 0.2,
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'User Name',
                      hintText: 'Enter Your Name',
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: width,
            height: 80,
            child: Row(
              children: [
                Container(
                  width: width * 0.2,
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'User Name',
                      hintText: 'Enter Your Name',
                    ),
                  ),
                ),
                SizedBox(
                  width: width * 0.3,
                ),
                Container(
                  width: width * 0.2,
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'User Name',
                      hintText: 'Enter Your Name',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class RespondentDetails extends StatelessWidget {
  bool? isMobile;
  RespondentDetails({this.isMobile = false});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = isMobile! ? 800 : MediaQuery.of(context).size.width;

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Respondent Details",
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
          ),
          Divider(
            color: Colors.black,
          ),
          Container(
            width: width,
            height: 80,
            child: Row(
              children: [
                Container(
                  width: width * 0.2,
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'User Name',
                      hintText: 'Enter Your Name',
                    ),
                  ),
                ),
                SizedBox(
                  width: width * 0.3,
                ),
                Container(
                  width: width * 0.2,
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'User Name',
                      hintText: 'Enter Your Name',
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: width,
            height: 80,
            child: Row(
              children: [
                Container(
                  width: width * 0.2,
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'User Name',
                      hintText: 'Enter Your Name',
                    ),
                  ),
                ),
                SizedBox(
                  width: width * 0.3,
                ),
                Container(
                  width: width * 0.2,
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'User Name',
                      hintText: 'Enter Your Name',
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: width,
            height: 80,
            child: Row(
              children: [
                Container(
                  width: width * 0.2,
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'User Name',
                      hintText: 'Enter Your Name',
                    ),
                  ),
                ),
                SizedBox(
                  width: width * 0.3,
                ),
                Container(
                  width: width * 0.2,
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'User Name',
                      hintText: 'Enter Your Name',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CaseDetails extends StatelessWidget {
  bool? isMobile;
  CaseDetails({this.isMobile = false});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = isMobile! ? 800 : MediaQuery.of(context).size.width;
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Case Details",
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
          ),
          Divider(
            color: Colors.black,
          ),
          Container(
            width: width,
            height: 80,
            child: Row(
              children: [
                Container(
                  width: width * 0.2,
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'User Name',
                      hintText: 'Enter Your Name',
                    ),
                  ),
                ),
                SizedBox(
                  width: width * 0.3,
                ),
                Container(
                  width: width * 0.2,
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'User Name',
                      hintText: 'Enter Your Name',
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: width,
            height: 80,
            child: Row(
              children: [
                Container(
                  width: width * 0.2,
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'User Name',
                      hintText: 'Enter Your Name',
                    ),
                  ),
                ),
                SizedBox(
                  width: width * 0.3,
                ),
                Container(
                  width: width * 0.2,
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'User Name',
                      hintText: 'Enter Your Name',
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: width,
            height: 80,
            child: Row(
              children: [
                Container(
                  width: width * 0.2,
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'User Name',
                      hintText: 'Enter Your Name',
                    ),
                  ),
                ),
                SizedBox(
                  width: width * 0.3,
                ),
                Container(
                  width: width * 0.2,
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'User Name',
                      hintText: 'Enter Your Name',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
