import 'package:flutter/material.dart';
import 'package:syncup/constants.dart';
import 'package:syncup/models/attendeeModel.dart';
import 'package:syncup/models/meetingModel.dart';
import 'package:syncup/screens/meeting_details.dart';

class HomePageCards extends StatelessWidget {
  //example list
  List<Meeting> meetingList = [
    new Meeting(
        meetingId: "123",
        organizer: "Grim Munchkins",
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
        organizer: "Grim Munchkins",
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: meetingList.length,
        itemBuilder: (BuildContext context, int index) =>
            buildMeetingCard(context, index),
      ),
    );
  }

//Actual list of cards
  Widget buildMeetingCard(BuildContext context, int index) {
    //double width = MediaQuery.of(context).size.width * 0.7;
    return SafeArea(
      top: false,
      bottom: false,
      child: Card(
        elevation: 5,
        margin: EdgeInsets.fromLTRB(6, 12, 6, 0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MeetingDetails(),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                CircleAvatar(
                  backgroundColor: primaryColor,
                  child: Text(
                    meetingList[index].organizer.substring(0, 1),
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                Padding(padding: EdgeInsets.only(left: 16)),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        meetingList[index].title,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(top: 8)),
                      Text(
                        meetingList[index].description,
                      ),
                      Padding(padding: EdgeInsets.only(left: 16)),
                      Padding(padding: EdgeInsets.only(top: 8)),
                      Divider(
                        thickness: 2.0,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
