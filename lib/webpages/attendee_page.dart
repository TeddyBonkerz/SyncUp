import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncup/constants.dart';

import 'attendee_response.dart';

class CheckAttendee extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CheckAttendeeState();
  }
}

class CheckAttendeeState extends State<CheckAttendee> {
  String attendeeEmail;

  Widget _buildEmail() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Email'),
      // ignore: missing_return
      validator: (String value) {
        if (value.isEmpty) {
          return 'Email is Required';
        }
      },
      onSaved: (String value) {
        attendeeEmail = value;
      },
    );
  }

  Widget _buildEmailText() {
    return Text(
      'Please Enter Your Email',
      style: TextStyle(
          fontSize: 30.0, fontWeight: FontWeight.bold, color: Colors.black),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Sync',
              style: GoogleFonts.mcLaren(
                textStyle: TextStyle(
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            Text(
              'Up',
              style: GoogleFonts.mcLaren(
                textStyle: TextStyle(
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold,
                    color: primaryColor),
              ),
            ),
          ],
        ),
      ),
      body: Container(
        margin: EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _buildEmailText(),
            SizedBox(height: 20),
            _buildEmail(),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text(
                'Submit',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              onPressed: () => {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => AttendeeResponse()),
                  (Route<dynamic> route) => false,
                ),
              },
            ),
          ],
        ),
      ),
    );
  }
}
