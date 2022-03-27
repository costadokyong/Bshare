// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
  }) : super(key: key); //required this.title

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Widget myContainer({required String title, required String hintText}) {
    return Container(
      alignment: Alignment.topLeft,
      child: Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              title,
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.grey,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
            child: TextField(
              style: TextStyle(height: 0.5, fontSize: 14.0),
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: hintText,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = ElevatedButton.styleFrom(
      textStyle: TextStyle(fontSize: 18.0, color: Colors.white),
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 20.0, horizontal: 8.0),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  'SignUp',
                  style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            myContainer(title: '  Username', hintText: 'Enter Username'),
            SizedBox(
              height: 5.0,
            ),
            myContainer(title: '  Password', hintText: 'Enter Password'),
            SizedBox(
              height: 5.0,
            ),
            myContainer(title: '  University', hintText: 'Enter University'),
            SizedBox(
              height: 5.0,
            ),
            myContainer(title: '  Major', hintText: 'Enter Major'),
            SizedBox(
              height: 18.0,
            ),
            SizedBox(
              width: 150.0,
              height: 45.0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  style: style,
                  onPressed: () {},
                  child: Text('Sign Up'),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
