// ignore_for_file: prefer_const_constructors

import 'package:bshare/routes/router.gr.dart';
import 'package:flutter/material.dart';
import 'package:bshare/Screens/Settings/ProfileEdit.dart';
import 'package:bshare/DataBase.dart';

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
  const MyProfileScreen({Key? key}) : super(key: key);

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  String userEmail = '';
  String userMajor = '';
  String userName = '';

  @override
  void initState() {
    _setUp();
    super.initState();
  }

  _setUp() async {
    String FutureUserName = await getUserData('username');
    String FutureEmail = await getUserData('email');
    String FutureMajor = await getUserData('major');

    setState(() {
      userName = FutureUserName;
      userEmail = FutureEmail;
      userMajor = FutureMajor;
      print('$FutureEmail, $FutureMajor, $FutureUserName');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(top: 50.0),
          //margin: EdgeInsets.symmetric(vertical: 50.0, horizontal: 50.0),
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              // Icon(
              //   Icons.account_box_rounded,
              //   size: 150.0,
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
                'User Name: $userName',
                style: TextStyle(fontSize: 25.0),
                textAlign: TextAlign.left,
              ),
              Text(
                'Major: $userMajor',
                style: TextStyle(fontSize: 25.0),
                textAlign: TextAlign.left,
              ),
              Text(
                'Email: $userEmail',
                style: TextStyle(fontSize: 25.0),
                textAlign: TextAlign.left,
              ),
            ],
          ),
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
                //color: Colors.green,
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
