import 'package:syncup/models/attendeeModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Meeting {
  String meetingId;
  // String organizer;
  String title;
  String description;
  String meetingDate;
  String location;
  //we intend to use DateTime at some point:
  //final DateTime meetingDate;
  List<Attendee> attendees;

  Meeting(
      {this.meetingId,
      // this.organizer,
      this.title,
      this.description,
      this.meetingDate,
      this.location,
      this.attendees});

  Meeting.fromJson(Map<String, dynamic> parsedJSON)
      // : meetingId = parsedJSON['id'],
      : title = parsedJSON['title'],
        description = parsedJSON['content'],
        meetingDate = parsedJSON['dateTime'],
        location = parsedJSON['location'],
        attendees = parsedJSON['attendeeList'];

  get getMeetingId => this.meetingId;

  set setMeetingId(meetingId) => this.meetingId = meetingId;

  // get getOrganizer => this.organizer;
  //
  // set setOrganizer(organizer) => this.organizer = organizer;

  get getTitle => this.title;

  set setTitle(title) => this.title = title;

  get getDescription => this.description;

  set setDescription(description) => this.description = description;

  get getMeetingDate => this.meetingDate;

  set setMeetingDate(meetingDate) => this.meetingDate = meetingDate;

  get getLocation => this.location;

  set setLocation(location) => this.location = location;

  List<Attendee> get getAttendees => this.attendees;

  set setAttendees(attendees) => this.attendees = attendees;
}
