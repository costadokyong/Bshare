// ignore_for_file: dead_code, unused_label, prefer_const_constructors_in_immutables, prefer_const_constructors, unused_local_variable

import 'package:auto_route/auto_route.dart';
import 'package:bshare/DataBase.dart';
import 'package:bshare/Screens/IconNavigationScreens/BookData.dart';
import 'package:bshare/Screens/IconNavigationScreens/BookDetails.dart';
import 'package:bshare/routes/router.gr.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
//import 'package:bshare/DataBase.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: HomeScreenPage(),
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Bshare',
            style: TextStyle(color: Colors.black),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                FontAwesomeIcons.magnifyingGlass,
                color: Colors.black,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                FontAwesomeIcons.bars,
                color: Colors.black,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                FontAwesomeIcons.bell,
                color: Colors.black,
              ),
            )
          ],
        ),
        body: HomeScreenPage(),
      ),
    );
  }
}

class HomeScreenPage extends StatefulWidget {
  HomeScreenPage({Key? key}) : super(key: key);

  @override
  State<HomeScreenPage> createState() => _HomeScreenPageState();
}

class _HomeScreenPageState extends State<HomeScreenPage> {
  // ignore: deprecated_member_use
  final _referenceData = FirebaseDatabase(
          databaseURL:
              "https://bshare-a25c4-default-rtdb.asia-southeast1.firebasedatabase.app/")
      .ref();

  @override
  void initState() {
    super.initState();
    //getBookList();
  }

  BookData bookData = BookData(
      bookImageUrl: '',
      bookTitle: '',
      bookPrice: 0,
      bookDescription: '',
      bookMajor: '',
      bookOwnerId: '',
      bookId: '');

  List<BookData> booksToBeShowed = <BookData>[];
  List<BookData> allBooks = <BookData>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ignore: prefer_is_empty
      body: StreamBuilder(
        stream: _referenceData.child("Books").onValue,
        builder: (context, snapshot) {
          var bookList = <Widget>[];
          try {
            if (snapshot.hasData) {
              //CircularProgressIndicator();
              final myBooks = Map<String, dynamic>.from(
                  (snapshot.data as dynamic).snapshot.value);
              allBooks = myBooks.values.map<BookData>((value) {
                bookData = BookData.fromRTDB(Map<String, dynamic>.from(value));
                allBooks.add(bookData);

                return bookData;
              }).toList();

              booksToBeShowed = allBooks.where((book) {
                return !getUserId().contains(book.bookOwnerId);
              }).toList();

              bookList = booksToBeShowed.map<Widget>((book) {
                return CardUI(
                    book.bookImageUrl,
                    book.bookTitle,
                    book.bookPrice,
                    book.bookDescription,
                    book.bookMajor,
                    book.bookOwnerId,
                    book.bookId,
                    context);
              }).toList();
            } else {
              Center(
                child: Text(
                  'No data available',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
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

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.navigateTo(UploadRoute());
        },
        backgroundColor: Colors.orange,
        child: const Icon(
          Icons.upload,
          color: Colors.white,
        ),
      ),
    );
  }
}

// ignore: non_constant_identifier_names
CardUI(
    String bookImageUrl,
    String bookTitle,
    int bookPrice,
    String bookDescription,
    String bookMajor,
    String bookOwnerId,
    String bookId,
    BuildContext context) {
  return SingleChildScrollView(
    child: Column(
      children: [
        InkWell(
          onTap: () async {
            var booksInfo = [];
            String bookOwnerMajor = '';
            String bookOwnerUserName = '';
            bookOwnerMajor = await getUserDataByPath(bookOwnerId, 'major');
            bookOwnerUserName =
                await getUserDataByPath(bookOwnerId, 'username');
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
        Divider(
          height: 1.0,
          thickness: 1.0,
          color: Colors.teal,
        ),
        SizedBox(
          height: 3.0,
        ),
      ],
    ),
  );
}
