import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncup/constants.dart';
import 'package:syncup/models/userModel.dart';
import 'package:google_fonts/google_fonts.dart';
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
                        leading: Icon(
                          Icons.note,
                          color: primaryColor,
                        ),
                        contentPadding: const EdgeInsets.all(5.0),
                        title: Text('Meeting Details',
                            style: GoogleFonts.sourceSansPro(
                                fontSize: 20,
                                color: primaryColor,
                                letterSpacing: 1,
                                fontWeight: FontWeight.bold)),
                        subtitle: Text(
                          meeting.data()['content'],
                          style: GoogleFonts.sourceSansPro(
                              fontSize: 15,
                              color: Colors.black,
                              letterSpacing: 1),
                          textAlign: TextAlign.left,
                        )),
                    // Time and Date Info
                    ListTile(
                        leading: Icon(
                          Icons.av_timer_rounded,
                          color: primaryColor,
                        ),
                        contentPadding: const EdgeInsets.all(5.0),
                        title: Text('Time / Date',
                            style: GoogleFonts.sourceSansPro(
                                fontSize: 20,
                                color: primaryColor,
                                letterSpacing: 1,
                                fontWeight: FontWeight.bold)),
                        subtitle: Text(meeting.data()['dateTime'],
                            style: GoogleFonts.sourceSansPro(
                                fontSize: 15,
                                color: Colors.black,
                                letterSpacing: 1))),
                    // Location Info
                    ListTile(
                        leading: Icon(
                          Icons.map,
                          color: primaryColor,
                        ),
                        contentPadding: const EdgeInsets.all(5.0),
                        title: Text('Location',
                            style: GoogleFonts.sourceSansPro(
                                fontSize: 20,
                                color: primaryColor,
                                letterSpacing: 1,
                                fontWeight: FontWeight.bold)),
                        subtitle: Text(meeting.data()['location'],
                            style: GoogleFonts.sourceSansPro(
                                fontSize: 15,
                                color: Colors.black,
                                letterSpacing: 1))),
                  ],
                ),
                // View who is attending List
                ListTile(
                  leading: Icon(
                    Icons.people,
                    color: primaryColor,
                  ),
                  contentPadding: const EdgeInsets.all(5.0),
                  title: Text('List of Attendee Emails',
                      style: GoogleFonts.sourceSansPro(
                          fontSize: 20,
                          color: primaryColor,
                          letterSpacing: 1,
                          fontWeight: FontWeight.bold)),
                  subtitle: Text(
                    'Response',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                        color: primaryColor),
                  ),
                ),

                Expanded(
                  child: Container(
                    color: Colors.grey.shade200,
                    child: ListView.builder(
                      itemCount: meeting
                          .data()['attendeeList']
                          .length, // filler till we have actual list length
                      itemBuilder: (context, index) {
                        return ListTile(
                          // will change to variables / values when we have actual list to grab from
                          trailing: Icon(
                            meeting
                                        .data()['attendeeList'][index]
                                            ['response']
                                        .toString() ==
                                    "true"
                                ? Icons.done
                                : meeting
                                            .data()['attendeeList'][index]
                                                ['response']
                                            .toString() ==
                                        "false"
                                    ? Icons.clear
                                    : Icons.minimize_rounded,
                            color: meeting
                                        .data()['attendeeList'][index]
                                            ['response']
                                        .toString() ==
                                    "true"
                                ? Colors.green
                                : meeting
                                            .data()['attendeeList'][index]
                                                ['response']
                                            .toString() ==
                                        "false"
                                    ? Colors.red
                                    : Colors.grey,
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
