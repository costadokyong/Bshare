// ignore_for_file: prefer_const_constructors, duplicate_ignore

import 'package:bshare/Screens/SignIn.dart';
import 'package:bshare/Screens/SignUp.dart';
import 'package:bshare/Screens/StartPage.dart';
import 'package:bshare/Screens/Home.dart';
import 'package:flutter/material.dart';
import 'package:bshare/main.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => FirstPage());

      case '/SignUpPage':
        return MaterialPageRoute(builder: (_) => SingUp());

      case '/SignInPage':
        return MaterialPageRoute(builder: (_) => SignIn());

      case '/HomePage':
        // ignore: prefer_const_constructors
        return MaterialPageRoute(builder: (_) => Home());

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        body: Center(child: Text('ERROR')),
      );
    });
  }
}
