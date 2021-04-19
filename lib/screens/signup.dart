import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncup/services/authenticationservice.dart';
import '../constants.dart';

class SignUpScreen extends StatefulWidget {
  final Function toggleView;
  SignUpScreen({this.toggleView});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final AuthService _firebaseAuth = AuthService();
  final _firstNameText = TextEditingController();
  final _lastNameText = TextEditingController();
  final _emailText = TextEditingController();
  final _passwordText = TextEditingController();
  bool _validateFirstName = true;
  bool _validateLastName = true;
  bool _validateEmail = true;
  bool _validatePassword = true;
  bool loading = false;
  String error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                        fontSize: 80.0, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(206.0, 110.0, 0.0, 0.0),
                  child: Text(
                    'Up',
                    style: GoogleFonts.mcLaren(
                        fontSize: 80.0,
                        fontWeight: FontWeight.bold,
                        color: primaryColor),
                  ),
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
            child: Column(
              children: <Widget>[
                //First Name Field
                TextField(
                  controller: _firstNameText,
                  decoration: InputDecoration(
                    errorText: _validateFirstName
                        ? null
                        : 'First name cannot be empty',
                    icon: Icon(
                      Icons.person,
                      color: primaryLightColor,
                    ),
                    labelText: 'FIRST NAME',
                    labelStyle: TextStyle(
                        //fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat',
                        color: Colors.grey),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: primaryColor),
                    ),
                  ),
                ),
                //Last Name Field
                TextField(
                  controller: _lastNameText,
                  decoration: InputDecoration(
                    errorText:
                        _validateLastName ? null : 'Last name cannot be empty',
                    icon: Icon(
                      Icons.person,
                      color: primaryLightColor,
                    ),
                    labelText: 'LAST NAME',
                    labelStyle: TextStyle(
                        //fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat',
                        color: Colors.grey),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: primaryColor),
                    ),
                  ),
                ),
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
                SizedBox(height: 30.0),
                //Sign Up Button
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
                          bool firstNameTextValid =
                              _firstNameText.text.isNotEmpty;
                          bool lastNameTextValid =
                              _lastNameText.text.isNotEmpty;
                          bool emailTextValid = RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(_emailText.text);
                          // bool emailTextValid = _emailText.text.isNotEmpty;
                          bool passwordTextValid =
                              _passwordText.text.length > 6;
                          if (emailTextValid &&
                              passwordTextValid &&
                              firstNameTextValid &&
                              lastNameTextValid) {
                            _validateFirstName = true;
                            _validateLastName = true;
                            _validateEmail = true;
                            _validatePassword = true;
                          } else {
                            if (!firstNameTextValid) {
                              _validateFirstName = false;
                            }

                            if (!lastNameTextValid) {
                              _validateLastName = false;
                            }

                            if (!emailTextValid) {
                              _validateEmail = false;
                            }

                            if (!passwordTextValid) {
                              _validatePassword = false;
                            }
                          }

                          // Navigator.of(context).pushNamed('/homepage');
                        });

                        if (_validateLastName &&
                            _validateFirstName &&
                            _validatePassword &&
                            _validateEmail &&
                            _lastNameText.text.isNotEmpty &&
                            _firstNameText.text.isNotEmpty &&
                            _passwordText.text.isNotEmpty &&
                            _emailText.text.isNotEmpty) {
                          setState(() => loading = true);

                          dynamic result =
                              await _firebaseAuth.registerWithEmailAndPassword(
                            _emailText.text,
                            _passwordText.text,
                            _firstNameText.text,
                            _lastNameText.text,
                          );
                          if (result == null) {
                            setState(() {
                              error = 'Please supply a valid email';
                            });
                          }
                        }
                        // Navigator.pushAndRemoveUntil(
                        //   context,
                        //   MaterialPageRoute(builder: (context) => HomeScreen()),
                        //   (Route<dynamic> route) => false,
                        // );
                      },
                      child: Center(
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Montserrat'),
                        ),
                      ),
                    ),
                  ),
                ),
                // SizedBox(height: 12.0),
                Text(
                  error,
                  style: TextStyle(color: Colors.red, fontSize: 14.0),
                ),
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
                        widget.toggleView();
                      },
                      child: Text(
                        'Login',
                        style: TextStyle(
                            color: primaryColor,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Montserrat',
                            decoration: TextDecoration.underline),
                      ),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
