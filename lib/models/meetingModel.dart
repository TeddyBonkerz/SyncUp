import 'package:syncup/models/attendeeModel.dart';

class Meeting {
  String meetingId;
  String organizer;
  String title;
  String description;
  String meetingDate;
  //we intend to use DateTime at some point:
  //final DateTime meetingDate;
  List<Attendee> attendees;

  Meeting(
      {this.meetingId,
      this.organizer,
      this.title,
      this.description,
      this.meetingDate,
      this.attendees});

  get getMeetingId => this.meetingId;

  set setMeetingId(meetingId) => this.meetingId = meetingId;

  get getOrganizer => this.organizer;

  set setOrganizer(organizer) => this.organizer = organizer;

  get getTitle => this.title;

  set setTitle(title) => this.title = title;

  get getDescription => this.description;

  set setDescription(description) => this.description = description;

  get getMeetingDate => this.meetingDate;

  set setMeetingDate(meetingDate) => this.meetingDate = meetingDate;

  List<Attendee> get getAttendees => this.attendees;

  set setAttendees(attendees) => this.attendees = attendees;
}
