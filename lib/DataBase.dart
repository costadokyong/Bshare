// ignore_for_file: non_constant_identifier_names, body_might_complete_normally_nullable, avoid_print, prefer_const_constructors, avoid_return_types_on_setters

import 'dart:io';

import 'package:bshare/Screens/ChatScreens/MessageModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';

// ignore: deprecated_member_use
final database = FirebaseDatabase(
        databaseURL:
            "https://bshare-a25c4-default-rtdb.asia-southeast1.firebasedatabase.app/")
    .ref();
final storage = FirebaseStorage.instance;
FirebaseAuth _auth = FirebaseAuth.instance;

class GetAuth {
  FirebaseAuth get authVal => _auth;
  //set _auth(FirebaseAuth getAuth) {}
  set authVal(FirebaseAuth authVal) {
    _auth = authVal;
  }
}

final userTable = database.child('UsersInfo/');
final bookTable = database.child('Books/');
final chatMessages = database.child('chatMessages/');
final contactList = database.child('contactList');
final notifications = database.child('notifications');

Future<int> register(
    String username, String email, String password, String major) async {
  //String text
  try {
    await _auth.createUserWithEmailAndPassword(
        email: email, password: password);

    await userTable.child(_auth.currentUser!.uid).set({
      'password': password,
      'major': major,
      'email': email,
      'username': username,
    });

    return 1;
  } on FirebaseAuthException catch (singUpError) {
    if (singUpError.code.contains('email-already-in-use')) {
      return 2;
    }
  }
  return 1;
}

String getUserId() {
  String userId = _auth.currentUser!.uid;
  return userId;
}

Future<void> uploadBook(
  String bookId,
  String bookTitle,
  String bookMajor,
  String bookDesc,
  int price,
) async {
  String userId = _auth.currentUser!.uid;
  String bookImageUrl = '';

  try {
    bookImageUrl = await storage.ref('$userId/$bookTitle').getDownloadURL();
    print(bookImageUrl);
  } catch (e) {
    print(e);
  }
  try {
    await bookTable.child(bookId).set({
      'bookTitle': bookTitle,
      'bookMajor': bookMajor,
      'bookDescription': bookDesc,
      'bookPrice': price,
      'bookImageUrl': bookImageUrl,
      'bookOwnerId': _auth.currentUser!.uid,
      'bookId': bookId,
    });
  } catch (e) {
    print('you got an error $e');
  }

  try {
    await userTable
        .child(_auth.currentUser!.uid)
        .child('userBooks')
        .child(bookId)
        .set({
      'bookTitle': bookTitle,
      'bookMajor': bookMajor,
      'bookDescription': bookDesc,
      'bookPrice': price,
      'bookImageUrl': bookImageUrl,
      'bookOwnerId': _auth.currentUser!.uid,
      'isbookSold': false,
      'bookId': bookId,
    });
  } catch (e) {
    print('you got an error $e');
  }
}

Future<void> sellBook(String bookId) async {
  try {
    await userTable
        .child(_auth.currentUser!.uid)
        .child('userBooks')
        .child(bookId)
        .update({
      'isbookSold': true,
    });
  } catch (e) {
    print('error in update book status $e');
  }
}

Future<void> uploadFavoriteBooks(
  String bookId,
  String bookTitle,
  String bookMajor,
  String bookDesc,
  int price,
  String bookImageUrl,
  String bookOwnerId,
) async {
  try {
    await database
        .child('favorites')
        .child(_auth.currentUser!.uid)
        .child(bookId)
        .set({
      'bookTitle': bookTitle,
      'bookMajor': bookMajor,
      'bookDescription': bookDesc,
      'bookPrice': price,
      'bookImageUrl': bookImageUrl,
      'bookOwnerId': _auth.currentUser!.uid,
      'bookId': bookId,
    });
  } catch (e) {
    print('you got an error $e');
  }
}

Future<void> uploadBookImage(File bookImage, String bookImageTile) async {
  String userId = _auth.currentUser!.uid;

  try {
    await storage.ref('$userId/$bookImageTile').putFile(bookImage);
  } on FirebaseException catch (e) {
    print(e);
  }
}

Future<String> getUserData(String dataKey) async {
  final User? _user = await _auth.currentUser!;
  String userId = _user!.uid;
  String dataValue;

  DataSnapshot? result = await userTable.child('$userId/$dataKey').get();
  dataValue = result.value.toString();

  return dataValue;
}

Future<String> getUserDataByPath(String userId, String dataKey) async {
  String dataValue;

  DataSnapshot? result = await userTable.child('$userId/$dataKey').get();
  dataValue = result.value.toString();

  return dataValue;
}

Future<User?> logIn(String email, String password) async {
  FirebaseAuth _auth = FirebaseAuth.instance;

  try {
    User? user = (await _auth.signInWithEmailAndPassword(
            email: email, password: password))
        .user;
    getUserData('username');

    if (user != null) {
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
  try {
    await _auth.signOut();
  } catch (e) {
    print("error");
    print(e);
  }
}

Future<void> sendMessage(String bookOwnerID, String msgText) async {
  DateTime now = DateTime.now();

  try {
    await chatMessages
        .child('${_auth.currentUser!.uid}and$bookOwnerID')
        .push()
        .set({
      'messageText': msgText,
      'messageType': 'sender',
      'time': now.microsecondsSinceEpoch
    });

    await chatMessages
        .child('${bookOwnerID}and${_auth.currentUser!.uid}')
        .push()
        .set({
      'messageText': msgText,
      'messageType': 'reciever',
      'time': now.microsecondsSinceEpoch
    });
  } catch (e) {
    print('error sending the message $e');
  }
}

Future<void> addContact(String bookOWnerID, String bookOwnerUserName) async {
  String currentUserName = await getUserData('username');
  try {
    await contactList.child(_auth.currentUser!.uid).child(bookOWnerID).set({
      'contactID': bookOWnerID,
      'contactUsername': bookOwnerUserName,
    });

    await contactList.child(bookOWnerID).child(_auth.currentUser!.uid).set({
      'contactID': _auth.currentUser!.uid,
      'contactUsername': currentUserName,
    });

    print('contact added sucsessfull');
  } catch (e) {
    print('error in adding contact $e');
  }
}

Future<void> updateLastMessage(ChatMessage message, String contactId) async {
  try {
    await contactList.child(getUserId()).child(contactId).update({
      'lastMessage': message.messageContent,
    });

    await contactList.child(contactId).child(getUserId()).update({
      'lastMessage': message.messageContent,
    });
    print('last message to be update: ${message.messageContent}');
  } catch (e) {
    print('failed to udtade las messsage $e');
  }
}

Future<void> notify(String userID) async {
  try {
    await notifications.child(userID).update({'hasNotifications': true});
  } catch (e) {
    print('error to notify $e');
  }
}

Future<void> notified() async {
  try {
    await notifications.child(getUserId()).update({'hasNotifications': false});
  } catch (e) {
    print('error to notify $e');
  }
}
