import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:syncup/components/info_card.dart';
import 'package:syncup/components/nav_drawer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncup/constants.dart';

const email = 'Gmunchkins@yahoo.com';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text('Profile Screen'),
        ),
        //drawer: NavDrawer(),
        body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 100,
              backgroundImage: AssetImage('assets/images/grim.webp'),
            ),
            Text('Grim Fandango',
                style: GoogleFonts.pacifico(
                    fontSize: 40,
                    color: Colors.white,
                    fontWeight: FontWeight.bold)),
            Text(
              'Software Engineer',
              style: GoogleFonts.sourceSansPro(
                  fontSize: 30,
                  color: primaryColor,
                  letterSpacing: 2.5,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
              width: 200,
              child: Divider(
                color: Colors.teal.shade700,
              ),
            ),
            InfoCard(
              text: email,
              icon: Icons.email,
            ),
            Container(
              height: 30.0,
              width: 95.0,
              child: Material(
                borderRadius: BorderRadius.circular(5.0),
                shadowColor: Colors.blueAccent,
                color: primaryColor,
                elevation: 7.0,
                child: GestureDetector(
                  onTap: () {},
                  child: Center(
                    child: Text(
                      'Update Profile',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Montserrat'),
                    ),
                  ),
                ),
               ))
          
          ],
        ),
      ),
      backgroundColor: primaryLightColor,
    );
  }
}


class getClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();

    path.lineTo(0.0, size.height / 1.9);
    path.lineTo(size.width + 125, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    // TODO
    return true;
  }
}
