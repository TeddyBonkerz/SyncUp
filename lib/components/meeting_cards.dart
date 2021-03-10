import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePageCards extends StatelessWidget {
  //example list
  final List<String> meetingList = [
    "FIFA Tournament",
    "Movie Night",
    "Plan Bradley's Inauguration",
    "RnM Season 5 Premiere"
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      // Text(
      //   'Created Meetings',
      //   style: GoogleFonts.mcLaren(
      //     textStyle: TextStyle(
      //       fontSize: 10,
      //       color: Colors.white,
      //     ),
      //   ),
      // ),
      child: ListView.builder(
        itemCount: meetingList.length,
        itemBuilder: (BuildContext context, int index) =>
            buildMeetingCard(context, index),
      ),
    );
  }

//Actual list of cards
  Widget buildMeetingCard(BuildContext context, int index) {
    return Container(
      child: Card(
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.grey, width: 1),
          borderRadius: BorderRadius.circular(10),
        ),
        margin: EdgeInsets.all(5.0),
        child: Column(
          children: <Widget>[
            Text(meetingList[index]),
            Text('Votes: 4/5'),
            Padding(
              padding: EdgeInsets.all(16.0),
            )
          ],
        ),
      ),
    );
  }
}
