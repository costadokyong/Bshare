import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:bshare/Screens/IconNavigationScreens/BookData.dart';

// ignore: deprecated_member_use
final database = FirebaseDatabase(
        databaseURL:
            "https://bshare-a25c4-default-rtdb.asia-southeast1.firebasedatabase.app/")
    .ref();
final storage = FirebaseStorage.instance;
final FirebaseAuth _auth = FirebaseAuth.instance;

final userTable = database.child('UsersInfo/');
final bookTable = database.child('Books/');

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
    });

    await bookTable.child(bookId).set({
      'bookTitle': bookTitle,
      'bookMajor': bookMajor,
      'bookDescription': bookDesc,
      'bookPrice': price,
      'bookImageUrl': bookImageUrl,
      'bookOwnerId': _auth.currentUser!.uid,
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








// class Database {
//   // ignore: body_might_complete_normally_nullable
//   Future<List?> getBookData() async {
//     List dataList = [];
//     // DatabaseReference referenceData =
//     //     // ignore: deprecated_member_use
//     //     FirebaseDatabase().instance.ref().child("Books");

//     // ignore: deprecated_member_use

//     // ignore: avoid_single_cascade_in_expression_statements
//     try {
//       await database.once().then(
//         (event) {
//           Map<dynamic, dynamic> map =
//               event.snapshot.value as Map<dynamic, dynamic>;
//           dataList.clear();

//           map.forEach(
//             (key, value) {
//               var values = Map<dynamic, dynamic>.from(map);
//               BookData data = BookData(
//                 values['bookImageUrl'],
//                 values['bookTitle'],
//                 values['bookPrice'],
//                 values['bookDescription'],
//               );
//               dataList.add(data);
//             },
//           );
//           // setState(() {
//           //   print(dataList.length);
//           // });
//         },
//       );

//       return dataList;
//     } catch (e) {
//       // ignore: avoid_print
//       print(e.toString());
//     }

//     // referenceData.once().then((event) {
//     //   final dataSnapshot = event.snapshot;
//     //   // dataList.clear();
//     //   var keys = dataSnapshot.value!.getKey();
//     //   var values = dataSnapshot.value;
//     //   for (var key in keys) {
//     //     BookData data = BookData(
//     //       values[key]["imageUrl"],
//     //       values[key]["bookTitle"],
//     //       values[key]["price"],
//     //       values[key]["description"],
//     //     );
//     //     dataList.add(data);
//     //   }
//     //   setState(() {
//     //     //
//     //   });

//     //   (dataSnapshot as Map<dynamic, dynamic>).forEach((key, value) {
//     //     BookData data = BookData(
//     //       values![key]["bookImageUrl"],
//     //       values[key]["bookTitle"],
//     //       values[key]["bookPrice"],
//     //       values[key]["bookDescription"],
//     //     );
//     //     dataList.add(data);
//     //   });
//     // });
//   }
// }
