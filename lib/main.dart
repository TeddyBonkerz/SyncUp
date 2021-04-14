import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:syncup/screens/splash.dart';
import 'package:syncup/screens/wrapper.dart';
import 'package:syncup/services/authenticationservice.dart';
import 'screens/about.dart';
import 'screens/home.dart';
import 'screens/signup.dart';
import 'screens/user_profile.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);
    return StreamProvider.value(
      value: AuthService().user,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'SyncUp',
        theme: ThemeData(
          primaryColor: Color(0xFF3632a8),
          primarySwatch: Colors.grey,
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
    return Material(
      child: Stack(
        children: <Widget>[
          Scaffold(body: Wrapper()),
          IgnorePointer(
            child: SplashScreen(
                //primaryColor: Theme.of(context).accentColor
                ),
          )
        ],
      ),
    );
  }
}
