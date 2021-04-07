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
      FirebaseFirestore.instance.collection('user');

  Stream<List<Meeting>> getmeetingList() {
    Stream<List<Meeting>> meetingList = userCollection
        .doc(uId)
        .collection('meeting')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((document) => Meeting.fromJson(document.data()))
            .toList());
    print("stream here $meetingList");
    return meetingList;
  }

  Future<void> createUserData() async {
    // userCollection.doc(uId).collection('meeting');
    return userCollection
        .doc(uId)
        .set({'firtName': firstName, 'lastName': lastName});
  }

  Future<void> addMeeting(String title, String content, String dateTime,
      String location, List<String> list) async {
    print(userCollection.doc(uId));
    // String organizer;
    // await userCollection.doc(uId).get().then((snapshot) {
    //   organizer = snapshot.get('organizer').toString();
    // });
    return await userCollection.doc(uId).collection('meeting').add({
      'title': title,
      'content': content,
      'dateTime': dateTime,
      'location': location,
      'attendeeList': list,
      // 'organizer': organizer,
      'numberYes': 0,
      'numberNo': 0,
    });
  }
}
