import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncup/constants.dart';
import 'package:syncup/models/userModel.dart';
import 'package:syncup/services/DatabaseService.dart';

class MeetingDetails extends StatefulWidget {
  final QueryDocumentSnapshot meeting;

  MeetingDetails({this.meeting});

  @override
  _MeetingDetails createState() => _MeetingDetails(meeting: meeting);
}

class _MeetingDetails extends State<MeetingDetails> {
  QueryDocumentSnapshot meeting;
  _MeetingDetails({this.meeting});
  bool checkCompleted;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel>(context);
    String uId = user.uId;

    CollectionReference meetingList = FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('meeting');
    return StreamBuilder<QuerySnapshot>(
      stream: meetingList.snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

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
                  ],
                ),
                // View who is attending List
                ListTile(title: Text('List of Attendee Emails')),
                Expanded(
                  child: ListView.builder(
                    itemCount: meeting
                        .data()['attendeeList']
                        .length, // filler till we have actual list length
                    itemBuilder: (context, index) {
                      return ListTile(
                        // will change to variables / values when we have actual list to grab from
                        trailing: Icon(
                          meeting
                                      .data()['attendeeList'][index]['email']
                                      .toString() ==
                                  "true"
                              ? Icons.done
                              : Icons.clear,
                          color: meeting
                                      .data()['attendeeList'][index]['email']
                                      .toString() ==
                                  "true"
                              ? Colors.green
                              : Colors.red,
                        ),
                        title: Text(
                          meeting
                              .data()['attendeeList'][index]['email']
                              .toString(),
                        ),
                      );
                    },
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    primary: primaryColor,
                  ),
                  onPressed: () async {
                    await DatabaseService(uId: user.uId)
                        .deleteMeeting(meeting.id);

                    Navigator.pop(context);
                  },
                  child: Text(
                    'Close Meeting',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
