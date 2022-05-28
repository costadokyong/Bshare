// ignore_for_file: prefer_const_constructors, unnecessary_string_interpolations

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
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(top: 30.0),
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
                radius: 60,
              ),
              SizedBox(
                height: 25.0,
              ),
              // ignore: unnecessary_string_interpolations
              fieldCard('$userName', Icons.person),
              fieldCard('$userMajor', Icons.class_),
              fieldCard('$userEmail', Icons.email_rounded)
            ],
          ),
        ),
        SizedBox(
          height: 60.0,
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
            margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 50.0),
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

  Card fieldCard(String title, IconData fieldIcon) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 18.0),
      //padding: EdgeInsets.all(10.0),
      child: ListTile(
        leading: Icon(
          //Icons.verified_user,
          fieldIcon,
          color: Colors.black54,
        ),
        title: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.black,
              fontFamily: 'RobotoFlex',
              fontWeight: FontWeight.w200,
              fontSize: 20.0),
        ),
      ),
    );
  }
}
