import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/home.dart';
import 'screens/login.dart';
import 'screens/splash.dart';
import 'screens/signup.dart';
import 'screens/user_profile.dart';
import 'screens/about.dart';



void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SyncUp',
      theme: ThemeData(
        primaryColor: Colors.blueAccent,
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: <String, WidgetBuilder>{
        '/home': (BuildContext context) => new HomeScreen(),
        '/signup': (BuildContext context) => new SignUpScreen(),
        '/user_profile': (BuildContext context) => new ProfileScreen(),
        '/about': (BuildContext context) => new AboutScreen()
      },
      home: MySplashPage(),
    );
  }
}

class MySplashPage extends StatefulWidget {
  @override
  _MySplashState createState() => _MySplashState();
}

class _MySplashState extends State<MySplashPage> {
  @override
  Widget build(BuildContext context) {
    return Material(
        child: Stack(children: <Widget>[
      Scaffold(body: LoginScreen()),
      IgnorePointer(
          child: SplashScreen(
              //primaryColor: Theme.of(context).accentColor
              ))
    ]));
  }
}


