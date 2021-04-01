import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:syncup/models/userModel.dart';
import 'package:syncup/screens/authenticate.dart';
import 'package:syncup/screens/wrapper.dart';
import 'package:syncup/services/authenticationservice.dart';
import 'screens/home.dart';
import 'screens/login.dart';
import 'screens/splash.dart';
import 'screens/signup.dart';
import 'screens/user_profile.dart';
import 'screens/about.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    return StreamProvider.value(
      value: AuthService().user,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'SyncUp',
        theme: ThemeData(
          primaryColor: Colors.blueAccent,
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        routes: <String, WidgetBuilder>{
          '/wrapper': (BuildContext context) => new Wrapper(),
          '/home': (BuildContext context) => new HomeScreen(),
          '/signup': (BuildContext context) => new SignUpScreen(),
          '/user_profile': (BuildContext context) => new ProfileScreen(),
          '/about': (BuildContext context) => new AboutScreen()
        },
        home: MySplashPage(),
      ),
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
    final user = Provider.of<UserModel>(context);
    return Material(
        child: Stack(children: <Widget>[
      Scaffold(body: Wrapper()),
      IgnorePointer(
          child: SplashScreen(
              //primaryColor: Theme.of(context).accentColor
              ))
    ]));
  }
}
