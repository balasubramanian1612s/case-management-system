import 'package:court_project/models/case_lookup.dart';
import 'package:court_project/models/case_model.dart';
import 'package:court_project/models/petitioner_model.dart';
import 'package:court_project/models/respondent_model.dart';
import 'package:court_project/models/timeline_model.dart';

class CompleteCaseModel {
  CaseLookup caseLookup;
  CaseModel caseModel;
  List<PetitionerModel> petitionersList;
  List<RespondantModel> respondantList;
  List<TimelineModel> timelinesList;
  CompleteCaseModel({
    required this.caseLookup,
    required this.caseModel,
    required this.petitionersList,
    required this.respondantList,
    required this.timelinesList,
  });
}
