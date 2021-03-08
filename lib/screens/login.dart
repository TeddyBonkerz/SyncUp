import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants.dart';
import 'package:flutter/services.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          //SyncUp Container
          Container(
            child: Stack(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(15.0, 110.0, 0.0, 0.0),
                  child: Text(
                    'Sync',
                    style: GoogleFonts.mcLaren(
                      textStyle: TextStyle(
                          fontSize: 80.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(210.0, 110.0, 0.0, 0.0),
                  child: Text(
                    'Up',
                    style: GoogleFonts.mcLaren(
                      textStyle: TextStyle(
                          fontSize: 80.0,
                          fontWeight: FontWeight.bold,
                          color: primaryColor),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
            child: Column(
              children: <Widget>[
                //Email Field
                TextField(
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.email,
                      color: primaryColor,
                    ),
                    labelText: 'EMAIL',
                    labelStyle: TextStyle(
                        //fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat',
                        color: Colors.grey),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: primaryColor),
                    ),
                  ),
                ),

                //Password Field
                TextField(
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.lock,
                      color: primaryColor,
                    ),
                    suffixIcon: Icon(
                      Icons.visibility,
                      color: primaryColor,
                    ),
                    labelText: 'PASSWORD',
                    labelStyle: TextStyle(
                        //fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat',
                        color: Colors.grey),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: primaryColor),
                    ),
                  ),
                  obscureText: true,
                ),
                //Forgot Password Link
                Container(
                  alignment: Alignment(1.0, 0.0),
                  padding: EdgeInsets.only(top: 15.0, left: 20.0),
                  child: InkWell(
                    child: Text(
                      'Forgot Password',
                      style: GoogleFonts.mcLaren(
                        textStyle: TextStyle(
                            color: primaryColor,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 50.0),
                //Login Button
                Container(
                  height: 40.0,
                  child: Material(
                    borderRadius: BorderRadius.circular(20.0),
                    shadowColor: Colors.blueAccent[900],
                    color: primaryColor,
                    elevation: 7.0,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed('/homepage');
                      },
                      child: Center(
                        child: Text(
                          'LOGIN',
                          style: GoogleFonts.mcLaren(
                            textStyle: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 25.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'New to SyncUp?',
                      style: GoogleFonts.mcLaren(
                        textStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(width: 5.0),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pushNamed('/signup');
                      },
                      child: Text(
                        'Register',
                        style: GoogleFonts.mcLaren(
                          textStyle: TextStyle(
                              color: primaryColor,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
