import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncup/constants.dart';

class AttendeeResponse extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AttendeeResponseState();
  }
}

class AttendeeResponseState extends State<AttendeeResponse> {

  Widget _buildMeetingDetails() {
    //Build meeting details based on meeting ID
    return Text(
      '**Meeting Details should be here',
      style: TextStyle(
          fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.black),
    );
  }

  Widget _buildResponse() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ElevatedButton(
          child: Text(
            'Confirm',
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
          onPressed: () => {},
        ),
        SizedBox(width: 20),
        ElevatedButton(
          child: Text(
            'Decline',
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
          style: ElevatedButton.styleFrom(
            primary: Colors.red, // background
          ),
          onPressed: () => {},
        ),
      ],
    );
  }

  Widget _buildResponsePrompt() {
    return Text(
      'Would you like to attend ?',
      style: TextStyle(
          fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.black),
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
            _buildMeetingDetails(),
            SizedBox(height: 20),
            _buildResponsePrompt(),
            SizedBox(height: 20),
            _buildResponse(),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
