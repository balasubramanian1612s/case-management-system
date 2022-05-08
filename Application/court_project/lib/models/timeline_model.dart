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
  eventType eventtype;
  NoteModel? note;

  TimelineModel({
    required this.eventId,
    required this.caseId,
    required this.eventDate,
    required this.eventtype,
    this.note,
  });
}
