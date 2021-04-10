import 'package:syncup/models/attendeeModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Meeting {
  String meetingId;
<<<<<<< HEAD
||||||| merged common ancestors
  String organizer;
=======
  // String organizer;
>>>>>>> 417e877b140a086117b405a1550964472906df03
  String title;
  String description;
  String meetingDate;
<<<<<<< HEAD
  String location;
||||||| merged common ancestors
  //we intend to use DateTime at some point:
  //final DateTime meetingDate;
=======
  //we intend to use DateTime at some point:
  //final DateTime meetingDate;
  String location;
>>>>>>> 417e877b140a086117b405a1550964472906df03
  List<Attendee> attendees;

  Meeting(
      {this.meetingId,
      // this.organizer,
      this.title,
      this.description,
      this.meetingDate,
<<<<<<< HEAD
      this.location,
      this.attendees});
||||||| merged common ancestors
      this.attendees});
=======
      this.attendees,
      this.location});
>>>>>>> 417e877b140a086117b405a1550964472906df03

  Meeting.fromJson(Map<String, dynamic> parsedJSON)
      : title = parsedJSON['title'],
        description = parsedJSON['content'],
        meetingDate = parsedJSON['dateTime'],
        location = parsedJSON['location'],
        attendees = parsedJSON['attendeeList'];

  get getMeetingId => this.meetingId;

  set setMeetingId(meetingId) => this.meetingId = meetingId;

<<<<<<< HEAD
||||||| merged common ancestors
  get getOrganizer => this.organizer;

  set setOrganizer(organizer) => this.organizer = organizer;

=======
  // get getOrganizer => this.organizer;
  //
  // set setOrganizer(organizer) => this.organizer = organizer;

>>>>>>> 417e877b140a086117b405a1550964472906df03
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
