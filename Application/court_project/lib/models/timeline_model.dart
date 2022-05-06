import 'package:court_project/models/note_model.dart';

enum eventType {
  documentUploaded,
  caseFiled,
  caseDisposed,
  nextHearing,
  hearing
}

class TimelineModel {
  String eventId;
  String caseId;
  DateTime eventDate;
  String eventName;
  eventType eventtype;
  NoteModel? note;

  TimelineModel({
    required this.eventId,
    required this.caseId,
    required this.eventDate,
    required this.eventName,
    required this.eventtype,
    this.note,
  });
}
