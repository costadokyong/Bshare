// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'package:auto_route/auto_route.dart';
import 'package:bshare/Screens/Settings/ProfileEdit.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:bshare/Screens/ProfileScreen/Settings.dart';
import 'package:bshare/Screens/ProfileScreen/MyProfileSettings.dart';
import 'package:bshare/routes/router.dart';
import 'package:bshare/routes/router.gr.dart';

void main() => runApp(
      MaterialApp(
        initialRoute: '/',
        routes: {
          //This is the Profile screen route
          '/': (context) => const Profile(),

          //Navigates to the settings screen
          '/second': (context) => const Settings(),

          //Navigates to My Profile Screen
          '/third': (context) => const MyProfileSettings(),
        },
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
                //Navigator.pushNamed(context, '/second');
                //context.router.push(Settings());
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
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          InkWell(
            onTap: () {
              //Navigator.pushNamed(context, '/third');
              context.navigateTo(MyProfileSettingsRoute());
            },
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 25.0, horizontal: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  // Icon(
                  //   Icons.account_circle,
                  //   size: 75.0,
                  // ),
                  CircleAvatar(
                    //this is the placeholder for the user image
                    backgroundImage: NetworkImage(
                        'https://cdn.pixabay.com/photo/2016/08/08/09/17/avatar-1577909_960_720.png'),
                    radius: 50,
                  ),
                  SizedBox(width: 20.0),
                  Text(
                    'username',
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
              IconsButtons('Listings', FontAwesomeIcons.listCheck,
                  Colors.pink[400]!, 45.0),
              IconsButtons('Purchases', FontAwesomeIcons.bagShopping,
                  Colors.pink[400]!, 45.0),
              IconsButtons(
                  'Favorites', FontAwesomeIcons.heart, Colors.pink[400]!, 45.0),
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
          // InkWell(
          //     onTap: () {},
          //     child: OtherOptions(
          //         FontAwesomeIcons.locationDot, 'Neighborhood Settings')),
          // InkWell(
          //   onTap: () {},
          //   child: OtherOptions(
          //       FontAwesomeIcons.locationCrosshairs, 'Verify Neighborhood'),
          // ),
          // InkWell(
          //   onTap: () {},
          //   child: OtherOptions(FontAwesomeIcons.tag, 'Search Alerts'),
          // ),
          // InkWell(
          //   onTap: () {},
          //   child: OtherOptions(
          //       FontAwesomeIcons.locationCrosshairs, 'Verify Neighborhood'),
          // ),
          // InkWell(
          //   onTap: () {},
          //   child: OtherOptions(FontAwesomeIcons.sliders, 'Customize Feed'),
          // ),
          // Divider(
          //   height: 15.0,
          //   thickness: 5.0,
          //   color: Colors.teal[200],
          // ),
          // InkWell(
          //   onTap: () {},
          //   child: OtherOptions(
          //       FontAwesomeIcons.blog, 'My Local Post and Comments'),
          // ),
          // InkWell(
          //   onTap: () {},
          //   child: OtherOptions(FontAwesomeIcons.comment, 'My Store Review'),
          // ),
          // Divider(
          //   height: 15.0,
          //   thickness: 5.0,
          //   color: Colors.teal[200],
          // ),
          InkWell(
            onTap: () {
              //Navigate to the Settings screen using a name route
              //Navigator.pushNamed(context, '/second');
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
          //FaIcon(FontAwesomeIcons.locationDot),
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
    return InkWell(
      onTap: () {},
      child: Expanded(
        child: Column(
          children: [
            FaIcon(
              //FontAwesomeIcons.listCheck
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
      ),
    );
  }
}






























// import 'package:flutter/material.dart';

// class ProfileScreeen extends StatefulWidget {
//   ProfileScreeen({Key? key}) : super(key: key);

//   @override
//   State<ProfileScreeen> createState() => _ProfileScreeenState();
// }

// class _ProfileScreeenState extends State<ProfileScreeen> {
//   @override
//   Widget build(BuildContext context) {
//     return const Center(
//       child: Text('Profile Screen'),
//     );
//   }
// }
