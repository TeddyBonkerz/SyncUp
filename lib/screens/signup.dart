import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        //SyncUp Container
        Container(
            child: Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(15.0, 110.0, 0.0, 0.0),
              child: Text('Sync',
                  style:
                      TextStyle(fontSize: 80.0, fontWeight: FontWeight.bold)),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(193.0, 110.0, 0.0, 0.0),
              child: Text('Up',
                  style: TextStyle(
                      fontSize: 80.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[900])),
            )
          ],
        )),
        Container(
            padding: EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
            child: Column(
              children: <Widget>[
                //First Name Field
                TextField(
                  decoration: InputDecoration(
                      labelText: 'FIRST NAME',
                      labelStyle: TextStyle(
                          //fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat',
                          color: Colors.grey),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue[900]))),
                ),
                SizedBox(height: 20.0),
                //Last Name Field
                TextField(
                  decoration: InputDecoration(
                      labelText: 'LAST NAME',
                      labelStyle: TextStyle(
                          //fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat',
                          color: Colors.grey),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue[900]))),
                ),
                SizedBox(height: 20.0),
                //Email Field
                TextField(
                  decoration: InputDecoration(
                      labelText: 'EMAIL',
                      labelStyle: TextStyle(
                          //fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat',
                          color: Colors.grey),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue[900]))),
                ),
                SizedBox(height: 20.0),
                //Password Field
                TextField(
                  decoration: InputDecoration(
                      labelText: 'PASSWORD',
                      labelStyle: TextStyle(
                          //fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat',
                          color: Colors.grey),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue[900]))),
                  obscureText: true,
                ),
                SizedBox(height: 20.0),
                //Sign Up Button
                Container(
                    height: 40.0,
                    child: Material(
                      borderRadius: BorderRadius.circular(20.0),
                      shadowColor: Colors.blueAccent[900],
                      color: Colors.blue[900],
                      elevation: 7.0,
                      child: GestureDetector(
                          onTap: () {},
                          child: Center(
                            child: Text('Sign Up',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Montserrat')),
                          )),
                    )),
                SizedBox(height: 25.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Already a member?',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 5.0),
                    InkWell(
                      onTap: () {
                        //link login page to login button
                        Navigator.of(context).pop('/login');
                      },
                      child: Text(
                        'Login',
                        style: TextStyle(
                            color: Colors.blue[900],
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Montserrat',
                            decoration: TextDecoration.underline),
                      ),
                    )
                  ],
                )
              ],
            ))
      ],
    ));
  }
}

