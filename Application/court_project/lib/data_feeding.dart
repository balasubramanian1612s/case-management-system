import 'package:court_project/nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class DataFeeding extends StatelessWidget {
  const DataFeeding({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        height: height,
        width: width,
        color: Colors.white,
        child: Column(
          children: [
            NavBar(),
            Padding(
              padding: const EdgeInsets.all(30),
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
                    PetitionerDetails(),
                    SizedBox(
                      height: height * 0.03,
                    ),
                    RespondentDetails(),
                    SizedBox(
                      height: height * 0.03,
                    ),
                    CaseDetails(),
                    SizedBox(
                      height: height * 0.03,
                    ),
                    Row(
                      children: [
                        Container(
                          width: 200,
                          child: Text(
                            "Case Status",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                        ),
                        Container(
                          width: 400,
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
                          width: 200,
                          child: Text(
                            "Next-Hearing Date",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                        ),
                        Container(
                          width: 400,
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
                          width: 200,
                          child: Text(
                            "Case Age",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                        ),
                        Container(
                          width: 400,
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
                          width: 200,
                          child: Text(
                            "Filing Date",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                        ),
                        Container(
                          width: 400,
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
      ),
    );
  }
}

class PetitionerDetails extends StatelessWidget {
  const PetitionerDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

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
                  width: 400,
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'User Name',
                      hintText: 'Enter Your Name',
                    ),
                  ),
                ),
                SizedBox(
                  width: 500,
                ),
                Container(
                  width: 400,
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
                  width: 400,
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'User Name',
                      hintText: 'Enter Your Name',
                    ),
                  ),
                ),
                SizedBox(
                  width: 500,
                ),
                Container(
                  width: 400,
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
                  width: 400,
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'User Name',
                      hintText: 'Enter Your Name',
                    ),
                  ),
                ),
                SizedBox(
                  width: 500,
                ),
                Container(
                  width: 400,
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
  const RespondentDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

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
                  width: 400,
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'User Name',
                      hintText: 'Enter Your Name',
                    ),
                  ),
                ),
                SizedBox(
                  width: 500,
                ),
                Container(
                  width: 400,
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
                  width: 400,
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'User Name',
                      hintText: 'Enter Your Name',
                    ),
                  ),
                ),
                SizedBox(
                  width: 500,
                ),
                Container(
                  width: 400,
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
                  width: 400,
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'User Name',
                      hintText: 'Enter Your Name',
                    ),
                  ),
                ),
                SizedBox(
                  width: 500,
                ),
                Container(
                  width: 400,
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
  const CaseDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

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
                  width: 400,
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'User Name',
                      hintText: 'Enter Your Name',
                    ),
                  ),
                ),
                SizedBox(
                  width: 500,
                ),
                Container(
                  width: 400,
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
                  width: 400,
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'User Name',
                      hintText: 'Enter Your Name',
                    ),
                  ),
                ),
                SizedBox(
                  width: 500,
                ),
                Container(
                  width: 400,
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
                  width: 400,
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'User Name',
                      hintText: 'Enter Your Name',
                    ),
                  ),
                ),
                SizedBox(
                  width: 500,
                ),
                Container(
                  width: 400,
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
