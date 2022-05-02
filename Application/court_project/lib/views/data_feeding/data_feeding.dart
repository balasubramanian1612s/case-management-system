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

class PetitionerDetails extends StatefulWidget {
  bool? isMobile;
  PetitionerDetails({this.isMobile = false});

  @override
  State<PetitionerDetails> createState() => _PetitionerDetailsState();
}

class _PetitionerDetailsState extends State<PetitionerDetails> {
  int? _ratingController;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = widget.isMobile! ? 1100 : MediaQuery.of(context).size.width;

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Petitioner Details",
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const Divider(
            color: Colors.black,
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            width: width,
            height: 80,
            child: Row(
              children: [
                SizedBox(
                  width: width * 0.2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Name:',
                        style: TextStyle(fontSize: 18),
                      ),
                      Spacer(),
                      TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: width * 0.3,
                ),
                SizedBox(
                  width: width * 0.2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Individual/Dept:',
                        style: TextStyle(fontSize: 18),
                      ),
                      const Spacer(),
                      DropdownButtonFormField<int>(
                        decoration: InputDecoration(
                            errorStyle: const TextStyle(
                                color: Colors.redAccent, fontSize: 16.0),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0))),
                        value: _ratingController,
                        items: [1, 2, 3, 4, 5]
                            .map((label) => DropdownMenuItem(
                                  child: Text(label.toString()),
                                  value: label,
                                ))
                            .toList(),
                        hint: const Text('Rating'),
                        onChanged: (int? value) {
                          setState(() {
                            _ratingController = value!;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            width: width,
            height: 80,
            child: Row(
              children: [
                SizedBox(
                  width: width * 0.2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Father/Husband Name: ',
                        style: TextStyle(fontSize: 18),
                      ),
                      Spacer(),
                      TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: width * 0.3,
                ),
                SizedBox(
                  width: width * 0.2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Relation: ',
                        style: TextStyle(fontSize: 18),
                      ),
                      Spacer(),
                      TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            width: width,
            height: 80,
            child: Row(
              children: [
                SizedBox(
                  width: width * 0.2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Age:',
                        style: TextStyle(fontSize: 18),
                      ),
                      Spacer(),
                      TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: width * 0.3,
                ),
                SizedBox(
                  width: width * 0.2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Gender:',
                        style: TextStyle(fontSize: 18),
                      ),
                      const Spacer(),
                      DropdownButtonFormField<int>(
                        decoration: InputDecoration(
                            errorStyle: const TextStyle(
                                color: Colors.redAccent, fontSize: 16.0),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0))),
                        value: _ratingController,
                        items: [1, 2, 3, 4, 5]
                            .map((label) => DropdownMenuItem(
                                  child: Text(label.toString()),
                                  value: label,
                                ))
                            .toList(),
                        hint: const Text('Rating'),
                        onChanged: (int? value) {
                          setState(() {
                            _ratingController = value!;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            width: width,
            height: 80,
            child: Row(
              children: [
                SizedBox(
                  width: width * 0.2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Occupation:',
                        style: TextStyle(fontSize: 18),
                      ),
                      Spacer(),
                      TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: width * 0.3,
                ),
                SizedBox(
                  width: width * 0.2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Caste:',
                        style: TextStyle(fontSize: 18),
                      ),
                      Spacer(),
                      TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            width: width,
            height: 80,
            child: Row(
              children: [
                SizedBox(
                  width: width * 0.2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Address: ',
                        style: TextStyle(fontSize: 18),
                      ),
                      Spacer(),
                      TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: width * 0.3,
                ),
                SizedBox(
                  width: width * 0.2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Education/Qualification:',
                        style: TextStyle(fontSize: 18),
                      ),
                      Spacer(),
                      TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            width: width,
            height: 80,
            child: Row(
              children: [
                SizedBox(
                  width: width * 0.2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Country:',
                        style: TextStyle(fontSize: 18),
                      ),
                      const Spacer(),
                      DropdownButtonFormField<int>(
                        decoration: InputDecoration(
                            errorStyle: const TextStyle(
                                color: Colors.redAccent, fontSize: 16.0),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0))),
                        value: _ratingController,
                        items: [1, 2, 3, 4, 5]
                            .map((label) => DropdownMenuItem(
                                  child: Text(label.toString()),
                                  value: label,
                                ))
                            .toList(),
                        hint: const Text('Rating'),
                        onChanged: (int? value) {
                          setState(() {
                            _ratingController = value!;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: width * 0.3,
                ),
                SizedBox(
                  width: width * 0.2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Place/City:',
                        style: TextStyle(fontSize: 18),
                      ),
                      Spacer(),
                      TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            width: width,
            height: 80,
            child: Row(
              children: [
                SizedBox(
                  width: width * 0.2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'State:',
                        style: TextStyle(fontSize: 18),
                      ),
                      const Spacer(),
                      DropdownButtonFormField<int>(
                        decoration: InputDecoration(
                            errorStyle: const TextStyle(
                                color: Colors.redAccent, fontSize: 16.0),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0))),
                        value: _ratingController,
                        items: [1, 2, 3, 4, 5]
                            .map((label) => DropdownMenuItem(
                                  child: Text(label.toString()),
                                  value: label,
                                ))
                            .toList(),
                        hint: const Text('Rating'),
                        onChanged: (int? value) {
                          setState(() {
                            _ratingController = value!;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: width * 0.3,
                ),
                SizedBox(
                  width: width * 0.2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'District:',
                        style: TextStyle(fontSize: 18),
                      ),
                      const Spacer(),
                      DropdownButtonFormField<int>(
                        decoration: InputDecoration(
                            errorStyle: const TextStyle(
                                color: Colors.redAccent, fontSize: 16.0),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0))),
                        value: _ratingController,
                        items: [1, 2, 3, 4, 5]
                            .map((label) => DropdownMenuItem(
                                  child: Text(label.toString()),
                                  value: label,
                                ))
                            .toList(),
                        hint: const Text('Rating'),
                        onChanged: (int? value) {
                          setState(() {
                            _ratingController = value!;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            width: width,
            height: 80,
            child: Row(
              children: [
                SizedBox(
                  width: width * 0.2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Pincode: ',
                        style: TextStyle(fontSize: 18),
                      ),
                      Spacer(),
                      TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: width * 0.3,
                ),
                SizedBox(
                  width: width * 0.2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Mobile Number: ',
                        style: TextStyle(fontSize: 18),
                      ),
                      Spacer(),
                      TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            width: width,
            height: 80,
            child: Row(
              children: [
                SizedBox(
                  width: width * 0.2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Email: ',
                        style: TextStyle(fontSize: 18),
                      ),
                      Spacer(),
                      TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: width * 0.3,
                ),
                SizedBox(
                  width: width * 0.2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Status:',
                        style: TextStyle(fontSize: 18),
                      ),
                      const Spacer(),
                      DropdownButtonFormField<int>(
                        decoration: InputDecoration(
                            errorStyle: const TextStyle(
                                color: Colors.redAccent, fontSize: 16.0),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0))),
                        value: _ratingController,
                        items: [1, 2, 3, 4, 5]
                            .map((label) => DropdownMenuItem(
                                  child: Text(label.toString()),
                                  value: label,
                                ))
                            .toList(),
                        hint: const Text('Rating'),
                        onChanged: (int? value) {
                          setState(() {
                            _ratingController = value!;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            width: width,
            height: 150,
            child: Row(children: [
              SizedBox(
                width: width * 0.2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Remarks for update:',
                      style: TextStyle(fontSize: 18),
                    ),
                    Spacer(),
                    TextField(
                      maxLines: 5,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}

class RespondentDetails extends StatefulWidget {
  bool? isMobile;
  RespondentDetails({this.isMobile = false});

  @override
  State<RespondentDetails> createState() => _RespondentDetailsState();
}

class _RespondentDetailsState extends State<RespondentDetails> {
  int? _ratingController;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = widget.isMobile! ? 1100 : MediaQuery.of(context).size.width;

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Respondent Details",
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const Divider(
            color: Colors.black,
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            width: width,
            height: 80,
            child: Row(
              children: [
                SizedBox(
                  width: width * 0.2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Name:',
                        style: TextStyle(fontSize: 18),
                      ),
                      Spacer(),
                      TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: width * 0.3,
                ),
                SizedBox(
                  width: width * 0.2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Individual/Dept:',
                        style: TextStyle(fontSize: 18),
                      ),
                      const Spacer(),
                      DropdownButtonFormField<int>(
                        decoration: InputDecoration(
                            errorStyle: const TextStyle(
                                color: Colors.redAccent, fontSize: 16.0),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0))),
                        value: _ratingController,
                        items: [1, 2, 3, 4, 5]
                            .map((label) => DropdownMenuItem(
                                  child: Text(label.toString()),
                                  value: label,
                                ))
                            .toList(),
                        hint: const Text('Rating'),
                        onChanged: (int? value) {
                          setState(() {
                            _ratingController = value!;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            width: width,
            height: 80,
            child: Row(
              children: [
                SizedBox(
                  width: width * 0.2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Father/Husband Name: ',
                        style: TextStyle(fontSize: 18),
                      ),
                      Spacer(),
                      TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: width * 0.3,
                ),
                SizedBox(
                  width: width * 0.2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Relation: ',
                        style: TextStyle(fontSize: 18),
                      ),
                      Spacer(),
                      TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            width: width,
            height: 80,
            child: Row(
              children: [
                SizedBox(
                  width: width * 0.2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Age:',
                        style: TextStyle(fontSize: 18),
                      ),
                      Spacer(),
                      TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: width * 0.3,
                ),
                SizedBox(
                  width: width * 0.2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Gender:',
                        style: TextStyle(fontSize: 18),
                      ),
                      const Spacer(),
                      DropdownButtonFormField<int>(
                        decoration: InputDecoration(
                            errorStyle: const TextStyle(
                                color: Colors.redAccent, fontSize: 16.0),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0))),
                        value: _ratingController,
                        items: [1, 2, 3, 4, 5]
                            .map((label) => DropdownMenuItem(
                                  child: Text(label.toString()),
                                  value: label,
                                ))
                            .toList(),
                        hint: const Text('Rating'),
                        onChanged: (int? value) {
                          setState(() {
                            _ratingController = value!;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            width: width,
            height: 80,
            child: Row(
              children: [
                SizedBox(
                  width: width * 0.2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Occupation:',
                        style: TextStyle(fontSize: 18),
                      ),
                      Spacer(),
                      TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: width * 0.3,
                ),
                SizedBox(
                  width: width * 0.2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Caste:',
                        style: TextStyle(fontSize: 18),
                      ),
                      Spacer(),
                      TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            width: width,
            height: 80,
            child: Row(
              children: [
                SizedBox(
                  width: width * 0.2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Address: ',
                        style: TextStyle(fontSize: 18),
                      ),
                      Spacer(),
                      TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: width * 0.3,
                ),
                SizedBox(
                  width: width * 0.2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Education/Qualification:',
                        style: TextStyle(fontSize: 18),
                      ),
                      Spacer(),
                      TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            width: width,
            height: 80,
            child: Row(
              children: [
                SizedBox(
                  width: width * 0.2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Country:',
                        style: TextStyle(fontSize: 18),
                      ),
                      const Spacer(),
                      DropdownButtonFormField<int>(
                        decoration: InputDecoration(
                            errorStyle: const TextStyle(
                                color: Colors.redAccent, fontSize: 16.0),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0))),
                        value: _ratingController,
                        items: [1, 2, 3, 4, 5]
                            .map((label) => DropdownMenuItem(
                                  child: Text(label.toString()),
                                  value: label,
                                ))
                            .toList(),
                        hint: const Text('Rating'),
                        onChanged: (int? value) {
                          setState(() {
                            _ratingController = value!;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: width * 0.3,
                ),
                SizedBox(
                  width: width * 0.2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Place/City:',
                        style: TextStyle(fontSize: 18),
                      ),
                      Spacer(),
                      TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            width: width,
            height: 80,
            child: Row(
              children: [
                SizedBox(
                  width: width * 0.2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'State:',
                        style: TextStyle(fontSize: 18),
                      ),
                      const Spacer(),
                      DropdownButtonFormField<int>(
                        decoration: InputDecoration(
                            errorStyle: const TextStyle(
                                color: Colors.redAccent, fontSize: 16.0),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0))),
                        value: _ratingController,
                        items: [1, 2, 3, 4, 5]
                            .map((label) => DropdownMenuItem(
                                  child: Text(label.toString()),
                                  value: label,
                                ))
                            .toList(),
                        hint: const Text('Rating'),
                        onChanged: (int? value) {
                          setState(() {
                            _ratingController = value!;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: width * 0.3,
                ),
                SizedBox(
                  width: width * 0.2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'District:',
                        style: TextStyle(fontSize: 18),
                      ),
                      const Spacer(),
                      DropdownButtonFormField<int>(
                        decoration: InputDecoration(
                            errorStyle: const TextStyle(
                                color: Colors.redAccent, fontSize: 16.0),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0))),
                        value: _ratingController,
                        items: [1, 2, 3, 4, 5]
                            .map((label) => DropdownMenuItem(
                                  child: Text(label.toString()),
                                  value: label,
                                ))
                            .toList(),
                        hint: const Text('Rating'),
                        onChanged: (int? value) {
                          setState(() {
                            _ratingController = value!;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            width: width,
            height: 80,
            child: Row(
              children: [
                SizedBox(
                  width: width * 0.2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Pincode: ',
                        style: TextStyle(fontSize: 18),
                      ),
                      Spacer(),
                      TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: width * 0.3,
                ),
                SizedBox(
                  width: width * 0.2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Mobile Number: ',
                        style: TextStyle(fontSize: 18),
                      ),
                      Spacer(),
                      TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            width: width,
            height: 80,
            child: Row(
              children: [
                SizedBox(
                  width: width * 0.2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Email: ',
                        style: TextStyle(fontSize: 18),
                      ),
                      Spacer(),
                      TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: width * 0.3,
                ),
                SizedBox(
                  width: width * 0.2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Status:',
                        style: TextStyle(fontSize: 18),
                      ),
                      const Spacer(),
                      DropdownButtonFormField<int>(
                        decoration: InputDecoration(
                            errorStyle: const TextStyle(
                                color: Colors.redAccent, fontSize: 16.0),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0))),
                        value: _ratingController,
                        items: [1, 2, 3, 4, 5]
                            .map((label) => DropdownMenuItem(
                                  child: Text(label.toString()),
                                  value: label,
                                ))
                            .toList(),
                        hint: const Text('Rating'),
                        onChanged: (int? value) {
                          setState(() {
                            _ratingController = value!;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            width: width,
            height: 150,
            child: Row(children: [
              SizedBox(
                width: width * 0.2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Remarks for update:',
                      style: TextStyle(fontSize: 18),
                    ),
                    Spacer(),
                    TextField(
                      maxLines: 5,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}

class CaseDetails extends StatefulWidget {
  bool? isMobile;
  CaseDetails({this.isMobile = false});

  @override
  State<CaseDetails> createState() => _CaseDetailsState();
}

class _CaseDetailsState extends State<CaseDetails> {
  int? _ratingController;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = widget.isMobile! ? 1100 : MediaQuery.of(context).size.width;

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Case Details",
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const Divider(
            color: Colors.black,
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            width: width,
            height: 80,
            child: Row(
              children: [
                SizedBox(
                  width: width * 0.2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Case No:',
                        style: TextStyle(fontSize: 18),
                      ),
                      Spacer(),
                      TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: width * 0.3,
                ),
                SizedBox(
                  width: width * 0.2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Case Type:',
                        style: TextStyle(fontSize: 18),
                      ),
                      const Spacer(),
                      DropdownButtonFormField<int>(
                        decoration: InputDecoration(
                            errorStyle: const TextStyle(
                                color: Colors.redAccent, fontSize: 16.0),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0))),
                        value: _ratingController,
                        items: [1, 2, 3, 4, 5]
                            .map((label) => DropdownMenuItem(
                                  child: Text(label.toString()),
                                  value: label,
                                ))
                            .toList(),
                        hint: const Text('Rating'),
                        onChanged: (int? value) {
                          setState(() {
                            _ratingController = value!;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            width: width,
            height: 80,
            child: Row(
              children: [
                SizedBox(
                  width: width * 0.2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Diary Numbers: ',
                        style: TextStyle(fontSize: 18),
                      ),
                      Spacer(),
                      TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: width * 0.3,
                ),
                SizedBox(
                  width: width * 0.2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Petitioner Adv: ',
                        style: TextStyle(fontSize: 18),
                      ),
                      Spacer(),
                      TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            width: width,
            height: 80,
            child: Row(
              children: [
                SizedBox(
                  width: width * 0.2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Respondent Adv: ',
                        style: TextStyle(fontSize: 18),
                      ),
                      Spacer(),
                      TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: width * 0.3,
                ),
                SizedBox(
                  width: width * 0.2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Judgement by: ',
                        style: TextStyle(fontSize: 18),
                      ),
                      Spacer(),
                      TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            width: width,
            height: 150,
            child: Row(children: [
              SizedBox(
                width: width * 0.2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Earlier court details if any:',
                      style: TextStyle(fontSize: 18),
                    ),
                    Spacer(),
                    TextField(
                      maxLines: 5,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
