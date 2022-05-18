// ignore_for_file: dead_code, unused_label, prefer_const_constructors_in_immutables, prefer_const_constructors, unused_local_variable
import 'dart:io';
import 'package:auto_route/auto_route.dart';
import 'package:bshare/Screens/BookData.dart';
import 'package:bshare/routes/router.gr.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:bshare/Screens/Upload.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:bshare/DataBase.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: HomeScreenPage(),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Bshare'),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(FontAwesomeIcons.magnifyingGlass),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(FontAwesomeIcons.bars),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(FontAwesomeIcons.bell),
            )
          ],
        ),
        body: HomeScreenPage(),
      ),
    );
  }
}

class HomeScreenPage extends StatefulWidget {
  //HomeScreenPage({Key? key}) : super(key: key);

  @override
  State<HomeScreenPage> createState() => _HomeScreenPageState();
}

class _HomeScreenPageState extends State<HomeScreenPage> {
  List<BookData> dataList = [];

  @override
  void initState() {
    super.initState();
    // DatabaseReference referenceData =
    //     // ignore: deprecated_member_use
    //     FirebaseDatabase().instance.ref().child("Books");

    final referenceData = FirebaseDatabase.instance.ref().child("Books");

    // ignore: avoid_single_cascade_in_expression_statements
    referenceData.once().then(
      (event) {
        Map<dynamic, dynamic> map =
            event.snapshot.value as Map<dynamic, dynamic>;
        dataList.clear();

        map.forEach(
          (key, value) {
            var values = Map<dynamic, dynamic>.from(map);
            BookData data = BookData(
              values['bookImageUrl'],
              values['bookTitle'],
              values['bookPrice'],
              values['bookDescription'],
            );
            dataList.add(data);
          },
        );
        setState(() {});
      },
    );

    // referenceData.once().then((event) {
    //   final dataSnapshot = event.snapshot;
    //   // dataList.clear();
    //   var keys = dataSnapshot.value!.getKey();
    //   var values = dataSnapshot.value;
    //   for (var key in keys) {
    //     BookData data = BookData(
    //       values[key]["imageUrl"],
    //       values[key]["bookTitle"],
    //       values[key]["price"],
    //       values[key]["description"],
    //     );
    //     dataList.add(data);
    //   }
    //   setState(() {
    //     //
    //   });

    //   (dataSnapshot as Map<dynamic, dynamic>).forEach((key, value) {
    //     BookData data = BookData(
    //       values![key]["bookImageUrl"],
    //       values[key]["bookTitle"],
    //       values[key]["bookPrice"],
    //       values[key]["bookDescription"],
    //     );
    //     dataList.add(data);
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // ignore: prefer_is_empty
        body: dataList.length == 0
            ? Center(
                child: Text('No data Available'),
              )
            : ListView.builder(
                itemCount: dataList.length,
                itemBuilder: (_, index) {
                  return CardUI(
                    dataList[index].bookImageUrl,
                    dataList[index].bookTitle,
                    dataList[index].bookPrice,
                    dataList[index].bookDescription,
                  );
                }),
        //HomeScreen2(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            context.navigateTo(UploadRoute());
          },
          backgroundColor: Colors.deepOrange,
          child: const Icon(
            Icons.upload,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

// ignore: non_constant_identifier_names
Widget CardUI(File imageUrl, String bookTitle, int price, String description) {
  return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Image.file(
          imageUrl,
          height: 110.0,
          width: 100.0,
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.all(5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(bookTitle, style: TextStyle(fontWeight: FontWeight.bold)),
                Text(description),
                Text("Price: " + price.toString()),
              ],
            ),
          ),
        ),
      ]);
}

// class HomeScreen2 extends StatefulWidget {
//   HomeScreen2({Key? key}) : super(key: key);
//   @override
//   State<HomeScreen2> createState() => _HomeScreen2State();
// }

// class _HomeScreen2State extends State<HomeScreen2> {


//   @override
//   Widget build(BuildContext context) {
//     return const Center(
//       child: Text('Home Screen'),
//     );
//   }
// }

