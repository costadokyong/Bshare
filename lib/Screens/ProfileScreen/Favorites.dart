// ignore_for_file: non_constant_identifier_names, avoid_types_as_parameter_names

import 'package:bshare/Screens/ProfileScreen/MyProfileSettings.dart';
import 'package:flutter/material.dart';
import 'package:bshare/DataBase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:bshare/DataBase.dart';
import 'package:bshare/Screens/IconNavigationScreens/BookData.dart';
import 'package:bshare/Screens/IconNavigationScreens/HomeScreen.dart';

import '../IconNavigationScreens/BookDetails.dart';
import 'BookListings.dart';

class Favorites extends StatefulWidget {
  const Favorites({Key? key}) : super(key: key);

  @override
  State<Favorites> createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  bool is_pressed = true;
  GetAuth auth = GetAuth();
  List<BookData> favoriteList = <BookData>[];
  Icon favoriteIcon = const Icon(Icons.favorite, color: Colors.red);

  Icon plainFavoriteIcon = const Icon(Icons.favorite_border);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
              color: Colors.white,
            ),
            title: const Text(
              'Favorites',
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.black,
              ),
            ),
          ),
          body: StreamBuilder(
            stream: database
                .child('favorites')
                .child(auth.authVal.currentUser!.uid)
                .child('bookID')
                .onValue,
            builder: (context, snapshot) {
              final bookList = <Widget>[];
              final favoriteBooks = <Widget>[];
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
                  const Center(
                    child: Text(
                      'No data available',
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.w600),
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
          //MyFavorites()
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
                    padding: const EdgeInsets.all(8.0),
                    decoration: const BoxDecoration(
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
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16.0),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            bookMajor,
                            style: const TextStyle(fontSize: 14.0),
                          ),
                          const SizedBox(
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
              flex: 2,
              child: IconButton(
                iconSize: 50.0,
                onPressed: () {
                  database
                      .child('favorites')
                      .child(auth.authVal.currentUser!.uid)
                      .child(bookId)
                      .remove();
                  // Navigator.pop(context);
                  setState(() {
                    is_pressed = !is_pressed;
                  });
                },
                icon: is_pressed ? favoriteIcon : plainFavoriteIcon,
                // child: ElevatedButton(
                //   onPressed: () {
                //     setState(() {});
                //   },
                //   style: ElevatedButton.styleFrom(
                //     primary: Colors.teal[100],
                //   ),
                //   child: const Text(
                //     'Sold',
                //     style: TextStyle(fontSize: 15.0, color: Colors.black),
                //   ),
                // ),
              ),
            )
          ],
        ),
      ),
    );
  }
}


// class MyFavorites extends StatefulWidget {
//   MyFavorites({Key? key}) : super(key: key);

//   @override
//   State<MyFavorites> createState() => _MyFavoritesState();
// }

// class _MyFavoritesState extends State<MyFavorites> {
//   GetAuth auth = GetAuth();
//   @override
//   Widget build(BuildContext context) {
    
//   }
// }
