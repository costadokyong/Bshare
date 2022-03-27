// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
  }) : super(key: key); //required this.title

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  //final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Widget myContainer({required String title, required String hintText}) {
    return Container(
      alignment: Alignment.topLeft,
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.start,
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
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
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
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
