// ignore_for_file: no_logic_in_create_state, prefer_const_constructors

import 'package:bshare/DataBase.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'MessageModel.dart';

class ChatDetailScreen extends StatefulWidget {
  String bookOwnerUserName = '';
  String bookOwnerId = '';

  ChatDetailScreen(
      {Key? key, required this.bookOwnerUserName, required this.bookOwnerId})
      : super(key: key);

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState(
      bookOwnerUserName: bookOwnerUserName, bookOwnerId: bookOwnerId);
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  final _referenceData = FirebaseDatabase(
          databaseURL:
              "https://bshare-a25c4-default-rtdb.asia-southeast1.firebasedatabase.app/")
      .ref();
  String bookOwnerUserName = '';
  String bookOwnerId = '';

  _ChatDetailScreenState(
      {required this.bookOwnerUserName, required this.bookOwnerId});
  TextEditingController messageController = TextEditingController();
  Map<String, dynamic> messages = <String, dynamic>{};
  List<ChatMessage> chatMessages = <ChatMessage>[];
  ChatMessage chatMessage = ChatMessage(
      messageContent: '', messageType: '', timeStamp: DateTime.now());
  List<Widget> messageList = <Widget>[];

  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        flexibleSpace: SafeArea(
          child: Container(
            padding: EdgeInsets.only(right: 16),
            child: Row(
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(
                  width: 2,
                ),
                const CircleAvatar(
                  backgroundImage: NetworkImage(
                      'https://cdn.pixabay.com/photo/2020/07/01/12/58/icon-5359553_1280.png'),
                  maxRadius: 20,
                ),
                const SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        bookOwnerUserName,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: _referenceData
                  .child('chatMessages')
                  .child('${getUserId()}and$bookOwnerId')
                  .onValue,
              builder: (context, snapshot) {
                try {
                  if (snapshot.hasData) {
                    messages = Map<String, dynamic>.from(
                        (snapshot.data as dynamic).snapshot.value);

                    chatMessages = messages.values.map<ChatMessage>((message) {
                      chatMessage = ChatMessage.fromRTDB(
                          Map<String, dynamic>.from(message));
                      return chatMessage;
                    }).toList();

                    chatMessages
                        .sort((a, b) => a.timeStamp.compareTo(b.timeStamp));

                    updateLastMessage(chatMessages.last, bookOwnerId);

                    messageList = chatMessages.map<Widget>((message) {
                      return Container(
                        padding: EdgeInsets.only(
                            left: 14, right: 14, top: 10, bottom: 10),
                        child: Align(
                          alignment: (message.messageType == "sender"
                              ? Alignment.topRight
                              : Alignment.topLeft),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: (message.messageType == "sender"
                                  ? Colors.blue[200]
                                  : Colors.grey.shade200),
                            ),
                            padding: EdgeInsets.all(16),
                            child: Text(
                              message.messageContent,
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
                        ),
                      );
                    }).toList();
                    messageList = messageList.reversed.toList();
                  } else {
                    Center(
                        child: Text(
                      'No messages',
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.w600),
                    ));
                  }
                } catch (e) {
                  print('falied to get mesasges $e');
                }
                return ListView(
                  reverse: true,
                  controller: scrollController,
                  padding: EdgeInsets.only(top: 10),
                  shrinkWrap: false,
                  children: messageList,
                );
              },
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              padding: EdgeInsets.only(left: 10, bottom: 10, top: 10),
              height: 60,
              width: double.infinity,
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: TextField(
                      controller: messageController,
                      decoration: InputDecoration(
                          hintText: "Write message...",
                          hintStyle: TextStyle(color: Colors.black54),
                          border: InputBorder.none),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  FloatingActionButton(
                    onPressed: () async {
                      await sendMessage(bookOwnerId, messageController.text);
                      notify(bookOwnerId);
                      messageController.clear();
                    },
                    child: const Icon(
                      Icons.send,
                      color: Colors.white,
                      size: 18,
                    ),
                    backgroundColor: Colors.grey,
                    elevation: 0,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
