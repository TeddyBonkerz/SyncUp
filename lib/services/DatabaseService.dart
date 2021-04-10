import 'package:syncup/models/meetingModel.dart';
import 'package:syncup/models/userModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:syncup/models/attendeeModel.dart';

class DatabaseService {
  final String uId;
  final String firstName;
  final String lastName;
  // final String organizer;

  DatabaseService({this.uId, this.lastName, this.firstName});

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  // Stream<List<Meeting>> getmeetingList() {
  //   Stream<List<Meeting>> meetingList = userCollection
  //       .doc(uId)
  //       .collection('meeting')
  //       .snapshots()
  //       .map((snapshot) => snapshot.docs
  //           .map((document) => Meeting.fromJson(document.data()))
  //           .toList());
  //   return meetingList;
  // }

  Stream getStream() {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('meeting')
        .snapshots();
  }

  Future<void> createUserData() async {
    // userCollection.doc(uId).collection('meeting');
    return userCollection
        .doc(uId)
        .set({'firstName': firstName, 'lastName': lastName});
  }

  Future<void> deleteMeeting(String meetingId) {
    return userCollection
        .doc(uId)
        .collection('meeting')
        .doc(meetingId)
        .delete()
        .then((value) => print("Meeting Deleted"))
        .catchError((error) => print("Failed to delete meeting: $error"));
  }

  Future<void> addMeeting(String title, String content, String dateTime,
      String location, List<String> list) async {
    print(userCollection.doc(uId));
    // String organizer;
    // await userCollection.doc(uId).get().then((snapshot) {
    //   organizer = snapshot.get('organizer').toString();
    // });
    List<Map<String, Object>> attendeeList =
        list.map((e) => {'email': e, 'response': false}).toList();
    return await userCollection.doc(uId).collection('meeting').add({
      'title': title,
      'content': content,
      'dateTime': dateTime,
      'location': location,
      'attendeeList': attendeeList,
      'completed': false,
      // 'organizer': organizer,
    });
  }
}
