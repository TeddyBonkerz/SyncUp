import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncup/services/authenticationservice.dart';
import '../constants.dart';

class LoginScreen extends StatefulWidget {
  final Function toggleView;
  LoginScreen({this.toggleView});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthService _firebaseAuth = AuthService();
  final _emailText = TextEditingController();
  final _passwordText = TextEditingController();
  bool _validateEmail = true;
  bool _validatePassword = true;
  bool loading = false;

  String error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Column(
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
                    padding: EdgeInsets.fromLTRB(206.0, 110.0, 0.0, 0.0),
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
                    controller: _emailText,
                    decoration: InputDecoration(
                      errorText:
                          _validateEmail ? null : 'This is not a valid email',
                      icon: Icon(
                        Icons.email,
                        color: primaryLightColor,
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
                    controller: _passwordText,
                    decoration: InputDecoration(
                      errorText: _validatePassword
                          ? null
                          : 'Password must be greater than 6 characters',
                      icon: Icon(
                        Icons.lock,
                        color: primaryLightColor,
                      ),
                      suffixIcon: Icon(
                        Icons.visibility,
                        color: primaryLightColor,
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
                        onTap: () async {
                          setState(() {
                            bool emailTextValid = RegExp(
                                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(_emailText.text);
                            // bool emailTextValid = _emailText.text.isNotEmpty;
                            bool passwordTextValid =
                                _passwordText.text.length > 6;
                            if (emailTextValid && passwordTextValid) {
                              _validateEmail = true;
                              _validatePassword = true;
                            } else {
                              if (!emailTextValid) {
                                _validateEmail = false;
                              }
                              if (!passwordTextValid) {
                                _validatePassword = false;
                              }
                            }
                          });

                          if (_validateEmail &&
                              _validatePassword &&
                              _emailText.text.isNotEmpty &&
                              _passwordText.text.isNotEmpty) {
                            setState(() => loading = true);
                            dynamic result =
                                await _firebaseAuth.signInWithEmailAndPassword(
                                    _emailText.text, _passwordText.text);
                            if (result == null) {
                              setState(() {
                                loading = false;
                                error =
                                    'Could not sign in with those credentials';
                              });
                            }
                          }

                          // Navigator.pushAndRemoveUntil(
                          //   context,
                          //   MaterialPageRoute(
                          //       builder: (context) => HomeScreen()),
                          //   (Route<dynamic> route) => false,
                          // );
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
                  Text(
                    error,
                    style: TextStyle(color: Colors.red, fontSize: 14.0),
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
                          widget.toggleView();
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
      ),
    );
  }
}
