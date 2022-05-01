enum CaseType { civil, criminal }

class CaseLookup {
  String caseId;
  DateTime hearingDate;
  String petName;
  String resName;
  CaseType caseType;
  DateTime filingDate;
  int caseAge;
  String caseDescription;

  CaseLookup({
    required this.caseId,
    required this.hearingDate,
    required this.petName,
    required this.resName,
    required this.caseType,
    required this.filingDate,
    required this.caseAge,
    required this.caseDescription,
  });
}
