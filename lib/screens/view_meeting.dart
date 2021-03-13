import 'package:flutter/material.dart';
import 'package:syncup/constants.dart';


class ViewMeeting extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget> [
        Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Text(
              'MeetingTitle',
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontWeight: FontWeight.bold),
              ),
            ],),
            SizedBox(
              height: 30,
              ),
            ListTile(
              title: Text(
                'Meeting Detail:'
              ),
              subtitle: Text(
                'Meeting filler info to see if this wraps around the application screen'
              ),
            ),
            ListTile(
              title: Text(
                'Meeting Time & Date'
              ),
              subtitle: Text(
                '##:## AM/PM  @@/@@@@'
              ),
            ),
            ListTile(
              title: Text(
                'Meeting Location'
              ),
              subtitle: Text(
                'Location'
              ),
            ),
            ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: 10, // how many people going
              itemBuilder: (BuildContext context, int index){
                return Container(
                  height: 50,
                  margin: EdgeInsets.all(2),
                  color: primaryColor,
                  child: Center(
                    child: Text (
                        'name email'
                        // style: anystyle
                      ),
                    ),  
                );
              }
            ),
          CheckboxListTile(
            title: Text("Is the meeting complete?"),
            secondary: Icon(Icons.check),
            controlAffinity: 
            ListTileControlAffinity.leading,
            // need to tie in a way to save state
            // value: _checked,
            // onChanged: (bool value){
            //   setState((){
            //     _checked = value;
            //   });
            // }
          )
      ],
    );
  }
}