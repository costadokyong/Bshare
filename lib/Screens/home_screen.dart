//import 'package:authen_login/method.dart';
import 'package:bshare/DataBase.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Screen"),
      ),
      body: Center(
        child: TextButton(
          onPressed: () => logOut(context),
          child: const Text("LogOut"),
        ),
      ),
    );
  }
}
