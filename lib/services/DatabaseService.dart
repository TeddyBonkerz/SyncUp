import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uId;
  final String firstName;
  final String lastName;
  // final String organizer;

  DatabaseService({this.uId, this.lastName, this.firstName});

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  Stream getStream() {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('meeting')
        .snapshots();
  }

  Future<void> createUserData() async {
    return userCollection.doc(uId).set(
      {'firstName': firstName, 'lastName': lastName},
    );
  }

  Future<void> deleteMeeting(String meetingId) {
    return userCollection
        .doc(uId)
        .collection('meeting')
        .doc(meetingId)
        .delete()
        .then(
          (value) => print("Meeting Deleted"),
        )
        .catchError(
          (error) => print("Failed to delete meeting: $error"),
        );
  }

  Future<void> addMeeting(String title, String content, String dateTime,
      String location, List<String> list) async {
    print(
      userCollection.doc(uId),
    );

    List<Map<String, Object>> attendeeList =
        list.map((e) => {'email': e, 'response': false}).toList();
    return await userCollection.doc(uId).collection('meeting').add(
      {
        'title': title,
        'content': content,
        'dateTime': dateTime,
        'location': location,
        'attendeeList': attendeeList,
        'completed': false,
      },
    );
  }
}
