import 'package:flutter/material.dart';
import 'package:syncup/constants.dart';
import 'package:syncup/models/attendeeModel.dart';
import 'package:syncup/models/meetingModel.dart';
import 'package:syncup/screens/meeting_details.dart';
import 'package:syncup/models/listMeetingModel.dart';

class HomePageCards extends StatelessWidget {
  //example list
  List<Meeting> meetingList = MeetingList.instance.meetingList;

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
                builder: (context) =>
                    MeetingDetails(meeting: meetingList[index]),
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
                    meetingList[index].title.substring(0, 1),
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
