// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:bshare/DataBase.dart';
import 'package:bshare/Screens/StartPage.dart';
import 'package:bshare/main.dart';
import 'package:bshare/routes/router.gr.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:bshare/Screens/BottomBar.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  BtmBar btmBar = BtmBar();

  Future<bool> _onWillpop() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Are you sure? '),
            content: Text('Do you want to exit an App'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('No'),
              ),
              TextButton(
                onPressed: () {
                  context.navigateTo(FirstPageRoute());
                },
                child: Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillpop,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('Bshare'),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(FontAwesomeIcons.magnifyingGlass),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(FontAwesomeIcons.bars),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(FontAwesomeIcons.bell),
            )
          ],
        ),
        body: HomeScreen(),
        bottomNavigationBar: btmBar,
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          backgroundColor: Colors.blue[200],
          child: Icon(
            FontAwesomeIcons.plus,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MaterialButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) =>
                      CustomDialog(title: "Did you want to Sign-Out.."),
                );
              },
              color: Colors.deepPurple[300],
              child: Text("Sign-Out"),
            )
          ],
        ),
      ),
    );
  }
}

// DialogAuth
// make new widget for new alert dialog
class CustomDialog extends StatelessWidget {
  final String title;
  const CustomDialog({
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  dialogContent(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(top: 30, bottom: 10, left: 10, right: 10),
          margin: EdgeInsets.only(top: 10),
          decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(17),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10.0,
                  offset: Offset(0.0, 0.1),
                )
              ]),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                  fontSize: 19.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 5.0),
              SizedBox(height: 5.0),
              Align(
                alignment: Alignment.bottomRight,
                child: FlatButton(
                  onPressed: () {
                    //Navigator.of(context).pop();
                    //context.router.push(FirstPageRoute());
                    SignOut();
                    context.router.push(SignInRoute());
                  },
                  child: Text("Okay"),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
