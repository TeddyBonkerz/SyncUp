import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:syncup/constants.dart';
import 'package:syncup/screens/home.dart';

class MeetingDetails extends StatefulWidget{
  @override
  _MeetingDetails createState() => _MeetingDetails();
}

class _MeetingDetails extends State<MeetingDetails> {
  bool checkCompleted = false; // check box value for complete or not
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MeetingTitle'),
        ),
        body: Column(
          children: <Widget>[
            //General Info: Description, time / date, Complete or not
            ListTile(
              contentPadding: const EdgeInsets.all(10.0),
              title: Text('Meeting Description Meeting Description Meeting Description Meeting Description Meeting Description Meeting Description Meeting Description Meeting Description Meeting Description Meeting Description Meeting Description',
                    textAlign: TextAlign.center,
              ),
            ),
            // Time and Date Info
            ListTile(
              contentPadding: const EdgeInsets.all(10.0),
              title: Text('Time / Date'),
              subtitle: Text('##:## AM/PM @@,@@@@')
            ),
            // Location Info
            ListTile(
              contentPadding: const EdgeInsets.all(10.0),
              title: Text('Location'),
              subtitle: Text('TestLocation')
            ),
            // Meeting Check box for completion status
            CheckboxListTile(
              title: const Text('Meeting Completed: '),
              value: checkCompleted,
              onChanged: (bool value){
                setState(() {
                  checkCompleted = value;
                });
              }
            ),
            // List of People Coming
            
        ],)
    );
  }
}