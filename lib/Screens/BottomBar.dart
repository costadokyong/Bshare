import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BtmBar extends StatefulWidget {
  //BtmBar({Key? key}) : super(key: key);

  @override
  State<BtmBar> createState() => _BtmBarState();
}

class _BtmBarState extends State<BtmBar> {
  int selectedIndex = 0;

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
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
    );
  }
}
