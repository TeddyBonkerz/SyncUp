import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:syncup/constants.dart';
import 'package:syncup/models/listMeetingModel.dart';
import 'package:syncup/models/userModel.dart';
import 'package:syncup/screens/home.dart';
import 'package:syncup/models/meetingModel.dart';

class MeetingDetails extends StatefulWidget {
  QueryDocumentSnapshot meeting;

  MeetingDetails({this.meeting});

  @override
  _MeetingDetails createState() => _MeetingDetails(meeting: meeting);
}

class _MeetingDetails extends State<MeetingDetails> {
  QueryDocumentSnapshot meeting;
  _MeetingDetails({this.meeting});

  // Meeting meeting = MeetingList.instance.meetingList[index];
  bool checkCompleted;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel>(context);
    String uId = user.uId;
    CollectionReference meetingList = FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('meeting');
    // bool checkCompleted =
    //     meeting.data()['completed']; // check box value for complete or not
    return Scaffold(
        appBar: AppBar(
          title: Text(meeting.data()['title']),
        ),
        body: Container(
            child: Column(
          children: <Widget>[
            Column(
              //General Info: Description, time / date, Complete or not
              children: <Widget>[
                ListTile(
                  contentPadding: const EdgeInsets.all(10.0),
                  title: Text(
                    meeting.data()['content'],
                    textAlign: TextAlign.center,
                  ),
                ),
                // Time and Date Info
                ListTile(
                    contentPadding: const EdgeInsets.all(10.0),
                    title: Text('Time / Date'),
                    subtitle: Text(meeting.data()['dateTime'])),
                // Location Info
                ListTile(
                    contentPadding: const EdgeInsets.all(10.0),
                    title: Text('Location'),
                    subtitle: Text(meeting.data()['location'])),
                // Meeting Check box for completion status
                CheckboxListTile(
                    title: const Text('Meeting Completed: '),
                    value: meeting.data()['completed'],
                    onChanged: (bool value) async {
                      await meetingList
                          .doc(meeting.id)
                          .update({'completed': value})
                          .then((value) => print("Meeting Updated"))
                          .catchError((error) =>
                              print("Failed to update meeting: $error"));
                      // setState(() {
                      //
                      //   checkCompleted = value;
                      // });

                      // setState(() {
                      //   checkCompleted = value;
                      // });
                    }),
              ],
            ),
            // View who is attending List
            ListTile(
                contentPadding: const EdgeInsets.all(10.0),
                title: Text('List of Attendence')),
            Expanded(
              child: ListView.builder(
                  itemCount: meeting
                      .data()['attendeeList']
                      .length, // filler till we have actual list length
                  itemBuilder: (context, index) {
                    return ListTile(
                        // will change to variables / values when we have actual list to grab from
                        title: Text('ContactName'),
                        subtitle: Text(meeting
                            .data()['attendeeList'][index]['email']
                            .toString()));
                  }),
            )
          ],
        )));
  }
}
