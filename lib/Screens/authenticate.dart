//import 'package:authen_login/home_screen.dart';
//import 'package:authen_login/login_screen.dart';
//import 'package:bshare/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:bshare/Screens/SignIn.dart';
import 'package:bshare/Screens/home_screen.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({Key? key}) : super(key: key);

  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    if (_auth.currentUser != null) {
      return const HomeScreen();
    } else {
      return const SignIn();
    }
  }
}
