// ignore_for_file: non_constant_identifier_names, must_be_immutable, use_key_in_widget_constructors, empty_constructor_bodies

import 'package:bshare/DataBase.dart';
import 'package:bshare/Screens/ChatScreens/ChatDetailScreen.dart';
import 'package:flutter/material.dart';

class ConversationList extends StatefulWidget {
  late String name;
  late String lastmessage;
  late String imageUrl;
  late String userId;
  //late String time;
  bool is_MessageRead = false;

  ConversationList(
      {required this.name,
      required this.lastmessage,
      required this.imageUrl,
      required this.userId
      //required this.time,
      //required this.is_MessageRead
      });

  @override
  State<ConversationList> createState() {
    return _ConversationListState();
  }
}

class _ConversationListState extends State<ConversationList> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ChatDetailScreen(
                  bookOwnerId: widget.userId, bookOwnerUserName: widget.name)),
        );
        notified();
      },
      child: Container(
        padding:
            const EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage: NetworkImage(widget.imageUrl),
                    maxRadius: 30,
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: Container(
                      color: Colors.transparent,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            widget.name,
                            style: const TextStyle(fontSize: 16),
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          Text(
                            widget.lastmessage,
                            style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey.shade600,
                                fontWeight: widget.is_MessageRead
                                    ? FontWeight.bold
                                    : FontWeight.normal),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Text(
            //   widget.time,
            //   style: TextStyle(
            //       fontSize: 12,
            //       fontWeight: widget.is_MessageRead
            //           ? FontWeight.bold
            //           : FontWeight.normal),
            // ),
          ],
        ),
      ),
    );
  }
}
