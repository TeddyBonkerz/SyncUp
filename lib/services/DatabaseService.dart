import 'package:syncup/models/meetingModel.dart';
import 'package:syncup/models/userModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:syncup/models/attendeeModel.dart';

class DatabaseService {
  final String uId;
  final String firstName;
  final String lastName;
  String organizer;

  DatabaseService({this.uId, this.lastName, this.firstName, this.organizer});

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('user');

  Future<String> getOrganizer() async {
    await userCollection.doc(uId).get().then((snapshot) {
      organizer = snapshot.get('organizer').toString();
    });
    print("organizer here: $organizer");
    dynamic collection = userCollection
        .doc(uId)
        .collection('meeting')
        .get()
        .then((QuerySnapshot querySnapshot) {
      _meetingListFromSnapshot(querySnapshot);
    });
    // .get()
    // .then((value) => _meetingListFromSnapshot(value));
  }

  List<Meeting> _meetingListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs
        .map((e) => Meeting(
              meetingId: e.id,
              meetingDate: e.data()['dateTime'].toString(),
              title: e.data()['title'].toString(),
              description: e.data()['content'].toString(),
              location: e.data()['location'].toString(),
              attendees: e
                  .data()['attendeeList']
                  .map((email) => Attendee(email: email)),
              organizer: organizer,
            ))
        .toList();

    //   ((doc) {
    //     return Meeting(
    //       meetingId: doc.id,
    //       meetingDate: doc.data()['dateTime'].toString(),
    //       title: doc.data()['title'].toString(),
    //       description: doc.data()['content'].toString(),
    //       location: doc.data()['location'].toString(),
    //       attendees:
    //           doc.data()['attendeeList'].map((email) => Attendee(email: email)),
    //       organizer: organizer,
    //     );
    // }).toList();
  }

  Stream<List<Meeting>> get meetingList {
    return userCollection
        .doc(uId)
        .collection('meeting')
        .snapshots()
        .map(_meetingListFromSnapshot);
  }

  Future<void> createUserData() async {
    // userCollection.doc(uId).collection('meeting');
    return userCollection.doc(uId).set(
        {'firtName': firstName, 'lastName': lastName, 'organizer': organizer});
  }

  Future<void> addMeeting(String title, String content, String dateTime,
      String location, List<String> list) async {
    print(userCollection.doc(uId));
    return await userCollection.doc(uId).collection('meeting').add({
      'title': title,
      'content': content,
      'dateTime': dateTime,
      'location': location,
      'attendeeList': list,
    });
  }
}
