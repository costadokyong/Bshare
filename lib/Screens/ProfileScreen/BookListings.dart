// ignore_for_file: prefer_const_constructors, unused_field, non_constant_identifier_names, unused_element
// import 'dart:html';
// import 'dart:ui';

import 'package:bshare/DataBase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:bshare/DataBase.dart';
import 'package:bshare/Screens/IconNavigationScreens/BookData.dart';
import 'package:bshare/Screens/IconNavigationScreens/HomeScreen.dart';

import '../IconNavigationScreens/BookDetails.dart';

class UserList extends StatefulWidget {
  UserList({Key? key}) : super(key: key);
  // ignore: deprecated_member_use

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  GetAuth authentif = GetAuth();
  // ignore: deprecated_member_use
  final _database = FirebaseDatabase(
          databaseURL:
              "https://bshare-a25c4-default-rtdb.asia-southeast1.firebasedatabase.app/")
      .ref();
  //final FirebaseAuth _auth = FirebaseAuth.instance;
  // final userID = FirebaseAuth.instance.currentUser!.uid;
  // String username = '';

  //final myName = _database.child('UsersInfo').child(userID).

  @override
  void initState() {
    super.initState();
    //getBookList();
  }

  //String title = 'This is where the user list goes.';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            'My Books',
            style: TextStyle(fontSize: 18.0, color: Colors.black),
          ),
        ),
        body: StreamBuilder(
          stream: userTable
              .child(authentif.authVal.currentUser!.uid)
              .child('userBooks')
              .onValue,
          builder: (context, snapshot) {
            final bookList = <Widget>[];
            try {
              if (snapshot.hasData) {
                //CircularProgressIndicator();
                final myBooks = Map<String, dynamic>.from(
                    (snapshot.data as dynamic).snapshot.value);
                bookList.addAll(
                  myBooks.values.map((value) {
                    final mybookData =
                        BookData.fromRTDB(Map<String, dynamic>.from(value));

                    return userListUI(
                        mybookData.bookImageUrl,
                        mybookData.bookTitle,
                        mybookData.bookPrice,
                        mybookData.bookDescription,
                        mybookData.bookMajor,
                        mybookData.bookOwnerId,
                        mybookData.bookId,
                        context);
                  }).toList(),
                );
              } else {
                Center(
                  child: Text(
                    'No data available',
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
                  ),
                );
              }
              // ignore: avoid_print
            } catch (e) {
              print(e.toString());
            }

            return SafeArea(
              child: Column(
                children: [
                  Expanded(
                    flex: 3,
                    child: ListView(
                      children: bookList,
                    ),
                  ),
                ],
              ),
            );
          },
        ),

        //   body:
        //       Padding(padding: EdgeInsets.only(top: 10.0), child: UserBookList()),
      ),
    );
    //stream: _database.child("UsersInfo").child(userID).onValue,
  }

  Widget userListUI(
      String bookImageUrl,
      String bookTitle,
      int bookPrice,
      String bookDescription,
      String bookMajor,
      String bookOwnerId,
      String bookId,
      BuildContext context) {
    return InkWell(
      onTap: () async {
        var booksInfo = [];
        String bookOwnerMajor = '';
        String bookOwnerUserName = '';
        bookOwnerMajor = await getUserDataByPath(bookOwnerId, 'major');
        bookOwnerUserName = await getUserDataByPath(bookOwnerId, 'username');
        booksInfo.addAll([
          bookImageUrl,
          bookTitle,
          bookPrice,
          bookDescription,
          bookMajor,
          bookOwnerMajor,
          bookOwnerUserName,
          bookId
        ]);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => BookDetails(
                      booksInfo: booksInfo,
                    )));
      },
      child: Card(
        child: Row(
          children: [
            Expanded(
              flex: 4,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // ignore: avoid_unnecessary_containers
                  Container(
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.white10,
                      borderRadius: BorderRadius.all(
                        Radius.circular(3.0),
                      ),
                    ),
                    child: Image(
                      image: NetworkImage(bookImageUrl),
                      fit: BoxFit.fitWidth,
                      height: 120.0,
                      width: 100.0,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text(
                            bookTitle,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16.0),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            bookMajor,
                            style: TextStyle(fontSize: 14.0),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            "Price: " + bookPrice.toString() + '₩',
                            style: TextStyle(fontSize: 14.0),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: ElevatedButton(
                onPressed: () {
                  setState(() {});
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.teal[100],
                ),
                child: Text(
                  'Sold',
                  style: const TextStyle(fontSize: 15.0, color: Colors.black),
                ),
              ),
            )
          ],
        ),
      ),
    );
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



// FirebaseAnimatedList(
//             query:
//                 _database.child('UsersInfo/$userID').orderByChild('username'),
//             itemBuilder: (BuildContext context, DataSnapshot snapshot,
//                 Animation<double> animation, int index) {
//               return Card(
//                 child: Column(
//                   children: [
//                     Row(
//                       children: [
//                         Expanded(
//                           flex: 1,
//                           child: Text(
//                             'Name',
//                             style: TextStyle(fontSize: 18.0),
//                           ),
//                         ),
//                         Expanded(
//                           flex: 3,
//                           child: Text(
//                             (snapshot.value! as dynamic)['username'].toString(),
//                             style: TextStyle(fontSize: 18.0),
//                           ),
//                         ),
//                       ],
//                     ),
//                     Row(
//                       children: [
//                         Expanded(
//                           flex: 1,
//                           child: Text(
//                             'email',
//                             style: TextStyle(fontSize: 18.0),
//                           ),
//                         ),
//                         Expanded(
//                           flex: 3,
//                           child: Text(
//                             (snapshot.value! as dynamic)['email'].toString(),
//                             style: TextStyle(fontSize: 18.0),
//                           ),
//                         ),
//                       ],
//                     )
//                   ],
//                 ),
//               );
//             })