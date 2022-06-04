// ignore_for_file: prefer_const_constructors, unused_field, non_constant_identifier_names, unused_element, void_checks
// import 'dart:html';
// import 'dart:ui';

import 'package:bshare/DataBase.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:bshare/Screens/IconNavigationScreens/BookData.dart';

class UserList extends StatefulWidget {
  UserList({Key? key}) : super(key: key);
  // ignore: deprecated_member_use

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  int flagIndex = 0;
  GetAuth authentif = GetAuth();
  // ignore: deprecated_member_use
  final _database = FirebaseDatabase(
          databaseURL:
              "https://bshare-a25c4-default-rtdb.asia-southeast1.firebasedatabase.app/")
      .ref();

  BookData bookData = BookData(
      bookImageUrl: '',
      bookTitle: '',
      bookPrice: 0,
      bookDescription: '',
      bookMajor: '',
      bookOwnerId: '',
      bookId: '',
      isBookSold: false);

  List<BookData> allBooks = <BookData>[];

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
            List<Widget> bookList = <Widget>[];
            List<BookData> listingBooks = <BookData>[];
            try {
              if (snapshot.hasData) {
                //CircularProgressIndicator();
                final myBooks = Map<String, dynamic>.from(
                    (snapshot.data as dynamic).snapshot.value);

                allBooks = myBooks.values.map<BookData>((value) {
                  bookData =
                      BookData.fromRTDB(Map<String, dynamic>.from(value));
                  allBooks.add(bookData);

                  return bookData;
                }).toList();

                listingBooks = allBooks;

                bookList = listingBooks.map<Widget>((book) {
                  return userListUI(
                      book.bookImageUrl,
                      book.bookTitle,
                      book.bookPrice,
                      book.bookDescription,
                      book.bookMajor,
                      book.bookOwnerId,
                      book.bookId,
                      book.isBookSold,
                      context);
                }).toList();
              } else {
                const Center(
                  child: Text(
                    'No data available',
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
                  ),
                );
              }
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
      ),
    );
  }

  Widget userListUI(
      String bookImageUrl,
      String bookTitle,
      int bookPrice,
      String bookDescription,
      String bookMajor,
      String bookOwnerId,
      String bookId,
      bool isBookSold,
      BuildContext context) {
    return InkWell(
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
                  onPressed: () async {
                    if (!isBookSold) {
                      database.child('Books').child(bookId).remove();
                      await sellBook(bookId);
                      _showToast();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    primary: isBookSold ? Colors.grey : Colors.green,
                  ),
                  child: isBookSold
                      ? Text('Sold',
                          style: const TextStyle(
                              fontSize: 15.0, color: Colors.black))
                      : Text('Sell',
                          style: const TextStyle(
                              fontSize: 15.0, color: Colors.black))),
            )
          ],
        ),
      ),
    );
  }

  void _showToast() {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        duration: Duration(milliseconds: 500),
        content: const Text(
          'Book Sold',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
