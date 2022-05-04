import 'dart:async';
import 'dart:convert';

import 'package:court_project/models/case_model.dart';
import 'package:court_project/models/petitioner_model.dart';
import 'package:court_project/models/respondent_model.dart';
import 'package:court_project/utils/nav_bar.dart';
import 'package:court_project/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

TextEditingController caseNoController = TextEditingController();

class DataFeeding extends StatelessWidget {
  const DataFeeding({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

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
  var uuid = const Uuid();

  // Map<Key, PetitionerModel> petitionerList = {};
  // Map<Key, RespondantModel> respondantList = {};

  List<PetitionerModel> petitionerList = [];
  List<RespondantModel> respondantList = [];

  void uploadData(CaseModel newCase, List<PetitionerModel> petitioners,
      List<RespondantModel> respondants) async {
    String payload = jsonEncode({
      "case": newCase,
      "petitioners": petitioners,
      "respondents": respondants
    });

    var response = await http.post(
      Uri.parse("http://127.0.0.1/cms/add_case.php"),
      body: payload,
    );

    var serverResponse = jsonDecode(response.body);

    if (serverResponse["success"] == true) {
      showDialog(
        context: context,
        builder: (_) => const AlertDialog(
          title: Text("Success."),
          content: Text(
            "The new case and the corresponding details were uploaded successfully.",
          ),
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (_) => const AlertDialog(
          title: Text("Assserion Failed."),
          content: Text(
            "Something went wrong. Please try again.",
          ),
        ),
      );
    }
  }

  List<Widget> petitionerWidgetList = [];
  List<Widget> respondantWidgetList = [];
  CaseModel? caseModel;
  int petKeyValue = 1;
  int resKeyValue = 1;

  @override
  void initState() {
    petitionerWidgetList = [
      PetitionerDetails(
        // key: Key(petKeyValue.toString()),
        isMobile: widget.isMobile,
        updatePetitioner: (PetitionerModel pet) {
          setState(() {
            // petitionerList.addAll({key_: pet});
            petitionerList.add(pet);
          });
        },
        uuid: uuid,
      ),
    ];

    respondantWidgetList = [
      RespondentDetails(
        // key: Key(resKeyValue.toString()),
        isMobile: widget.isMobile,
        updateRespondent: (RespondantModel res) {
          respondantList.add(res);
          // setState(() {
          //   respondantList.addAll({key_: res});
          // });
        },
        uuid: uuid,
      ),
    ];
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
      child: Column(
        children: [
          NavBar(),
          Padding(
            padding: EdgeInsets.all(30),
            child: Container(
              height: height * 0.91 - 100,
              width: width,
              child: ListView(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                children: [
                  const Text(
                    "Case Details",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  CaseDetails(
                    isMobile: widget.isMobile,
                    updateCase: (CaseModel cas) {
                      setState(() {
                        caseModel = cas;
                      });
                      print("Updated: " + caseModel.toString());
                    },
                    uuid: uuid,
                  ),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  ...petitionerWidgetList,
                  SizedBox(
                    height: height * 0.03,
                    child: Row(
                      children: [
                        Expanded(child: Container()),
                        TextButton(
                            onPressed: () {
                              print("Added new");
                              setState(() {
                                petKeyValue += 1;
                              });
                              setState(() {
                                petitionerWidgetList.add(PetitionerDetails(
                                  // key: Key(petKeyValue.toString()),
                                  isMobile: widget.isMobile,
                                  updatePetitioner: (PetitionerModel pet) {
                                    setState(() {
                                      petitionerList.add(pet);
                                      // petitionerList.addAll({key_: pet});
                                    });
                                  },
                                  uuid: uuid,
                                ));
                              });

                              print(petitionerWidgetList.length);
                            },
                            child: Text('Add New Petitioner'))
                      ],
                    ),
                  ),
                  ...respondantWidgetList,
                  SizedBox(
                    height: height * 0.03,
                    child: Row(
                      children: [
                        Expanded(child: Container()),
                        TextButton(
                            onPressed: () {
                              setState(() {
                                resKeyValue += 1;
                              });
                              setState(() {
                                respondantWidgetList.add(RespondentDetails(
                                  // key: Key(resKeyValue.toString()),
                                  isMobile: widget.isMobile,
                                  updateRespondent: (RespondantModel res) {
                                    setState(() {
                                      respondantList.add(res);
                                      // respondantList.addAll({key_: res});
                                    });
                                  },
                                  uuid: uuid,
                                ));
                              });
                            },
                            child: Text('Add New Respondant'))
                      ],
                    ),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Row(
                    children: [
                      Expanded(child: Container()),
                      InkWell(
                        onTap: () {
                          print(petitionerList);
                          print(respondantList);
                          uploadData(
                              caseModel!, petitionerList, respondantList);
                          setState(() {});
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
                              Text(
                                "Save",
                                style: TextStyle(
                                    color: Color(0xff12294C), fontSize: 20),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Icon(
                                Icons.save,
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
                              "Complete",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
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
                      Expanded(child: Container()),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PetitionerDetails extends StatefulWidget {
  bool? isMobile;
  Function updatePetitioner;
  Uuid uuid;

  PetitionerDetails({
    this.isMobile = false,
    required this.updatePetitioner,
    required this.uuid,
  });

  @override
  State<PetitionerDetails> createState() => _PetitionerDetailsState();
}

class _PetitionerDetailsState extends State<PetitionerDetails>
    with AutomaticKeepAliveClientMixin<PetitionerDetails> {
  @override
  bool get wantKeepAlive => true;

  String? deptController;
  String? genderController;
  String? countryController;
  String? stateController;
  String? districtController;
  String? statusController;
  TextEditingController nameController = TextEditingController();
  TextEditingController fnameController = TextEditingController();
  TextEditingController relationController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController occupationController = TextEditingController();
  TextEditingController casteController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController eduController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController pincodeController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController remarksController = TextEditingController();
  bool isClicked = false;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = widget.isMobile! ? 1100 : MediaQuery.of(context).size.width;

    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                "Petitioner Details",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
              Expanded(child: Container()),
              TextButton(
                  onPressed: isClicked
                      ? null
                      : () {
                          setState(() {
                            int age = int.parse(ageController.text);
                            int pincode = int.parse(pincodeController.text);
                            int mobile = int.parse(mobileController.text);
                            widget.updatePetitioner(PetitionerModel(
                              caseId: caseNoController.text,
                              userId: widget.uuid.v4(),
                              name: nameController.text,
                              fhName: fnameController.text,
                              age: age,
                              occupation: occupationController.text,
                              address: addressController.text,
                              country: countryController!,
                              state: stateController!,
                              pinCode: pincode,
                              email: emailController.text,
                              remarks: remarksController.text,
                              inddep: deptController == "Individual" ? 0 : 1,
                              relation: relationController.text,
                              gender: genderController!,
                              edu: eduController.text,
                              district: districtController!,
                              mobile: mobile,
                              status: statusController!,
                              city: cityController.text,
                              caste: casteController.text,
                            ));
                            isClicked = true;
                          });
                        },
                  child: Text('Save'))
            ],
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
                    children: [
                      const Text(
                        'Name:',
                        style: TextStyle(fontSize: 18),
                      ),
                      const Spacer(),
                      TextField(
                        onSubmitted: (value) {
                          nameController.text = value;
                        },
                        controller: nameController,
                        decoration: const InputDecoration(
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
                      DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                            errorStyle: const TextStyle(
                                color: Colors.redAccent, fontSize: 16.0),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0))),
                        value: deptController,
                        items: ["Individual", "Dept"]
                            .map((label) => DropdownMenuItem(
                                  child: Text(label.toString()),
                                  value: label,
                                ))
                            .toList(),
                        hint: const Text('Individual/Dept'),
                        onChanged: (String? value) {
                          setState(() {
                            deptController = value!;
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
                    children: [
                      Text(
                        'Father/Husband Name: ',
                        style: TextStyle(fontSize: 18),
                      ),
                      Spacer(),
                      TextField(
                        controller: fnameController,
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
                      Text(
                        'Relation: ',
                        style: TextStyle(fontSize: 18),
                      ),
                      Spacer(),
                      TextField(
                        controller: relationController,
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
                      Text(
                        'Age:',
                        style: TextStyle(fontSize: 18),
                      ),
                      Spacer(),
                      TextField(
                        controller: ageController,
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
                      DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                            errorStyle: const TextStyle(
                                color: Colors.redAccent, fontSize: 16.0),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0))),
                        value: genderController,
                        items: ["Male", "Female"]
                            .map((label) => DropdownMenuItem(
                                  child: Text(label.toString()),
                                  value: label,
                                ))
                            .toList(),
                        hint: const Text('Gender'),
                        onChanged: (String? value) {
                          setState(() {
                            genderController = value!;
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
                    children: [
                      Text(
                        'Occupation:',
                        style: TextStyle(fontSize: 18),
                      ),
                      Spacer(),
                      TextField(
                        controller: occupationController,
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
                      Text(
                        'Caste:',
                        style: TextStyle(fontSize: 18),
                      ),
                      Spacer(),
                      TextField(
                        controller: casteController,
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
                      Text(
                        'Address: ',
                        style: TextStyle(fontSize: 18),
                      ),
                      Spacer(),
                      TextField(
                        controller: addressController,
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
                      Text(
                        'Education/Qualification:',
                        style: TextStyle(fontSize: 18),
                      ),
                      Spacer(),
                      TextField(
                        controller: eduController,
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
                      DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                            errorStyle: const TextStyle(
                                color: Colors.redAccent, fontSize: 16.0),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0))),
                        value: countryController,
                        items: ["Country 1", "Country 2"]
                            .map((label) => DropdownMenuItem(
                                  child: Text(label.toString()),
                                  value: label,
                                ))
                            .toList(),
                        hint: const Text('Country'),
                        onChanged: (String? value) {
                          setState(() {
                            countryController = value!;
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
                      Text(
                        'Place/City:',
                        style: TextStyle(fontSize: 18),
                      ),
                      Spacer(),
                      TextField(
                        controller: cityController,
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
                      DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                            errorStyle: const TextStyle(
                                color: Colors.redAccent, fontSize: 16.0),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0))),
                        value: stateController,
                        items: ["State 1", "State 2"]
                            .map((label) => DropdownMenuItem(
                                  child: Text(label.toString()),
                                  value: label,
                                ))
                            .toList(),
                        hint: const Text('State'),
                        onChanged: (String? value) {
                          setState(() {
                            stateController = value!;
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
                      DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                            errorStyle: const TextStyle(
                                color: Colors.redAccent, fontSize: 16.0),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0))),
                        value: districtController,
                        items: ["District 1", "District 2"]
                            .map((label) => DropdownMenuItem(
                                  child: Text(label.toString()),
                                  value: label,
                                ))
                            .toList(),
                        hint: const Text('District'),
                        onChanged: (String? value) {
                          setState(() {
                            districtController = value!;
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
                    children: [
                      Text(
                        'Pincode: ',
                        style: TextStyle(fontSize: 18),
                      ),
                      Spacer(),
                      TextField(
                        controller: pincodeController,
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
                      Text(
                        'Mobile Number: ',
                        style: TextStyle(fontSize: 18),
                      ),
                      Spacer(),
                      TextField(
                        controller: mobileController,
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
                      Text(
                        'Email: ',
                        style: TextStyle(fontSize: 18),
                      ),
                      Spacer(),
                      TextField(
                        controller: emailController,
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
                      DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                            errorStyle: const TextStyle(
                                color: Colors.redAccent, fontSize: 16.0),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0))),
                        value: statusController,
                        items: ["Status 1", "Status 2"]
                            .map((label) => DropdownMenuItem(
                                  child: Text(label.toString()),
                                  value: label,
                                ))
                            .toList(),
                        hint: const Text('Status'),
                        onChanged: (String? value) {
                          setState(() {
                            statusController = value!;
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
                  children: [
                    Text(
                      'Remarks for update:',
                      style: TextStyle(fontSize: 18),
                    ),
                    Spacer(),
                    TextField(
                      controller: remarksController,
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
  Function updateRespondent;
  Uuid uuid;

  RespondentDetails({
    this.isMobile = false,
    required this.updateRespondent,
    required this.uuid,
  });

  @override
  State<RespondentDetails> createState() => _RespondentDetailsState();
}

class _RespondentDetailsState extends State<RespondentDetails>
    with AutomaticKeepAliveClientMixin<RespondentDetails> {
  @override
  bool get wantKeepAlive => true;

  RespondantModel? model;
  String? rdeptController;
  String? rgenderController;
  String? rcountryController;
  String? rstateController;
  String? rdistrictController;
  String? rstatusController;
  TextEditingController rnameController = TextEditingController();
  TextEditingController rfnameController = TextEditingController();
  TextEditingController rrelationController = TextEditingController();
  TextEditingController rageController = TextEditingController();
  TextEditingController roccupationController = TextEditingController();
  TextEditingController rcasteController = TextEditingController();
  TextEditingController raddressController = TextEditingController();
  TextEditingController reduController = TextEditingController();
  TextEditingController rcityController = TextEditingController();
  TextEditingController rpincodeController = TextEditingController();
  TextEditingController rmobileController = TextEditingController();
  TextEditingController remailController = TextEditingController();
  TextEditingController rremarksController = TextEditingController();
  bool isClicked = false;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = widget.isMobile! ? 1100 : MediaQuery.of(context).size.width;

    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                "Respondant Details",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
              Expanded(child: Container()),
              TextButton(
                  onPressed: isClicked
                      ? null
                      : () {
                          setState(() {
                            int rage = int.parse(rageController.text);
                            int rpincode = int.parse(rpincodeController.text);
                            int rmobile = int.parse(rmobileController.text);

                            widget.updateRespondent(RespondantModel(
                                caseId: caseNoController.text,
                                userId: widget.uuid.v4(),
                                name: rnameController.text,
                                fhName: rfnameController.text,
                                age: rage,
                                occupation: roccupationController.text,
                                address: raddressController.text,
                                country: rcountryController!,
                                state: rstateController!,
                                pinCode: rpincode,
                                email: remailController.text,
                                remarks: rremarksController.text,
                                inddep: rdeptController == "Individual" ? 0 : 1,
                                relation: rrelationController.text,
                                gender: rgenderController!,
                                edu: reduController.text,
                                district: rdistrictController!,
                                mobile: rmobile,
                                status: rstatusController!,
                                city: rcityController.text,
                                caste: rcasteController.text));
                            isClicked = true;
                          });
                        },
                  child: Text('Save'))
            ],
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
                    children: [
                      const Text(
                        'Name:',
                        style: TextStyle(fontSize: 18),
                      ),
                      const Spacer(),
                      TextField(
                        controller: rnameController,
                        decoration: const InputDecoration(
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
                      DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                            errorStyle: const TextStyle(
                                color: Colors.redAccent, fontSize: 16.0),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0))),
                        value: rdeptController,
                        items: ["Individual", "Dept"]
                            .map((label) => DropdownMenuItem(
                                  child: Text(label.toString()),
                                  value: label,
                                ))
                            .toList(),
                        hint: const Text('Individual/Dept'),
                        onChanged: (String? value) {
                          setState(() {
                            rdeptController = value!;
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
                    children: [
                      Text(
                        'Father/Husband Name: ',
                        style: TextStyle(fontSize: 18),
                      ),
                      Spacer(),
                      TextField(
                        controller: rfnameController,
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
                      Text(
                        'Relation: ',
                        style: TextStyle(fontSize: 18),
                      ),
                      Spacer(),
                      TextField(
                        controller: rrelationController,
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
                      Text(
                        'Age:',
                        style: TextStyle(fontSize: 18),
                      ),
                      Spacer(),
                      TextField(
                        controller: rageController,
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
                      DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                            errorStyle: const TextStyle(
                                color: Colors.redAccent, fontSize: 16.0),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0))),
                        value: rgenderController,
                        items: ["Male", "Female"]
                            .map((label) => DropdownMenuItem(
                                  child: Text(label.toString()),
                                  value: label,
                                ))
                            .toList(),
                        hint: const Text('Gender'),
                        onChanged: (String? value) {
                          setState(() {
                            rgenderController = value!;
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
                    children: [
                      Text(
                        'Occupation:',
                        style: TextStyle(fontSize: 18),
                      ),
                      Spacer(),
                      TextField(
                        controller: roccupationController,
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
                      Text(
                        'Caste:',
                        style: TextStyle(fontSize: 18),
                      ),
                      Spacer(),
                      TextField(
                        controller: rcasteController,
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
                      Text(
                        'Address: ',
                        style: TextStyle(fontSize: 18),
                      ),
                      Spacer(),
                      TextField(
                        controller: raddressController,
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
                      Text(
                        'Education/Qualification:',
                        style: TextStyle(fontSize: 18),
                      ),
                      Spacer(),
                      TextField(
                        controller: reduController,
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
                      DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                            errorStyle: const TextStyle(
                                color: Colors.redAccent, fontSize: 16.0),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0))),
                        value: rcountryController,
                        items: ["Country 1", "Country 2"]
                            .map((label) => DropdownMenuItem(
                                  child: Text(label.toString()),
                                  value: label,
                                ))
                            .toList(),
                        hint: const Text('Country'),
                        onChanged: (String? value) {
                          setState(() {
                            rcountryController = value!;
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
                      Text(
                        'Place/City:',
                        style: TextStyle(fontSize: 18),
                      ),
                      Spacer(),
                      TextField(
                        controller: rcityController,
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
                      DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                            errorStyle: const TextStyle(
                                color: Colors.redAccent, fontSize: 16.0),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0))),
                        value: rstateController,
                        items: ["State 1", "State 2"]
                            .map((label) => DropdownMenuItem(
                                  child: Text(label.toString()),
                                  value: label,
                                ))
                            .toList(),
                        hint: const Text('State'),
                        onChanged: (String? value) {
                          setState(() {
                            rstateController = value!;
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
                      DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                            errorStyle: const TextStyle(
                                color: Colors.redAccent, fontSize: 16.0),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0))),
                        value: rdistrictController,
                        items: ["District 1", "District 2"]
                            .map((label) => DropdownMenuItem(
                                  child: Text(label.toString()),
                                  value: label,
                                ))
                            .toList(),
                        hint: const Text('District'),
                        onChanged: (String? value) {
                          setState(() {
                            rdistrictController = value!;
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
                    children: [
                      Text(
                        'Pincode: ',
                        style: TextStyle(fontSize: 18),
                      ),
                      Spacer(),
                      TextField(
                        controller: rpincodeController,
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
                      Text(
                        'Mobile Number: ',
                        style: TextStyle(fontSize: 18),
                      ),
                      Spacer(),
                      TextField(
                        controller: rmobileController,
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
                      Text(
                        'Email: ',
                        style: TextStyle(fontSize: 18),
                      ),
                      Spacer(),
                      TextField(
                        controller: remailController,
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
                      DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                            errorStyle: const TextStyle(
                                color: Colors.redAccent, fontSize: 16.0),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0))),
                        value: rstatusController,
                        items: ["Status 1", "Status 2"]
                            .map((label) => DropdownMenuItem(
                                  child: Text(label.toString()),
                                  value: label,
                                ))
                            .toList(),
                        hint: const Text('Status'),
                        onChanged: (String? value) {
                          setState(() {
                            rstatusController = value!;
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
                  children: [
                    Text(
                      'Remarks for update:',
                      style: TextStyle(fontSize: 18),
                    ),
                    Spacer(),
                    TextField(
                      controller: rremarksController,
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
  Function updateCase;
  Uuid uuid;

  CaseDetails(
      {this.isMobile = false, required this.updateCase, required this.uuid});

  @override
  State<CaseDetails> createState() => _CaseDetailsState();
}

class _CaseDetailsState extends State<CaseDetails>
    with AutomaticKeepAliveClientMixin<CaseDetails> {
  @override
  bool get wantKeepAlive => true;

  String? caseTypeController;
  TextEditingController diaryNoController = TextEditingController();
  TextEditingController petAdvController = TextEditingController();
  TextEditingController resAdvController = TextEditingController();
  TextEditingController judgementController = TextEditingController();
  TextEditingController earlierDetailsController = TextEditingController();
  TextEditingController caseStatusController = TextEditingController();
  TextEditingController caseAgeController = TextEditingController();
  TextEditingController hearingDateController = TextEditingController();
  TextEditingController filingDateController = TextEditingController();
  bool isClicked = false;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = widget.isMobile! ? 1100 : MediaQuery.of(context).size.width;

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                "Case Details",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
              Expanded(child: Container()),
              TextButton(
                  onPressed: isClicked
                      ? null
                      : () {
                          widget.updateCase(CaseModel(
                              caseId: caseNoController.text,
                              caseType: caseTypeController!,
                              diaryNo: int.parse(diaryNoController.text),
                              petAdv: petAdvController.text,
                              resAdv: resAdvController.text,
                              filing: filingDateController.text,
                              judgementBy: judgementController.text,
                              nextHearing: hearingDateController.text,
                              age: int.parse(caseAgeController.text),
                              status: caseStatusController.text));
                          setState(() {
                            isClicked = true;
                          });
                        },
                  child: Text("Save"))
            ],
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
                    children: [
                      Text(
                        'Case No:',
                        style: TextStyle(fontSize: 18),
                      ),
                      Spacer(),
                      TextField(
                        controller: caseNoController,
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
                      DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                            errorStyle: const TextStyle(
                                color: Colors.redAccent, fontSize: 16.0),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0))),
                        value: caseTypeController,
                        items: ["Civil", "Criminal"]
                            .map((label) => DropdownMenuItem(
                                  child: Text(label.toString()),
                                  value: label,
                                ))
                            .toList(),
                        hint: const Text('Rating'),
                        onChanged: (String? value) {
                          setState(() {
                            caseTypeController = value!;
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
                    children: [
                      Text(
                        'Diary Numbers: ',
                        style: TextStyle(fontSize: 18),
                      ),
                      Spacer(),
                      TextField(
                        controller: diaryNoController,
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
                      Text(
                        'Petitioner Advocate: ',
                        style: TextStyle(fontSize: 18),
                      ),
                      Spacer(),
                      TextField(
                        controller: petAdvController,
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
                      Text(
                        'Respondent Advocate: ',
                        style: TextStyle(fontSize: 18),
                      ),
                      Spacer(),
                      TextField(
                        controller: resAdvController,
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
                      Text(
                        'Judgement by: ',
                        style: TextStyle(fontSize: 18),
                      ),
                      Spacer(),
                      TextField(
                        controller: judgementController,
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
                  children: [
                    const Text(
                      'Earlier court details if any:',
                      style: TextStyle(fontSize: 18),
                    ),
                    const Spacer(),
                    TextField(
                      controller: earlierDetailsController,
                      maxLines: 5,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ],
                ),
              ),
            ]),
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
                  controller: caseStatusController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
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
                        hearingDateController.text = selectedDate.toString();
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
                  controller: caseAgeController,
                  decoration: InputDecoration(
                    fillColor: Colors.grey,
                    border: OutlineInputBorder(),
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
                child: TextFormField(
                  controller: filingDateController,
                  onTap: () async {
                    await showDatePicker(
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
                        filingDateController.text = selectedDate.toString();
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
        ],
      ),
    );
  }
}
