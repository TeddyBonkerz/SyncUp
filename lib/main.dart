import 'package:flutter/material.dart';
import 'screens/login.dart';
import 'screens/signup.dart';
import 'screens/homepage.dart';

void main() {
  runApp(MyApp());
}

//test
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{
        '/signup': (BuildContext context) => new SignUpScreen(),
        '/homepage': (BuildContext context) => new HomepageScreen()
      },
      home: LoginScreen(),
    );
  }
}


