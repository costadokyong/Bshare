import 'package:bshare/Screens/Home.dart';
import 'package:bshare/Screens/StartPage.dart';
//import 'package:bshare/routes/router.gr.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//import 'package:bshare/routes/router.gr.dart';

class Authenticate extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Authenticate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (_auth.currentUser != null) {
      return Home();
    } else {
      return const FirstPage();
    }
  }
}
