import 'package:flutter/material.dart';

import 'constants.dart';
import 'screens/home.dart';
import 'screens/login.dart';
import 'screens/signup.dart';

import 'screens/user_profile.dart';

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
        '/home': (BuildContext context) => new HomeScreen(),
        '/signup': (BuildContext context) => new SignUpScreen(),
        '/user_profile': (BuildContext context) => new ProfileScreen()
      },
      home: LoginScreen(),
    );
  }
}
