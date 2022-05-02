// ignore_for_file: dead_code, unused_label, prefer_const_constructors_in_immutables

import 'package:bshare/Screens/Upload.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreenPage(),
    );
  }
}

class HomeScreenPage extends StatefulWidget {
  HomeScreenPage({Key? key}) : super(key: key);

  @override
  State<HomeScreenPage> createState() => _HomeScreenPageState();
}

class _HomeScreenPageState extends State<HomeScreenPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
        body: HomeScreen2(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            //still on progress

            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => const Upload(),
            //   ),
            // );
          },
          backgroundColor: Colors.deepOrange,
          child: const Icon(
            Icons.upload,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class HomeScreen2 extends StatefulWidget {
  HomeScreen2({Key? key}) : super(key: key);

  @override
  State<HomeScreen2> createState() => _HomeScreen2State();
}

class _HomeScreen2State extends State<HomeScreen2> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Home Screen'),
    );
  }
}
