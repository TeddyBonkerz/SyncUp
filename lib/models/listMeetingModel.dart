import 'package:syncup/models/meetingModel.dart';
import 'package:syncup/models/attendeeModel.dart';

class MeetingList {
  MeetingList._privateConstructor();

  static final MeetingList instance = MeetingList._privateConstructor();
  List<Meeting> meetingList = [];
}
