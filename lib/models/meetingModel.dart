import 'package:syncup/models/attendeeModel.dart';

class Meeting {
  final String meetingId;
  final String organizer;
  final String title;
  final String description;
  final String meetingDate;
  //we intend to use DateTime at some point:
  //final DateTime meetingDate;
  final List<Attendee> attendees;

  Meeting(this.meetingId, this.organizer, this.title, this.description,
      this.meetingDate, this.attendees);
}
