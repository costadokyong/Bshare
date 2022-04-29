import 'dart:developer';

import 'package:bshare/Screens/SignUp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'Screens/SignIn.dart';

final database = FirebaseDatabase(
        databaseURL:
            "https://bshare-a25c4-default-rtdb.asia-southeast1.firebasedatabase.app/")
    .ref();
final userTable = database.child('UsersInfo/');
final FirebaseAuth _auth = FirebaseAuth.instance;

Future<int> register(
    String username, String email, String password, String major) async {
  //String text
  try {
    await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    await userTable
        .child(username)
        .set({'password': password, 'major': major, 'email': email});
    return 1;
  } on FirebaseAuthException catch (singUpError) {
    if (singUpError.code.contains('email-already-in-use')) {
      return 2;
    }
  }
  return 1;
}

Future<bool> checkifEmailInUse(String emailAddres) async {
  try {
    final list = await _auth.fetchSignInMethodsForEmail(emailAddres);

    if (list.isEmpty) {
      return true;
    } else {
      return false;
    }
  } catch (e) {
    print('you got an error $e');
    return false;
  }
}

Future<User?> logIn(String email, String password) async {
  FirebaseAuth _auth = FirebaseAuth.instance;

  try {
    User? user = (await _auth.signInWithEmailAndPassword(
            email: email, password: password))
        .user;

    if (user != null) {
      print("login sucessful");
      return user;
    } else {
      print("Login failed");
      return user;
    }
  } catch (e) {
    print(e);
    return null;
  }
}

Future logOut() async {
  FirebaseAuth _auth = FirebaseAuth.instance;

  try {
    await _auth.signOut();
  } catch (e) {
    print("error");
    print(e);
  }
}
