import 'package:flutter/material.dart';
import 'screens/homepage.dart';

import 'constants.dart';
import 'screens/login.dart';
import 'screens/signup.dart';

void main() {
  runApp(MyApp());
}

//test
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: primaryColor,
        scaffoldBackgroundColor: Colors.white,
      ),
      routes: <String, WidgetBuilder>{
        '/signup': (BuildContext context) => new SignUpScreen(),
        '/homepage': (BuildContext context) => new HomepageScreen()
      },
      home: LoginScreen(),
    );
  }
}
