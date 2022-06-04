// ignore_for_file: prefer_const_constructors

import 'package:bshare/DataBase.dart';
import 'package:bshare/Screens/IconNavigationScreens/BookData.dart';
import 'package:bshare/Screens/IconNavigationScreens/HomeScreen.dart';
import 'package:bshare/Screens/SignUp.dart';
import 'package:bshare/main.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:searchfield/searchfield.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _referenceData = FirebaseDatabase(
          databaseURL:
              "https://bshare-a25c4-default-rtdb.asia-southeast1.firebasedatabase.app/")
      .ref();

  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    if (mounted) {
      super.setState(fn);
    }
  }

  RangeValues values = RangeValues(0, 100000);
  TextEditingController titleController = TextEditingController();
  TextEditingController majorController = TextEditingController();
  String results = '';

  List<Widget> bookList = <Widget>[];
  BookData bookData = BookData(
      bookImageUrl: '',
      bookTitle: '',
      bookPrice: 0,
      bookDescription: '',
      bookMajor: '',
      bookOwnerId: '',
      bookId: '',
      isBookSold: false);

  List<BookData> theBooks = <BookData>[];
  List<BookData> theBookstoBeSearched = <BookData>[];
  List<BookData> bookSuggestions = <BookData>[];
  List<BookData> bookSearchResults = <BookData>[];

  Map<String, dynamic> myBooks = <String, dynamic>{};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.fromLTRB(16, 30, 16, 16),
            child: TextField(
              controller: titleController,
              onChanged: searchBookByName,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                labelText: 'Book Title',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(color: Colors.blue),
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(16, 5, 16, 16),
            child: TextField(
              controller: majorController,
              onChanged: filterBookByMajor,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                labelText: 'Filter By major (In Korean)',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(color: Colors.blue),
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10.0),
            // ignore: prefer_const_constructors
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Choose the Price',
                  style: TextStyle(fontSize: 20),
                ),
                RangeSlider(
                  values: values,
                  min: 0,
                  max: 100000,
                  divisions: 10,
                  labels: RangeLabels('${values.start}₩', '${values.end}₩'),
                  onChanged: (RangeValues newValues) {
                    setState(() {
                      values = newValues;
                    });
                    filterhBookByPrice(values);
                  },
                ),
                Text(
                  'Price: ${values.start.toInt()}₩ ~ ${values.end.toInt()}₩',
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
          ),
          Container(
            child: Text(results),
          ),
          Expanded(
            child: StreamBuilder(
              stream: _referenceData.child("Books").onValue,
              builder: (context, snapshot) {
                try {
                  if (snapshot.hasData) {
                    //CircularProgressIndicator();
                    myBooks = Map<String, dynamic>.from(
                        (snapshot.data as dynamic).snapshot.value);
                    int index = 0;
                    theBooks = myBooks.values.map<BookData>((value) {
                      print(index);
                      index + 1;
                      print(index);
                      bookData =
                          BookData.fromRTDB(Map<String, dynamic>.from(value));
                      theBooks.add(bookData);

                      return bookData;
                    }).toList();

                    theBookstoBeSearched = theBooks.where((book) {
                      return !getUserId().contains(book.bookOwnerId);
                    }).toList();
                    // setState(() {
                    //   bookList = theBooks.map<Widget>((book) {
                    //     return CardUI(
                    //         book.bookImageUrl,
                    //         book.bookTitle,
                    //         book.bookPrice,
                    //         book.bookDescription,
                    //         bookData.bookMajor,
                    //         bookData.bookOwnerId,
                    //         context);
                    //   }).toList();
                    // });

                  } else {
                    Center(
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
          )
        ],
      ),
    );
  }

  searchBookByName(String titleQuery) {
    bookSuggestions = theBookstoBeSearched.where((book) {
      final bookTitle = book.bookTitle.toLowerCase();
      final titleInput = titleQuery.toLowerCase();
      return bookTitle.contains(titleInput);
    }).toList();
    bookSearchResults = bookSuggestions;

    setState(() {
      bookList = bookSuggestions.map<Widget>((book) {
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
    });
    if (bookList.isEmpty) {
      setState(() {
        results =
            'No books founded with this title, major or price range, Try type again the title or choose another major or price range ';
      });
    } else {
      setState(() {
        results = '${bookList.length} Results';
      });
    }
  }

  void filterBookByMajor(String majorQuery) {
    if (bookSearchResults.isNotEmpty) {
      bookSuggestions = bookSearchResults.where((book) {
        final bookMajor = book.bookMajor;
        final majorInput = majorQuery;
        return bookMajor.contains(majorInput);
      }).toList();
    } else {
      bookSuggestions = theBookstoBeSearched.where((book) {
        final bookMajor = book.bookMajor;
        final majorInput = majorQuery;
        return bookMajor.contains(majorInput);
      }).toList();
      bookSearchResults = bookSuggestions;
    }

    setState(() {
      bookList = bookSuggestions.map<Widget>((book) {
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
    });
    if (bookList.isEmpty) {
      setState(() {
        results =
            'No books founded with this title, major or price range, Try type again the title or choose another major or price range ';
      });
    } else {
      setState(() {
        results = '${bookList.length} Results';
      });
    }
  }

  void filterhBookByPrice(RangeValues selectedRange) {
    bookSuggestions = bookSearchResults.where((book) {
      final bookPrice = book.bookPrice;
      final inputRange = selectedRange;

      return bookPrice >= inputRange.start && bookPrice <= inputRange.end;
    }).toList();

    setState(() {
      bookList = bookSuggestions.map<Widget>((book) {
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
    });
    if (bookList.isEmpty) {
      setState(() {
        results =
            'No books founded with this title, major or price range, Try type again the title or choose another major or price range ';
      });
    } else {
      setState(() {
        results = '${bookList.length} Results';
      });
    }
  }
}
