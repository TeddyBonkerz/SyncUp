import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncup/models/userModel.dart';
import 'package:syncup/screens/authenticate.dart';
import 'package:syncup/screens/home.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel>(context);

    // return either the Home or Authenticate widget
    if (user == null) {
      return Authenticate();
    } else {
      return HomeScreen();
    }
  }
}
