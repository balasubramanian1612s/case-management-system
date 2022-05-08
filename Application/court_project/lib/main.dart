import 'dart:typed_data';
import 'package:court_project/models/case_lookup.dart';
import 'package:court_project/models/case_model.dart';
import 'package:court_project/models/complete_case_model.dart';
import 'package:court_project/views/case_details/case_detail.dart';
import 'package:court_project/views/case_details/cases_overview.dart';
import 'package:court_project/views/data_feeding/data_feeding.dart';
import 'package:court_project/views/home/home_page.dart';
import 'package:court_project/views/login_page/login_page.dart';
import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:convert';
import 'dart:html';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: HomePage(),

      //   Scaffold(
      // body:
      //    TextButton(
      //       onPressed: () async {
      //       final pdf = pw.Document();
      // href:
      //       pdf.addPage(
      //         pw.Page(
      //           build: (pw.Context context) => pw.Center(
      //             child: pw.Text('Hello World!'),
      //           ),
      //         ),
      //       );

      //       Uint8List temp = await pdf.save();
      //       List<int> intArray = List.from(temp);
      //       AnchorElement(
      //           href:
      //               "data:application/octet-stream;charset=utf-16le;base64,${base64.encode(List.from(intArray))}")
      //         ..setAttribute("download", "output.pdf")
      //         ..click();
      //       },
      //       child: Text('Download')),
      // ),
      // DataFeeding()
      //   CaseDetail(
      // caseDetail: CompleteCaseModel(
      //   caseLookup: CaseLookup(
      //       caseId: "caseId",
      //       hearingDate: DateTime.now(),
      //       petName: "petName",
      //       resName: "resName",
      //       caseType: CaseType.civil,
      //       filingDate: DateTime.now(),
      //       caseAge: 2,
      //       caseDescription: "caseDescription"),
      //   caseModel: CaseModel(
      //       caseId: "sd",
      //       caseType: "ds",
      //       diaryNo: 2,
      //       petAdv: "dsf",
      //       resAdv: "resAdv",
      //       filing: "22/02/2021",
      //       judgementBy: 'judgementBy',
      //       nextHearing: "22/02/2021",
      //       age: 2,
      //       status: "m"),
      //   petitionersList: [],
      //   respondantList: [],
      // ),
      // ),
    );
  }
}
