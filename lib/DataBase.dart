import 'dart:developer';

import 'package:bshare/Screens/SignIn.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// ignore: deprecated_member_use
final database = FirebaseDatabase(
        databaseURL:
            "https://bshare-a25c4-default-rtdb.asia-southeast1.firebasedatabase.app/")
    .ref();
final userTable = database.child('UsersInfo/');

Future<User?> register(String username, String email, String password,
    String university, String major) async {
  FirebaseAuth _auth = FirebaseAuth.instance;

  try {
    await userTable.child(username).set({
      'password': password,
      'University': university,
      'major': major,
    });
    log('users info added successfull');
  } catch (e) {
    log('you got an error $e');
  }

  try {
    User? user = (await _auth.createUserWithEmailAndPassword(
            email: email, password: password))
        .user;

    if (user != null) {
      log("Account Created Sucessful");
      return user;
    } else {
      log("Account Created Failed");
      return user;
    }
  } catch (e) {
    if (kDebugMode) {
      print('debug: $e');
    }
    return null;
  }
}

Future<User?> logIn(String email, String password) async {
  FirebaseAuth _auth = FirebaseAuth.instance;

  try {
    User? user = (await _auth.signInWithEmailAndPassword(
            email: email, password: password))
        .user;

    if (user != null) {
      log("Login Successful");
      return user;
    } else {
      log("Login Failed");
      return user;
    }
  } catch (e) {
    if (kDebugMode) {
      print(e);
    }
    return null;
  }
}

Future logOut(BuildContext context) async {
  FirebaseAuth _auth = FirebaseAuth.instance;

  try {
    await _auth.signOut().then((value) {
      Navigator.push(
          context, MaterialPageRoute(builder: (_) => const SignIn()));
    });
  } catch (e) {
    if (kDebugMode) {
      print("Error");
    }
  }
}
