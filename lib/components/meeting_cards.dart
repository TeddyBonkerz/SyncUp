import 'package:flutter/material.dart';
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
    double width = MediaQuery.of(context).size.width * 0.7;
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MeetingDetails(),
          ),
        );
      },
      //Each card on the homepage
      child: Card(
        child: Row(
          children: <Widget>[
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage('assets/images/default_profile.png'),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: width,
                    child: Text(
                      meetingList[index].title,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Container(
                    width: width,
                    child: Text(
                      meetingList[index].description,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey[500],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
