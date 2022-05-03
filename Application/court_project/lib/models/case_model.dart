class CaseModel {
  String caseId;
  String caseType;
  String diaryNo;
  String petAdv;
  String resAdv;
  DateTime filing;
  String judgementBy;
  DateTime nextHearing;
  int age;
  String status;

  CaseModel({
    required this.caseId,
    required this.caseType,
    required this.diaryNo,
    required this.petAdv,
    required this.resAdv,
    required this.filing,
    required this.judgementBy,
    required this.nextHearing,
    required this.age,
    required this.status,
  });
}
