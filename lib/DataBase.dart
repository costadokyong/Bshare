import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

final database = FirebaseDatabase(
        databaseURL:
            "https://bshare-a25c4-default-rtdb.asia-southeast1.firebasedatabase.app/")
    .ref();
final userTable = database.child('UsersInfo/');

Future<User?> register(String username, String email, String password,
    String university, String major) async {
  FirebaseAuth _auth = FirebaseAuth.instance;
  //String text
  try {
    await userTable.child(username).set({
      'password': password,
      'University': university,
      'major': major,
      'email': email
    });
    User? user = (await _auth.createUserWithEmailAndPassword(
            email: email, password: password))
        .user;

    if (user != null) {
      log('users info added successfull');
      return user;
    } else {
      print("account createion failed");
      return user;
    }
  } catch (e) {
    log('you got an error $e');
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

Future SignOut() async {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  await _auth.signOut();
}
