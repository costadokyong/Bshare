import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Scaffold(
  appBar: AppBar(
    title: const Text('HOME'),
  ),
  bottomNavigationBar: BottomNavigationBar(
    items: const <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: Icon(Icons.call),
        label: 'Home',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.camera),
        label: 'Chats',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.chat),
        label: 'profile',
      ),
    ],
  ),
);
  }
 