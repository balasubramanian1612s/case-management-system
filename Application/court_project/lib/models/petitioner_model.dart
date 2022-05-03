class PetitionerModel {
  String name;
  String fhName;
  int age;
  String occupation;
  String address;
  String country;
  String state;
  int pinCode;
  String email;
  String remarks;
  int inddep;
  String relation;
  String gender;
  String edu;
  String city;
  String district;
  int mobile;
  String status;
  int isPetitioner = 1;
  String userId;
  String caseId;
  String caste;

  PetitionerModel(
      {required this.name,
      required this.userId,
      required this.caseId,
      required this.fhName,
      required this.age,
      required this.occupation,
      required this.address,
      required this.country,
      required this.state,
      required this.pinCode,
      required this.email,
      required this.remarks,
      required this.inddep,
      required this.relation,
      required this.gender,
      required this.edu,
      required this.district,
      required this.mobile,
      required this.status,
      required this.city,
      required this.caste});

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "case_id": caseId,
        "person_name": name,
        "fhname": fhName,
        "age": age,
        "occ": occupation,
        "addr": address,
        "country": country,
        "state": state,
        "pin": pinCode,
        "email": email,
        "remarks": remarks,
        "inddep": inddep,
        "is_petitioner": isPetitioner,
        "relation": relation,
        "gender": gender == "Male" ? "M" : "F",
        "caste": caste,
        "edu": edu,
        "city": city,
        "district": district,
        "mobile": mobile,
        "status": status
      };
}
