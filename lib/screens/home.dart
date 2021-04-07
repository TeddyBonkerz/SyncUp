import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncup/components/meeting_cards.dart';
import 'package:syncup/components/nav_drawer.dart';
import 'package:syncup/constants.dart';
import 'package:syncup/models/meetingModel.dart';
import 'package:syncup/services/DatabaseService.dart';
import 'create_meeting.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SyncUp'),
      ),
      //Side Menu Drawer For Easy Navigation
      drawer: NavDrawer(),
      body: Container(
        child: HomePageCards(),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        child: Icon(
          Icons.create,
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CreateMeeting(),
            ),
          );
        },
      ),
    );
  }
}
