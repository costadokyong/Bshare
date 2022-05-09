// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:bshare/Screens/Settings/ProfileEdit.dart';

class MyProfileSettings extends StatelessWidget {
  const MyProfileSettings({Key? key}) : super(key: key);

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
              'Profile',
              style: TextStyle(color: Colors.black),
            ),
          ),
          body: MyProfileScreen(),
        ),
      ),
    );
  }
}

class MyProfileScreen extends StatefulWidget {
  MyProfileScreen({Key? key}) : super(key: key);

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  String username = 'Username';
  String email = "username@email.com";
  String phoneNumber = '000-0000-000';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(top: 50.0),
          child: Column(
            children: [
              CircleAvatar(
                //this is the placeholder for the user image
                backgroundImage: NetworkImage(
                    'https://cdn.pixabay.com/photo/2016/08/08/09/17/avatar-1577909_960_720.png'),
                radius: 100,
              ),
              SizedBox(
                height: 25.0,
              ),
              Text(
                username,
                style: TextStyle(fontSize: 25.0),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 30.0,
        ),
        Text(
          email,
          style: TextStyle(fontSize: 20.0),
        ),
        SizedBox(
          height: 30.0,
        ),
        Text(
          phoneNumber,
          style: TextStyle(fontSize: 20.0),
        ),
        SizedBox(
          height: 30.0,
        ),
        TextButton(
          onPressed: () {
            //Navigates to the Profile edit Screen
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProfileEdit(),
              ),
            );
          },
          child: Container(
            height: 45.0,
            margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 30.0),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.all(Radius.circular(4.0))),
            child: Center(
              child: Text("Profile Settings",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.w400),
                  textAlign: TextAlign.center),
            ),
          ),
        ),
      ],
    );
  }
}
