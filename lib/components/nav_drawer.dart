import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncup/models/userModel.dart';
import 'package:syncup/screens/home.dart';
import 'package:syncup/screens/login.dart';
import 'package:syncup/screens/user_profile.dart';

class NavDrawer extends StatelessWidget {
  final User appUser = new User(
      uId: 1011,
      firstName: "Grim",
      lastName: "Fandango",
      email: "Gmunchkins@yahoo.com",
      password: "stuff");

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20),
            color: Theme.of(context).primaryColor,
            child: Center(
              child: Column(
                children: <Widget>[
                  //Nav Drawer Profile Space
                  Container(
                    width: 100,
                    height: 100,
                    margin: EdgeInsets.only(
                      top: 30,
                      bottom: 10,
                    ),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage('assets/images/default_profile.png'),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  //Nav Drawer Name
                  Text(
                    appUser.firstName + ' ' + appUser.lastName,
                    style: GoogleFonts.mcLaren(
                      textStyle: TextStyle(
                        fontSize: 22,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  //Nav Drawer Email
                  Text(
                    appUser.email,
                    style: GoogleFonts.mcLaren(
                      textStyle: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          //List of Navigations from the Nav Drawer
          ListTile(
              leading: Icon(Icons.house, color: Colors.black),
              title: Text(
                'Home',
                style: GoogleFonts.lato(
                  textStyle: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                  ),
                ),
              ),
              onTap: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                  (Route<dynamic> route) => false,
                );
              }),
          ListTile(
            leading: Icon(Icons.person, color: Colors.black),
            title: Text(
              'Profile',
              style: GoogleFonts.lato(
                textStyle: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                ),
              ),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfileScreen(),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.settings, color: Colors.black),
            title: Text(
              'Settings',
              style: GoogleFonts.lato(
                textStyle: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.info, color: Colors.black),
            title: Text(
              'About',
              style: GoogleFonts.lato(
                textStyle: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.logout, color: Colors.black),
            title: Text(
              'LogOut',
              style: GoogleFonts.lato(
                textStyle: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                ),
              ),
            ),
            onTap: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
                (Route route) => false,
              );
            },
          )
        ],
      ),
    );
  }
}
