import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncup/constants.dart';


class InfoCard extends StatelessWidget {
  final String text;
  final IconData icon;
 

  InfoCard({
    @required this.text,
    @required this.icon,

  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
        color: Colors.white,
        margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
        child: ListTile(
          leading: Icon(
            icon,
            color: primaryColor,
          ),
          title: Text(
            text,
            style: GoogleFonts.sourceSansPro(fontSize: 20, color: primaryColor),
          ),
        ),
      ),
    );
  }
}