// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:bshare/DataBase.dart';
import 'package:bshare/Screens/ChatScreens/ChatUsers.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../ChatScreens/Message.dart';

class MsgScreen extends StatefulWidget {
  MsgScreen({Key? key}) : super(key: key);

  @override
  State<MsgScreen> createState() => _MsgScreenState();
}

class _MsgScreenState extends State<MsgScreen> {
  final _referenceData = FirebaseDatabase(
          databaseURL:
              "https://bshare-a25c4-default-rtdb.asia-southeast1.firebasedatabase.app/")
      .ref();

  Map<String, dynamic> chatUsers = <String, dynamic>{};
  List<ChatUsers> contacts = <ChatUsers>[];
  ChatUsers contact = ChatUsers(username: '', userId: '', lastMessage: '');
  List<Widget> contactList = <Widget>[];
  // ChatUsers(
  //   name: "User1",
  //   imageUrl:
  //       'https://cdn.pixabay.com/photo/2020/07/01/12/58/icon-5359553_1280.png',
  // ),
  // ChatUsers(
  //   name: "User2",
  //   imageUrl:
  //       'https://cdn.pixabay.com/photo/2020/07/01/12/58/icon-5359553_1280.png',
  // ),
  // ChatUsers(
  //   name: "User3",
  //   imageUrl:
  //       'https://cdn.pixabay.com/photo/2020/07/01/12/58/icon-5359553_1280.png',
  // )

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SafeArea(
            child: Padding(
              padding: EdgeInsets.only(left: 16, right: 16, top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Conversations",
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                  // Container(
                  //   padding:
                  //       EdgeInsets.only(left: 8, right: 8, top: 2, bottom: 2),
                  //   height: 30,
                  //   decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.circular(30),
                  //     color: Colors.pink[50],
                  //   ),
                  //   child: Row(
                  //     children: <Widget>[
                  //       Icon(
                  //         Icons.add,
                  //         color: Colors.pink,
                  //         size: 20,
                  //       ),
                  //       SizedBox(
                  //         width: 2,
                  //       ),
                  //       Text(
                  //         "Add New",
                  //         style: TextStyle(
                  //             fontSize: 14, fontWeight: FontWeight.bold),
                  //       ),
                  //     ],
                  //   ),
                  // )
                ],
              ),
            ),
          ),
          // Padding(
          //   padding: EdgeInsets.only(top: 16, left: 16, right: 16),
          //   child: TextField(
          //     decoration: InputDecoration(
          //       hintText: "Search...",
          //       hintStyle: TextStyle(color: Colors.grey.shade600),
          //       prefixIcon: Icon(
          //         Icons.search,
          //         color: Colors.grey.shade600,
          //         size: 20,
          //       ),
          //       filled: true,
          //       fillColor: Colors.grey.shade100,
          //       contentPadding: EdgeInsets.all(8),
          //       enabledBorder: OutlineInputBorder(
          //           borderRadius: BorderRadius.circular(20),
          //           borderSide: BorderSide(color: Colors.grey.shade100)),
          //     ),
          //   ),
          // ),
          StreamBuilder(
            stream:
                _referenceData.child('contactList').child(getUserId()).onValue,
            builder: (context, snapshot) {
              try {
                if (snapshot.hasData) {
                  chatUsers = Map<String, dynamic>.from(
                      (snapshot.data as dynamic).snapshot.value);

                  contacts = chatUsers.values.map<ChatUsers>((chatUser) {
                    contact =
                        ChatUsers.fromRTDB(Map<String, dynamic>.from(chatUser));
                    return contact;
                  }).toList();

                  contactList = contacts.map<Widget>((user) {
                    return ConversationList(
                      name: user.username,
                      imageUrl:
                          'https://cdn.pixabay.com/photo/2020/07/01/12/58/icon-5359553_1280.png',
                      userId: user.userId,
                      lastmessage: user.lastMessage,
                    );
                  }).toList();
                } else {
                  Center(
                      child: Text(
                    'No Contacts',
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
                  ));
                }
              } catch (e) {
                print('falied to get contact List $e');
              }

              return ListView(
                shrinkWrap: true,
                padding: EdgeInsets.only(top: 16),
                children: contactList,
              );
            },
          )
          // ListView.builder(
          //   itemCount: chatUsers.length,
          //   shrinkWrap: true,
          //   padding: EdgeInsets.only(top: 16),
          //   physics: NeverScrollableScrollPhysics(),
          //   itemBuilder: (context, index) {
          //     return ConversationList(
          //       name: chatUsers[index].name,
          //       //messageText: chatUsers[index].messageText,
          //       imageUrl: chatUsers[index].imageUrl,
          //       // time: chatUsers[index].time,
          //       is_MessageRead: (index == 0 || index == 3) ? true : false,
          //     );
          //   },
          // ),
        ],
      ),
    );
  }
}
