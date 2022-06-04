// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:bshare/DataBase.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:bshare/Screens/IconNavigationScreens/HomeScreen.dart';
import 'package:bshare/Screens/IconNavigationScreens/ProfileScreen.dart';
import 'package:bshare/Screens/IconNavigationScreens/SearchScreen.dart';
import 'package:bshare/Screens/IconNavigationScreens/ChatScreen.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //BtmBar btmBar = BtmBar()
  final _referenceData = FirebaseDatabase(
          databaseURL:
              "https://bshare-a25c4-default-rtdb.asia-southeast1.firebasedatabase.app/")
      .ref();

  bool hasNotifications = false;

  int selectedIndex = 0;

  final List<Widget> _children = [
    HomeScreen(
      key: PageStorageKey('HomeScreen'),
    ),
    MsgScreen(
      key: PageStorageKey('MsgScreen'),
    ),
    SearchPage(
      key: PageStorageKey('SearchPage'),
    ),
    Profile(
      key: PageStorageKey('Profile'),
    ),
  ];

  final PageStorageBucket bucket = PageStorageBucket();
  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  int count = 1;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _notifyListener();
  }

  void _notifyListener() {
    print('codigo sendo executado');
    notifications
        .child('${getUserId()}/hasNotifications')
        .onValue
        .listen((event) {
      final notification = event.snapshot.value;
      notification.toString;
      print(notification);
      setState(() {
        hasNotifications = notification as bool;
        print('notificando $notification');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(
        bucket: bucket,
        child: _children[selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.blue,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.house),
            label: 'Home',
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Stack(
                alignment: Alignment.center,
                clipBehavior: Clip.none,
                children: <Widget>[
                  Icon(FontAwesomeIcons.message),
                  if (hasNotifications)
                    Positioned(
                      right: -0.5,
                      top: 0.0,
                      child: Container(
                        padding: EdgeInsets.all(1),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        constraints: BoxConstraints(
                          minWidth: 15,
                          minHeight: 12,
                        ),
                      ),
                    )
                ]),
            label: 'Chats',
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.magnifyingGlass),
            label: 'Search',
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.user),
            label: 'profile',
            backgroundColor: Colors.blue,
          ),
        ],
        currentIndex: selectedIndex,
        selectedItemColor: Colors.white,
        onTap: (value) {
          onItemTapped(value);
          if (value == 1) {
            notified();
            print(hasNotifications);
          }
        },
      ),
    );
  }
}
