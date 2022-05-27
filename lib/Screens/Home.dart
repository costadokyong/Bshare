// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

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
  //BtmBar btmBar = BtmBar();

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
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.house),
            label: 'Home',
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.comments),
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
        onTap: onItemTapped,
      ),
    );
  }
}
