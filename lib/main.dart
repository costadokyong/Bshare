// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_local_variable

import 'package:bshare/Screens/SignUp.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
//import 'package:bshare/signUp.dart';
import 'package:bshare/Screens/StartPage.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized(); //do not remove this line
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _fpApp =
      Firebase.initializeApp(); //do not remove this line

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //title: 'Bshare',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FutureBuilder(
        future: _fpApp,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print('You have an error! ${snapshot.error.toString()}');
            return Text('Something went wrong');
          } else if (snapshot.hasData) {

            
            return FirstPage();

          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },

      ),
      

      ), // do note remove FutureBuilder
    );
  }
}


