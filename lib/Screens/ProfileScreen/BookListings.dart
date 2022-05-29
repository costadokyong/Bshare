// ignore_for_file: prefer_const_constructors, unused_field, non_constant_identifier_names
// import 'dart:html';
// import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:bshare/DataBase.dart';

class UserList extends StatefulWidget {
  UserList({Key? key}) : super(key: key);
  // ignore: deprecated_member_use

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  // ignore: deprecated_member_use
  final _database = FirebaseDatabase(
          databaseURL:
              "https://bshare-a25c4-default-rtdb.asia-southeast1.firebasedatabase.app/")
      .ref();
  //final FirebaseAuth _auth = FirebaseAuth.instance;
  final userID = FirebaseAuth.instance.currentUser!.uid;
  String username = '';

  //final myName = _database.child('UsersInfo').child(userID).

  // @override
  // void initState() {
  //   super.initState();
  //   //getBookList();
  // }

  String title = 'This is where the user list goes.';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: FirebaseAnimatedList(
            query:
                _database.child('UsersInfo/$userID').orderByChild('username'),
            itemBuilder: (BuildContext context, DataSnapshot snapshot,
                Animation<double> animation, int index) {
              return Card(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Text(
                            'Name',
                            style: TextStyle(fontSize: 18.0),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Text(
                            (snapshot.value! as dynamic)['username'].toString(),
                            style: TextStyle(fontSize: 18.0),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Text(
                            'email',
                            style: TextStyle(fontSize: 18.0),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Text(
                            (snapshot.value! as dynamic)['email'].toString(),
                            style: TextStyle(fontSize: 18.0),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              );
            }),
      ),
    );
    //stream: _database.child("UsersInfo").child(userID).onValue,
  }
}






// SafeArea(
//       child: Scaffold(
//         appBar: AppBar(
//           leading: IconButton(
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               icon: const Icon(Icons.arrow_back)),
//           title: const Text(
//             'My List',
//             style: TextStyle(fontSize: 18.0, color: Colors.white),
//           ),
//         ),
//         body: Column(
//           children: [
//             ListView.builder(
//               itemCount: 5,
//               itemBuilder: (context, index) {
//                 // ignore: prefer_const_constructors
//                 return ListTile(
//                   leading: Icon(Icons.list),
//                   trailing: Text('Sold'),
//                   title: Text('Book$index'),
//                 );
//               },
//             ),

//             SizedBox(
//               height: 25.0,
//             ),

//             // Container(
//             //   child: UserList(),
//             // )
//           ],
//         ),
//       ),
//     );