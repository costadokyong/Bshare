// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:bshare/Screens/BottomBar.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  BtmBar btmBar = BtmBar();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(
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
    return Center(
      child: Text('Loading'),
    );
  }
}
