import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:syncup/models/userModel.dart';
import 'package:syncup/screens/home.dart';
import 'package:syncup/screens/user_profile.dart';
import 'package:syncup/screens/about.dart';
import 'package:syncup/screens/wrapper.dart';
import 'package:syncup/services/authenticationservice.dart';

class NavDrawer extends StatelessWidget {
  final AuthService _firebaseAuth = AuthService();

  // final UserModel appUser =
  //     new UserModel(uId: "1011", firstName: "Grim", lastName: "Fandango");

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel>(context);

    return FutureBuilder<DocumentSnapshot>(
        future:
            FirebaseFirestore.instance.collection('users').doc(user.uId).get(),
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
                            style: GoogleFonts.mcLaren(
                              textStyle: TextStyle(
                                fontSize: 22,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          //Nav Drawer Email
                          Text(
                            user.email,
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
                      style: GoogleFonts.lato(
                        textStyle: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    onTap: () async {
                      await _firebaseAuth.signOut();
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => Wrapper()),
                        (Route route) => false,
                      );
                      // await _firebaseAuth.signOut();
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
