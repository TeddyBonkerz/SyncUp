import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncup/constants.dart';
import 'package:syncup/models/attendeeModel.dart';
import 'package:syncup/models/listMeetingModel.dart';
import 'package:syncup/models/meetingModel.dart';
import 'package:syncup/models/userModel.dart';
import 'package:syncup/screens/home.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:syncup/services/DatabaseService.dart';

class CreateMeeting extends StatefulWidget {
  @override
  _CreateMeetingState createState() => _CreateMeetingState();
}

class _CreateMeetingState extends State<CreateMeeting> {
  final _subjectText = TextEditingController();
  final _contentText = TextEditingController();
  final _emailList = TextEditingController();
<<<<<<< HEAD
  final _locationText = TextEditingController();

||||||| merged common ancestors
  // final _passwordText = TextEditingController();
=======
  final _locationText = TextEditingController();
  // final _passwordText = TextEditingController();
>>>>>>> 417e877b140a086117b405a1550964472906df03
  bool _validateSubject = true;
  bool _validateEmail = true;
<<<<<<< HEAD
  bool _validateLocation = true;
||||||| merged common ancestors
  // bool _validatePassword = true;
=======
  // bool _validatePassword = true;
  bool _validateLocation = true;
>>>>>>> 417e877b140a086117b405a1550964472906df03

  DateTime selectedDate;
  String date;
  TimeOfDay selectedTime;
  String time;
  String subject;
  String content;
  String location;
  List<String> emailList;
  String error = '';

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate == null ? DateTime.now() : selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        date = "${selectedDate.toLocal()}".split(' ')[0];
      });
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay picked_s = await showTimePicker(
        context: context,
        initialTime: selectedTime == null ? TimeOfDay.now() : selectedTime,
        builder: (BuildContext context, Widget child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
            child: child,
          );
        });

    if (picked_s != null && picked_s != selectedTime)
      setState(() {
        selectedTime = picked_s;
        time = picked_s.format(context);
      });
  }

  @override
  Widget build(BuildContext context) {
    UserModel user = Provider.of<UserModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Create A Meeting'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 80.0, horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              TextField(
                controller: _subjectText,
                decoration: InputDecoration(
                  errorText:
                      _validateSubject ? null : 'Subject cannot be empty',
                  icon: Icon(
                    Icons.topic_outlined,
                    color: primaryColor,
                  ),
                  labelText: 'Subject',
                  labelStyle: TextStyle(
                      //fontWeight: FontWeight.bold,
                      fontFamily: 'Montserrat',
                      color: Colors.grey),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: primaryColor),
                  ),
                ),
              ),
              TextField(
                controller: _contentText,
                keyboardType: TextInputType.multiline,
                minLines: 1,
                maxLines: 3,
                decoration: InputDecoration(
                  icon: Icon(
                    Icons.content_paste_rounded,
                    color: primaryColor,
                  ),
                  labelText: 'Content',
                  labelStyle: TextStyle(
                      //fontWeight: FontWeight.bold,
                      fontFamily: 'Montserrat',
                      color: Colors.grey),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: primaryColor),
                  ),
                ),
              ),
              TextField(
                controller: _locationText,
                decoration: InputDecoration(
                  errorText:
                      _validateLocation ? null : 'Location cannot be empty',
                  icon: Icon(
                    Icons.location_on,
                    color: primaryColor,
                  ),
                  labelText: 'Location',
                  labelStyle: TextStyle(
                      //fontWeight: FontWeight.bold,
                      fontFamily: 'Montserrat',
                      color: Colors.grey),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: primaryColor),
                  ),
                ),
              ),
              // Text("${selectedDate.toLocal()}".split(' ')[0]),
              TextField(
                controller: _locationText,
                decoration: InputDecoration(
                  errorText:
                      _validateLocation ? null : 'Location cannot be empty',
                  icon: Icon(
                    Icons.location_pin,
                    color: primaryColor,
                  ),
                  labelText: 'Location',
                  labelStyle: TextStyle(
                      //fontWeight: FontWeight.bold,
                      fontFamily: 'Montserrat',
                      color: Colors.grey),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: primaryColor),
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Row(
                children: <Widget>[
                  Icon(
                    Icons.calendar_today_rounded,
                    color: primaryColor,
                  ),
                  SizedBox(width: 15.0),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      primary: primaryColor,
                    ),
                    onPressed: () => _selectDate(context),
                    // child: Text('Select date'),
                    child: Text(
                      selectedDate == null
                          ? 'Select a date'
                          : "${selectedDate.toLocal()}".split(' ')[0],
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Icon(
                    Icons.av_timer_rounded,
                    color: primaryColor,
                  ),
                  SizedBox(width: 15.0),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      primary: primaryColor,
                    ),
                    onPressed: () => _selectTime(context),
                    // child: Text('Select date'),
                    child: Text(
                      selectedTime == null
                          ? 'Select time'
                          : selectedTime.format(context),
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              TextField(
                controller: _emailList,
                keyboardType: TextInputType.multiline,
                minLines: 1,
                maxLines: 3,
                // controller: _firstNameText,
                decoration: InputDecoration(
                  errorText:
                      _validateEmail ? null : 'Email list cannot be empty',
                  icon: Icon(
                    Icons.alternate_email_rounded,
                    color: primaryColor,
                  ),
                  labelText: "invitees' emails (seperate by new line)",
                  labelStyle: TextStyle(
                      //fontWeight: FontWeight.bold,
                      fontFamily: 'Montserrat',
                      color: Colors.grey),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: primaryColor),
                  ),
                ),
              ),
              SizedBox(height: 10.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  primary: primaryColor,
                ),
                onPressed: () {
<<<<<<< HEAD
                  setState(
                    () {
                      bool subjectTextValid = _subjectText.text.isNotEmpty;
                      bool emailListValid = _emailList.text.isNotEmpty;
                      bool locationTextValid = _locationText.text.isNotEmpty;
                      if (subjectTextValid &&
                          emailListValid &&
                          locationTextValid &&
                          date != null &&
                          time != null) {
                        error = '';
                        _validateEmail = true;
                        _validateSubject = true;
                        _validateLocation = true;
                        subject = _subjectText.text.toString();
                        content = _contentText.text.toString();
                        location = _locationText.text.toString();
                        emailList = _emailList.text.toString().split("\n");
||||||| merged common ancestors
                  setState(() {
                    bool subjectTextValid = _subjectText.text.isNotEmpty;
                    bool emailListValid = _emailList.text.isNotEmpty;
                    if (subjectTextValid &&
                        emailListValid &&
                        date != null &&
                        time != null) {
                      error = '';
                      _validateEmail = true;
                      _validateSubject = true;
                      subject = _subjectText.text.toString();
                      content = _contentText.text.toString();
                      emailList = _emailList.text.toString().split("\n");
=======
                  setState(() {
                    bool subjectTextValid = _subjectText.text.isNotEmpty;
                    bool emailListValid = _emailList.text.isNotEmpty;
                    bool locationTextValid = _locationText.text.isNotEmpty;
                    if (subjectTextValid &&
                        emailListValid &&
                        locationTextValid &&
                        date != null &&
                        time != null) {
                      error = '';
                      _validateEmail = true;
                      _validateSubject = true;
                      _validateLocation = true;
                      location = _locationText.text.toString();
                      subject = _subjectText.text.toString();
                      content = _contentText.text.toString();
                      emailList = _emailList.text.toString().split("\n");
>>>>>>> 417e877b140a086117b405a1550964472906df03

<<<<<<< HEAD
                        showAlertDialog(context, subject, content, date, time,
                            location, emailList, user);
                        print("$subject $date $time $content $emailList");
                      } else {
                        if (!subjectTextValid) {
                          _validateSubject = false;
                        }
                        if (!emailListValid) {
                          _validateEmail = false;
                        }
                        if (date == null || time == null) {
                          error = "You haven't chosen date or time";
                        }
||||||| merged common ancestors
                      showAlertDialog(
                          context, subject, content, date, time, emailList);
                      print("$subject $date $time $content $emailList");
                    } else {
                      if (!subjectTextValid) {
                        _validateSubject = false;
                      }
                      if (!emailListValid) {
                        _validateEmail = false;
                      }
                      if (date == null || time == null) {
                        error = "You haven't chosen date or time";
=======
                      showAlertDialog(context, subject, location, content, date,
                          time, emailList);
                      print("$subject $date $time $content $emailList");
                    } else {
                      if (!subjectTextValid) {
                        _validateSubject = false;
                      }
                      if (!locationTextValid) {
                        _validateLocation = false;
                      }
                      if (!emailListValid) {
                        _validateEmail = false;
                      }
                      if (date == null || time == null) {
                        error = "You haven't chosen date or time";
>>>>>>> 417e877b140a086117b405a1550964472906df03
                      }
<<<<<<< HEAD
                    },
                  );
||||||| merged common ancestors
                    }
                  });

                  // setState(() {
                  //   subject = _subjectText.text.toString();
                  //   content = _contentText.text.toString();
                  //   emailList = _emailList.text.toString().split("\n");
                  // });
                  // showAlertDialog(
                  //     context, subject, content, date, time, emailList);
                  // print("$subject $date $time $content $emailList");
=======
                    }
                  });
>>>>>>> 417e877b140a086117b405a1550964472906df03
                },
                child: Text(
                  'Create',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              Text(
                error,
                style: TextStyle(color: Colors.red, fontSize: 14.0),
              ),
            ],
          ),
        ),
      ),
    );
    // );
  }
}

//Method for sending email to recipients
<<<<<<< HEAD
sendEmail(String subject, String content, String date, String time,
    String location, List<String> emailList) async {
||||||| merged common ancestors
sendEmail(String subject, String content, String date, String time,
    List<String> emailList) async {
=======
sendEmail(String subject, String content, String location, String date,
    String time, List<String> emailList) async {
>>>>>>> 417e877b140a086117b405a1550964472906df03
  //Enter email and password, ensure you enable less secure app access if its a gmail account
  String username = 'mysyncupapp@gmail.com';
  String password = 'cYQ3gUZp7X@hPeG';

  final smtpServer = gmail(username, password);

  // Create our message.
  final message = Message()
    ..from = Address(username, 'Team SyncUp')
    ..recipients.addAll(emailList)
    ..bccRecipients.add(Address(username))
    ..subject = 'SyncUp Invite ${DateTime.now()}'
    ..html =
        '<h3>Hello</h3>\n<p>**Sender Name Here** has sent you a SyncUp invitation with the details below.</p>' +
            '\n <p><b>Title: </b>' +
            subject +
            '</p>' +
            '\n <p><b>Location: </b>' +
            location +
            '</p>' +
            '\n <p><b>Description: </b>' +
            content +
            '</p>' +
            '\n <p><b>Location: </b>' +
            location +
            '</p>' +
            '\n <p><b>Date & Time: </b>' +
            date +
            ',' +
            time +
            '</p>' +
            '\n <p>To respond, follow the link below.</p> \n **Link To Response Form**';

  try {
    final sendReport = await send(message, smtpServer);
    print('Message sent: ' + sendReport.toString());
  } on MailerException catch (e) {
    print('Message not sent.');
    for (var p in e.problems) {
      print('Problem: ${p.code}: ${p.msg}');
    }
  }
}

<<<<<<< HEAD
showAlertDialog(
    BuildContext context,
    String subject,
    String content,
    String date,
    String time,
    String location,
    List<String> emailList,
    UserModel user) {
||||||| merged common ancestors
showAlertDialog(BuildContext context, String subject, String content,
    String date, String time, List<String> emailList) {
=======
showAlertDialog(BuildContext context, String subject, String location,
    String content, String date, String time, List<String> emailList) {
>>>>>>> 417e877b140a086117b405a1550964472906df03
  // set up the buttons
  Widget cancelButton = TextButton(
    child: Text("Go back"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );
  Widget continueButton = TextButton(
    child: Text("Confirm"),
    onPressed: () async {
      Meeting meeting = Meeting(
          meetingId: '0',
<<<<<<< HEAD
          // organizer: 'ABC',
||||||| merged common ancestors
          organizer: 'ABC',
=======
          // organizer: 'ABC',
          location: location,
>>>>>>> 417e877b140a086117b405a1550964472906df03
          title: subject,
          description: content,
          meetingDate: '$date at $time',
          location: location,
          attendees: emailList.map((email) => Attendee(email: email)).toList());
      MeetingList.instance.meetingList.add(meeting);
      await DatabaseService(uId: user.uId)
          .addMeeting(subject, content, '$date at $time', location, emailList);

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
        (Route<dynamic> route) => false,
      );
<<<<<<< HEAD
      sendEmail(subject, content, date, time, location, emailList);
||||||| merged common ancestors
      sendEmail(subject, content, date, time, emailList);
=======
      sendEmail(subject, content, location, date, time, emailList);
>>>>>>> 417e877b140a086117b405a1550964472906df03
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Confirmation"),
    content: Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                "Title:",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 5.0),
              Text("$subject"),
            ],
          ),
          Row(
            children: <Widget>[
              Text(
                "Location:",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 5.0),
              Text("$location"),
            ],
          ),
          Row(
            children: <Widget>[
              Text(
                "Date & Time:",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 5.0),
              Text("$date at $time"),
            ],
          ),
          Row(
            children: <Widget>[
              Text(
                "Location:",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 5.0),
              Text(location),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Email List:",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 5.0),
              Column(
                children: emailList.map((item) => new Text(item)).toList(),
              )
            ],
          ),
        ],
      ),
    ),
    actions: [
      cancelButton,
      continueButton,
    ],
  );
  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
