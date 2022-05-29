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
          body: Container(),
          //MyFavorites()
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
//     // return StreamBuilder(
//     //   stream: userTable
//     //       .child(auth.authVal.currentUser!.uid)
//     //       .child('favoritesBooks')
//     //       .onValue,
//     //   builder: (context, snapshot) {
//     //     final FavoriteList = <Widget>[];
//     //     try {
//     //       if (snapshot.hasData) {
//     //         //CircularProgressIndicator();
//     //         final myBooks = Map<String, dynamic>.from(
//     //             (snapshot.data as dynamic).snapshot.value);
//     //         FavoriteList.addAll(
//     //           myBooks.values.map((value) {
//     //             final mybookData =
//     //                 BookData.fromRTDB(Map<String, dynamic>.from(value));

//     //             return userListUI(
//     //                 mybookData.bookImageUrl,
//     //                 mybookData.bookTitle,
//     //                 mybookData.bookPrice,
//     //                 mybookData.bookDescription,
//     //                 mybookData.bookMajor,
//     //                 mybookData.bookOwnerId,
//     //                 context);
//     //           }),
//     //         );
//     //       } else {
//     //         const Center(
//     //           child: Text(
//     //             'No data available',
//     //             style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
//     //           ),
//     //         );
//     //       }
//     //       // ignore: avoid_print
//     //     } catch (e) {
//     //       print(e.toString());
//     //     }

//     //     return SafeArea(
//     //       child: Column(
//     //         children: [
//     //           Expanded(
//     //             flex: 3,
//     //             child: ListView(
//     //               children: FavoriteList,
//     //             ),
//     //           ),
//     //         ],
//     //       ),
//     //     );
//     //   },
//     // );
//   }
// }
