import 'package:flutter/material.dart';
import 'package:syncup/constants.dart';
import 'package:syncup/models/attendeeModel.dart';
import 'package:syncup/models/listMeetingModel.dart';
import 'package:syncup/models/meetingModel.dart';
import 'package:syncup/screens/home.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class CreateMeeting extends StatefulWidget {
  @override
  _CreateMeetingState createState() => _CreateMeetingState();
}

class _CreateMeetingState extends State<CreateMeeting> {
  final _subjectText = TextEditingController();
  final _contentText = TextEditingController();
  final _emailList = TextEditingController();
  // final _passwordText = TextEditingController();
  bool _validateSubject = true;
  // bool _validateContent = true;
  bool _validateEmail = true;
  // bool _validatePassword = true;

  DateTime selectedDate;
  String date;
  TimeOfDay selectedTime;
  String time;
  String subject;
  String content;
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
    return Scaffold(
      // resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('Create A Meeting'),
      ),
      body: SingleChildScrollView(
        // child: Container(
        //   padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50),
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
                // controller: _firstNameText,
                decoration: InputDecoration(
                  // errorText: _validateFirstName
                  //     ? null
                  //     : 'First name cannot be empty',
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
              // Text("${selectedDate.toLocal()}".split(' ')[0]),
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
                      }
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
sendEmail(String subject, String content, String date, String time,
    List<String> emailList) async {
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
            '\n <p><b>Description: </b>' +
            content +
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

showAlertDialog(BuildContext context, String subject, String content,
    String date, String time, List<String> emailList) {
  // set up the buttons
  Widget cancelButton = TextButton(
    child: Text("Go back"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );
  Widget continueButton = TextButton(
    child: Text("Confirm"),
    onPressed: () {
      Meeting meeting = Meeting(
          meetingId: '0',
          organizer: 'ABC',
          title: subject,
          description: content,
          meetingDate: '$date at $time',
          attendees: emailList.map((email) => Attendee(email: email)).toList());
      MeetingList.instance.meetingList.add(meeting);

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
        (Route<dynamic> route) => false,
      );
      sendEmail(subject, content, date, time, emailList);
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
                "Date & Time:",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 5.0),
              Text("$date at $time"),
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
