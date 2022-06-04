// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'package:auto_route/auto_route.dart';
import 'package:bshare/DataBase.dart';
import 'package:bshare/Screens/ProfileScreen/Favorites.dart';
import 'package:bshare/Screens/Settings/ProfileEdit.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:bshare/Screens/ProfileScreen/Settings.dart';
import 'package:bshare/Screens/ProfileScreen/MyProfileSettings.dart';
import 'package:bshare/routes/router.dart';
import 'package:bshare/routes/router.gr.dart';
import 'package:bshare/Screens/ProfileScreen/BookListings.dart';

void main() => runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
      ),
    );

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text(
            'My Bshare',
            style: TextStyle(color: Colors.black),
          ),
          actions: [
            IconButton(
              onPressed: () {
                context.navigateTo(SettingsRoute());
              },
              icon: const FaIcon(FontAwesomeIcons.gear),
              color: Colors.black,
            ),
          ],
        ),
        body: ProfileScreen(),
      ),
    );
  }
}

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String userData = "";

  @override
  void initState() {
    _setUp();

    super.initState();
  }

  _setUp() async {
    String futureData = await getUserData('username');

    setState(() {
      userData = futureData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          InkWell(
            onTap: () {
              context.navigateTo(MyProfileSettingsRoute());
            },
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 25.0, horizontal: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  CircleAvatar(
                    //this is the placeholder for the user image
                    backgroundImage: NetworkImage(
                        'https://cdn.pixabay.com/photo/2016/08/08/09/17/avatar-1577909_960_720.png'),
                    radius: 50,
                  ),
                  SizedBox(width: 20.0),
                  Text(
                    userData,
                    style: TextStyle(fontSize: 20.0),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 25.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => UserList()),
                  );
                },
                child: IconsButtons('Listings', FontAwesomeIcons.listCheck,
                    Colors.pink[400]!, 45.0),
              ),
              InkWell(
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => UserList()),
                  // );
                },
                child: IconsButtons('Purchases', FontAwesomeIcons.bagShopping,
                    Colors.pink[400]!, 45.0),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Favorites()),
                  );
                },
                child: IconsButtons('Favorites', FontAwesomeIcons.heart,
                    Colors.pink[400]!, 45.0),
              ),
            ],
          ),
          SizedBox(
            height: 12.0,
          ),
          Divider(
            height: 15.0,
            thickness: 5.0,
            color: Colors.teal[200],
          ),
          InkWell(
            onTap: () {
              //Navigate to the Settings screen using a name route
              context.navigateTo(SettingsRoute());
            },
            child: OtherOptions(FontAwesomeIcons.gear, 'Settings'),
          ),
          InkWell(
            onTap: () {},
            child: OtherOptions(FontAwesomeIcons.circleQuestion, 'Get Help'),
          ),
        ],
      ),
    );
  }
}

class OtherOptions extends StatelessWidget {
  IconData icon;
  String text;

  OtherOptions(this.icon, this.text, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20.0, horizontal: 18.0),
      child: Row(
        children: [
          FaIcon(
            icon,
            size: 30.0,
          ),
          SizedBox(
            width: 12.0,
          ),
          Text(
            text,
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }
}

class IconsButtons extends StatelessWidget {
  String title;
  IconData icon;
  Color color;
  double height;

  IconsButtons(this.title, this.icon, this.color, this.height, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          FaIcon(
            icon,
            size: height,
            color: color,
          ),
          SizedBox(
            height: 10.0,
          ),
          Text(
            //'Listings',
            title,
            style: TextStyle(fontSize: 20.0),
          ),
        ],
      ),
    );
  }
}
