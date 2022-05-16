// ignore_for_file: unnecessary_new, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:bshare/Screens/Settings/Delete.dart';
import 'package:bshare/Screens/Settings/LogOut.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
                onPressed: () {
                  Navigator.pop(context, true);
                }),
            title: const Text(
              'Settings',
              style: TextStyle(color: Colors.black),
            ),
          ),
          body: MyProfile(),
        ),
      ),
    );
  }
}

class MyProfile extends StatefulWidget {
  MyProfile({Key? key}) : super(key: key);

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 8.0),
          alignment: Alignment.topLeft,
          child: const Text(
            'User Settings',
            style: TextStyle(fontSize: 15.0),
          ),
        ),
        InkWell(
          onTap: () {},
          child: Container(
            alignment: Alignment.topLeft,
            margin: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 8.0),
            child: const Text(
              'Manage Account',
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18.0),
            ),
          ),
        ),
        Divider(
          height: 8.0,
          thickness: 2.5,
          color: Colors.teal[200],
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 8.0),
          alignment: Alignment.topLeft,
          child: const Text(
            'Other',
            style: TextStyle(fontSize: 15.0),
          ),
        ),
        InkWell(
          onTap: () {
            //Navigates to the Log Out Screen
            Navigator.push(
              context,
              new MaterialPageRoute(
                builder: (context) => new LogOut(),
              ),
            );
          },
          child: Container(
            alignment: Alignment.topLeft,
            margin: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 8.0),
            child: const Text(
              'Log Out',
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18.0),
            ),
          ),
        ),
        InkWell(
          onTap: () {
            //Naviagtes to the Delete Account Screen
            Navigator.push(
              context,
              new MaterialPageRoute(
                builder: (context) => new Delete(),
              ),
            );
          },
          child: Container(
            alignment: Alignment.topLeft,
            margin: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 8.0),
            child: const Text(
              'Delete Account',
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18.0),
            ),
          ),
        ),
      ],
    );
  }
}
