import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:empty_widget/empty_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:syncup/constants.dart';
import 'package:syncup/models/meetingModel.dart';
import 'package:syncup/models/userModel.dart';
import 'package:syncup/screens/loading.dart';
import 'package:syncup/screens/meeting_details.dart';
import 'package:syncup/models/listMeetingModel.dart';

class HomePageCards extends StatelessWidget {
  //example list
  final List<Meeting> meetingList = MeetingList.instance.meetingList;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel>(context);
    String uId = user.uId;
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    return StreamBuilder<QuerySnapshot>(
      stream: users.doc(uId).collection('meeting').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Loading();
        }
        if (snapshot.data.docs.length == 0) {
          return Scaffold(
            body: Center(
              child: Container(
                height: 500,
                width: 350,
                child: EmptyListWidget(
                    image: null,
                    packageImage: PackageImage.Image_1,
                    title: 'No Open Meetings',
                    //subTitle: 'No  notification available yet',
                    titleTextStyle: Theme.of(context)
                        .typography
                        .dense
                        .headline4
                        .copyWith(color: Color(0xff9da9c7)),
                    subtitleTextStyle: Theme.of(context)
                        .typography
                        .dense
                        .bodyText1
                        .copyWith(color: Color(0xffabb8d6))),
              ),
            ),
          );
        }
        return Scaffold(
          body: ListView.builder(
            itemCount: snapshot.data.docs.length,
            itemBuilder: (BuildContext context, int index) =>
                buildMeetingCard(context, index, snapshot.data.docs),
          ),
        );
      },
    );
  }

//Actual list of cards
  Widget buildMeetingCard(BuildContext context, int index,
      List<QueryDocumentSnapshot> meetingList) {
    int totalAttendees = meetingList[index].data()['attendeeList'].length;
    int totalAcceptedAttendees = 0;

    for (int i = 0; i < totalAttendees; i++) {
      bool response = meetingList[index].data()['attendeeList'][i]['response'];
      if (response == true) {
        totalAcceptedAttendees++;
      }
    }

    String participants = " " +
        totalAcceptedAttendees.toString() +
        "/" +
        totalAttendees.toString() +
        " Participant(s)";

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
                  backgroundColor: primaryLightColor,
                  child: Text(
                    meetingList[index]
                        .data()['title']
                        .toString()
                        .substring(0, 1),
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                Padding(padding: EdgeInsets.only(left: 16)),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        meetingList[index].data()['title'].toString(),
                        style: GoogleFonts.sourceSansPro(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(top: 8)),
                      Text(
                        meetingList[index].data()['content'],
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Padding(padding: EdgeInsets.only(left: 16)),
                      Padding(padding: EdgeInsets.only(top: 8)),
                      Divider(
                        thickness: 2.0,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.people,
                            color: primaryLightColor,
                          ),
                          Text(
                            participants,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
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
