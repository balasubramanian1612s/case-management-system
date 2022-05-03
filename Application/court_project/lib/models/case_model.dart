class CaseModel {
  String caseId;
  String caseType;
  int diaryNo;
  String petAdv;
  String resAdv;
  String filing;
  String judgementBy;
  String nextHearing;
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

  Map<String, dynamic> toJson() => {
        "case_id": caseId,
        "diary_no": diaryNo,
        "case_type": caseType,
        "pet_adv": petAdv,
        "res_adv": resAdv,
        "filing": filing,
        "judgement_by": judgementBy,
        "next_hearing": nextHearing,
        "age": age,
        "status": status,
      };
}
