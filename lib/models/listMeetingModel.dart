import 'package:syncup/models/meetingModel.dart';
import 'package:syncup/models/attendeeModel.dart';

class MeetingList {
  MeetingList._privateConstructor();

  static final MeetingList instance = MeetingList._privateConstructor();
  List<Meeting> meetingList = [
    new Meeting(
        meetingId: "123",
        // organizer: "Grim Munchkins",
        title: "Rick and Morty Season 5 Premieres",
        description:
            "Invite to see who will be comming for the new Rick and Morty Season Premiere",
        meetingDate: "04/15/2020 2:30pm",
        attendees: [
          new Attendee(email: "Zander@gmail.com"),
          new Attendee(email: "Cindy@gmail.com")
        ]),
    new Meeting(
        meetingId: "124",
        // organizer: "Grim Munchkins",
        title: "Graduation Party",
        description:
            "Invitation for all who wish to attend my graduation party",
        meetingDate: "04/25/2020 4:30pm",
        attendees: [
          new Attendee(email: "Zander@gmail.com"),
          new Attendee(email: "Cindy@gmail.com"),
          new Attendee(email: "Marco@gmail.com"),
          new Attendee(email: "Freeze@gmail.com"),
        ]),
  ];
}
