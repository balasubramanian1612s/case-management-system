import 'dart:convert';
import 'dart:html';
import 'dart:typed_data';

import 'package:court_project/models/case_lookup.dart';
import 'package:court_project/models/complete_case_model.dart';
import 'package:court_project/models/petitioner_model.dart';
import 'package:court_project/models/respondent_model.dart';
import 'package:court_project/utils/nav_bar.dart';
import 'package:court_project/utils/responsive.dart';
import 'package:court_project/views/case_details/case_detail.dart';
import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import '../../models/case_model.dart';

PetitionerModel convertPetToObject(dynamic json) {
  return PetitionerModel(
    name: json['person_name'] as String,
    userId: json['user_id'] as String,
    caseId: json['case_id'] as String,
    fhName: json['fhname'] as String,
    age: int.parse(json['age']),
    occupation: json['occ'] as String,
    address: json['addr'] as String,
    country: json['country'] as String,
    state: json['state'] as String,
    pinCode: int.parse(json['pin']),
    email: json['email'] as String,
    remarks: json['remarks'] as String,
    inddep: int.parse(json['inddep']),
    relation: json['relation'] as String,
    gender: json['gender'] as String,
    edu: json['edu'] as String,
    district: json['district'] as String,
    mobile: int.parse(json['mobile']),
    status: json['status'] as String,
    city: json['city'] as String,
    caste: json['caste'] as String,
  );
}

RespondantModel convertResToObject(dynamic json) {
  // debugPrint("${json["name"]} ${json[r"user_id"]} ${json["case_id"]}");
  return RespondantModel(
    name: json['person_name'] as String,
    userId: json['user_id'] as String,
    caseId: json['case_id'] as String,
    fhName: json['fhname'] as String,
    age: int.parse(json['age']),
    occupation: json['occ'] as String,
    address: json['addr'] as String,
    country: json['country'] as String,
    state: json['state'] as String,
    pinCode: int.parse(json['pin']),
    email: json['email'] as String,
    remarks: json['remarks'] as String,
    inddep: int.parse(json['inddep']),
    relation: json['relation'] as String,
    gender: json['gender'] as String,
    edu: json['edu'] as String,
    district: json['district'] as String,
    mobile: int.parse(json['mobile']),
    status: json['status'] as String,
    city: json['city'] as String,
    caste: json['caste'] as String,
  );
}

CaseModel convertCaseToObject(dynamic json) {
  return CaseModel(
    caseId: json["case_id"] as String,
    caseType: json["case_type"] as String,
    diaryNo: int.parse(json["diary_no"]),
    petAdv: json["pet_adv"] as String,
    resAdv: json["res_adv"] as String,
    filing: json["filing"] as String,
    judgementBy: json["judgement_by"] as String,
    nextHearing: json["next_hearing"] as String,
    age: int.parse(json["age"]),
    status: json["status"] as String,
  );
}

Future<List<CompleteCaseModel>> getCases() async {
  var response = await http.get(
    Uri.parse("http://127.0.0.1/cms/get_cases.php"),
  );
  // debugPrint(response.body);
  var parsedCaseData = jsonDecode(response.body);
  List<CompleteCaseModel> _completeCases = [];
  for (var cases in parsedCaseData) {
    List<RespondantModel> _resList = [];
    List<PetitionerModel> _petList = [];

    for (var respondant in cases["respondents"]) {
      _resList.add(convertResToObject(respondant));
    }
    for (var petitioner in cases["petitioners"]) {
      _petList.add(convertPetToObject(petitioner));
    }

    CaseModel _caseModel = convertCaseToObject(cases["case"]);
    CaseLookup _caseLookupModel = CaseLookup(
        caseId: _caseModel.caseId,
        hearingDate: DateTime.parse(_caseModel.nextHearing),
        petName: _petList.isNotEmpty ? _petList[0].name : "No petitioners",
        resName: _resList.isNotEmpty ? _resList[0].name : "No respondents",
        caseType: _caseModel.caseType == "Criminal"
            ? CaseType.criminal
            : CaseType.civil,
        filingDate: DateTime.parse(_caseModel.filing),
        caseAge: _caseModel.age,
        caseDescription: "No description");
    _completeCases.add(CompleteCaseModel(
      caseLookup: _caseLookupModel,
      caseModel: _caseModel,
      petitionersList: _petList,
      respondantList: _resList,
    ));
  }
  return _completeCases;
}

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
    const sidebarDecoration = BoxDecoration(
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
  late List<CompleteCaseModel> _completeCaseList;
  bool isLoaded = false;

  late List<CaseLookup> caseList = [];

  void fetchCases() async {
    _completeCaseList = await getCases();
    for (CompleteCaseModel completeCase in _completeCaseList) {
      caseList.add(completeCase.caseLookup);
    }
    setState(() {
      isLoaded = true;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchCases();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = widget.isMobile! ? 1100 : MediaQuery.of(context).size.width;

    return !isLoaded
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Container(
            height: height,
            width: width,
            color: Colors.white,
            child: Column(
              children: [
                NavBar(),
                ToolBar(
                  isMobile: widget.isMobile,
                  casesList: _completeCaseList,
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
                        completeCaseInfo: _completeCaseList[index],
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
  CompleteCaseModel completeCaseInfo;
  CaseLookupTile({
    required this.item,
    this.isMobile = false,
    required this.completeCaseInfo,
  });

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
                    color: const Color(0xff12294C),
                    borderRadius: BorderRadius.circular(8)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Text(
                        "Case ID: " + widget.item.caseId,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w200),
                      ),
                      Expanded(child: Container()),
                      Text(
                        "Hearing Date: " +
                            DateFormat('dd-MM-yyyy')
                                .format(widget.item.hearingDate),
                        style: const TextStyle(
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
                      decoration: const BoxDecoration(
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
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w200),
                            ),
                            Expanded(child: Container()),
                            Text(
                              "Hearing Date: " +
                                  DateFormat('dd-MM-yyyy')
                                      .format(widget.item.hearingDate),
                              style: const TextStyle(
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
                    decoration: const BoxDecoration(
                        color: Color(0xffDADFE7),
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(8),
                            bottomRight: Radius.circular(8))),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Container(
                                width: width * 0.45,
                                child: Text(
                                  "Petitioner Name: " + widget.item.petName,
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              Container(
                                width: width * 0.45,
                                child: Text(
                                  "Respondent Name: " + widget.item.resName,
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600),
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
                                width: width * 0.45,
                                child: Text(
                                  "Case Type: " + widget.item.caseType.name,
                                  style: const TextStyle(
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
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            child: Text(
                              "Case Age: " + widget.item.caseAge.toString(),
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            child: Text(
                              "Case Description: " +
                                  widget.item.caseDescription,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          const SizedBox(
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
                                    const Text(
                                      "Document",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    const Icon(
                                      Icons.add,
                                      color: Colors.white,
                                    ),
                                    Expanded(child: Container()),
                                  ],
                                ),
                              ),
                              const SizedBox(
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
                                                        const Text(
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
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => CaseDetail(
                                                caseDetail:
                                                    widget.completeCaseInfo,
                                              )));
                                },
                                child: Container(
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
  List<CompleteCaseModel> casesList;
  ToolBar({this.isMobile = false, required this.casesList});

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
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TextButton(
                                      onPressed: () async {
                                        await _generatePDF();
                                        Navigator.pop(context);
                                      },
                                      child: const Text("As PDF")),
                                  TextButton(
                                      onPressed: () async {
                                        await _generateExcel();
                                        Navigator.pop(context);
                                      },
                                      child: const Text("As Excel")),
                                ],
                              ),
                            )),
                      ));
            },
            child: Container(
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
          ),
        ],
      ),
    );
  }

  _generateExcel() {
    var excel =
        Excel.createExcel(); // automatically creates 1 empty sheet: Sheet1
    Sheet sheetObject = excel['Sheet1'];
    int startValue = 1;
    int snoValue = 1;
    widget.casesList.forEach((element) {
      sheetObject.merge(CellIndex.indexByString('A' + startValue.toString()),
          CellIndex.indexByString('A' + (startValue + 6).toString()),
          customValue: "S.no." + snoValue.toString());
      CellStyle cellStyle = CellStyle(verticalAlign: VerticalAlign.Center);
      var cell = sheetObject
          .cell(CellIndex.indexByString("A" + startValue.toString()));
      cell.cellStyle = cellStyle;
      sheetObject
          .cell(CellIndex.indexByString("B" + (startValue).toString()))
          .value = "Diary Number";
      sheetObject
          .cell(CellIndex.indexByString("C" + (startValue).toString()))
          .value = element.caseModel.diaryNo;
      sheetObject
          .cell(CellIndex.indexByString("B" + (startValue + 1).toString()))
          .value = "Case Number";
      sheetObject
          .cell(CellIndex.indexByString("C" + (startValue + 1).toString()))
          .value = element.caseModel.caseId;
      sheetObject
          .cell(CellIndex.indexByString("B" + (startValue + 2).toString()))
          .value = "Petitioner Name";
      sheetObject
              .cell(CellIndex.indexByString("C" + (startValue + 2).toString()))
              .value =
          element.petitionersList.isEmpty
              ? "Not Available"
              : element.petitionersList[0].name;
      sheetObject
          .cell(CellIndex.indexByString("B" + (startValue + 3).toString()))
          .value = "Respondent Name";
      sheetObject
              .cell(CellIndex.indexByString("C" + (startValue + 3).toString()))
              .value =
          element.respondantList.isEmpty
              ? "Not Available"
              : element.respondantList[0].name;
      sheetObject
          .cell(CellIndex.indexByString("B" + (startValue + 4).toString()))
          .value = "Petitioner's Advocate";
      sheetObject
          .cell(CellIndex.indexByString("C" + (startValue + 4).toString()))
          .value = element.caseModel.petAdv;
      sheetObject
          .cell(CellIndex.indexByString("B" + (startValue + 5).toString()))
          .value = "Respondent's Advocate";
      sheetObject
          .cell(CellIndex.indexByString("C" + (startValue + 5).toString()))
          .value = element.caseModel.resAdv;
      sheetObject
          .cell(CellIndex.indexByString("B" + (startValue + 6).toString()))
          .value = "Judgment By";
      sheetObject
          .cell(CellIndex.indexByString("C" + (startValue + 6).toString()))
          .value = element.caseModel.judgementBy;
      startValue += 7;
      snoValue += 1;
    });
    excel.save(fileName: "CasesOverview.xlsx");
  }

  _generatePDF() async {
    final pdf = pw.Document();
    pw.MemoryImage img = pw.MemoryImage(
      (await rootBundle.load('assets/logo.png')).buffer.asUint8List(),
    );
    widget.casesList.forEach((element) {
      pdf.addPage(
        pw.MultiPage(header: ((pw.Context context) {
          return pw.Column(children: [
            pw.Row(children: [
              pw.Text(
                "DISTRICT COURT  TIRUPUR",
                style:
                    pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 18),
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
                  "Case Number: " + element.caseModel.caseId,
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
                    "Case Number: " + element.caseModel.caseId,
                    style: pwcommonInfoStyle,
                  ),
                ),
                pw.Container(
                  child: pw.Text(
                    "Petitioner Advocate: " + element.caseModel.petAdv,
                    style: pwcommonInfoStyle,
                  ),
                ),
                pw.Container(
                  child: pw.Text(
                    "Diary Number: " + element.caseModel.diaryNo.toString(),
                    style: pwcommonInfoStyle,
                  ),
                ),
                pw.Container(
                  child: pw.Text(
                    "Respondent Advocate: " + element.caseModel.resAdv,
                    style: pwcommonInfoStyle,
                  ),
                ),
                pw.Container(
                  child: pw.Text(
                    "Next Hearing: " + element.caseModel.nextHearing,
                    style: pwcommonInfoStyle,
                  ),
                ),
                pw.Container(
                  child: pw.Text(
                    "Filing Date: " + element.caseModel.filing,
                    style: pwcommonInfoStyle,
                  ),
                ),
                pw.Container(
                  child: pw.Text(
                    "Judgement By: " + element.caseModel.judgementBy,
                    style: pwcommonInfoStyle,
                  ),
                ),
                pw.Container(
                  child: pw.Text(
                    "Case Age: " + element.caseModel.age.toString(),
                    style: pwcommonInfoStyle,
                  ),
                ),
                pw.Container(
                  child: pw.Text(
                    "Status: " + element.caseModel.status,
                    style: pwcommonInfoStyle,
                  ),
                ),
              ],
            ),
            pw.SizedBox(
              height: 10,
            ),
            ...element.petitionersList
                .map<pw.Widget>((ele) => pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(
                          "Petitioner Details",
                          style: pw.TextStyle(
                              fontSize: 16, color: PdfColors.brown),
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
            ...element.respondantList
                .map<pw.Widget>((ele) => pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(
                          "Respondant Details",
                          style: pw.TextStyle(
                              fontSize: 16, color: PdfColors.brown),
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
    });

    Uint8List temp = await pdf.save();
    List<int> intArray = List.from(temp);
    AnchorElement(
        href:
            "data:application/octet-stream;charset=utf-16le;base64,${base64.encode(List.from(intArray))}")
      ..setAttribute("download", "CasesOverview.pdf")
      ..click();
  }
}
