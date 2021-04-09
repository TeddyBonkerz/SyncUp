import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:syncup/constants.dart';
import 'package:syncup/models/listMeetingModel.dart';
import 'package:syncup/screens/home.dart';
import 'package:syncup/models/meetingModel.dart';

class MeetingDetails extends StatefulWidget {
  Meeting meeting;

  MeetingDetails({this.meeting});

  @override
  _MeetingDetails createState() => _MeetingDetails(meeting: meeting);
}

class _MeetingDetails extends State<MeetingDetails> {
  Meeting meeting;
  _MeetingDetails({this.meeting});
  bool checkCompleted = false; // check box value for complete or not

  // Meeting meeting = MeetingList.instance.meetingList[index];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(meeting.getTitle),
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
                    meeting.getDescription,
                    textAlign: TextAlign.center,
                  ),
                ),
                // Time and Date Info
                ListTile(
                    contentPadding: const EdgeInsets.all(10.0),
                    title: Text('Time / Date'),
                    subtitle: Text(meeting.getMeetingDate)),
                // Location Info
                ListTile(
                    contentPadding: const EdgeInsets.all(10.0),
                    title: Text('Location'),
                    subtitle: Text(meeting.location)),
                // Meeting Check box for completion status
                CheckboxListTile(
                    title: const Text('Meeting Completed: '),
                    value: checkCompleted,
                    onChanged: (bool value) {
                      setState(() {
                        checkCompleted = value;
                      });
                    }),
              ],
            ),
            // View who is attending List
            ListTile(
                contentPadding: const EdgeInsets.all(10.0),
                title: Text('List of Attendence')),
            Expanded(
              child: ListView.builder(
                  itemCount: meeting.getAttendees
                      .length, // filler till we have actual list length
                  itemBuilder: (context, index) {
                    return ListTile(
                        // will change to variables / values when we have actual list to grab from
                        title: Text('ContactName'),
                        subtitle: Text(meeting.getAttendees[index].getEmail));
                  }),
            )
          ],
        )));
  }
}
