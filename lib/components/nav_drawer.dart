import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:syncup/models/userModel.dart';
import 'package:syncup/screens/home.dart';
import 'package:syncup/screens/user_profile.dart';
import 'package:syncup/screens/about.dart';
import 'package:syncup/services/authenticationservice.dart';

import '../constants.dart';

class NavDrawer extends StatelessWidget {
  final AuthService _firebaseAuth = AuthService();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel>(context);

    Future<DocumentSnapshot> getData() async {
      return FirebaseFirestore.instance.collection('users').doc(user.uId).get();
    }

    return FutureBuilder<DocumentSnapshot>(
        future: getData(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text("Something went wrong");
          }

          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data = snapshot.data.data();
            return Drawer(
              child: Column(
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(20),
                    color: primaryColor,
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
                                image: AssetImage('assets/images/grim.webp'),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          //Nav Drawer Name
                          Text(
                            data['firstName'].toString() +
                                ' ' +
                                data['lastName'].toString(),
                            style: GoogleFonts.sourceSansPro(
                              textStyle: TextStyle(
                                fontSize: 25,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          //Nav Drawer Email
                          Text(
                            user.email,
                            style: GoogleFonts.sourceSansPro(
                              textStyle: TextStyle(
                                fontSize: 18,
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
                        style: GoogleFonts.sourceSansPro(
                          textStyle: TextStyle(
                            fontSize: 18,
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
                      style: GoogleFonts.sourceSansPro(
                        textStyle: TextStyle(
                          fontSize: 18,
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
                    leading: Icon(Icons.info, color: Colors.black),
                    title: Text(
                      'About',
                      style: GoogleFonts.sourceSansPro(
                        textStyle: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => AboutScreen()),
                        (Route route) => false,
                      );
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.logout, color: Colors.black),
                    title: Text(
                      'LogOut',
                      style: GoogleFonts.sourceSansPro(
                        textStyle: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    onTap: () async {
                      await _firebaseAuth.signOut();
                      // Navigator.pushAndRemoveUntil(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => Wrapper()),
                      //   (Route route) => false,
                      // );
                    },
                  )
                ],
              ),
            );
          }
          return Text("loading");
        });
  }
}
