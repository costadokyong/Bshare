import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          body: MsgScreen(),
        ),
      ),
    );
  }
}

class MsgScreen extends StatefulWidget {
  MsgScreen({Key? key}) : super(key: key);

  @override
  State<MsgScreen> createState() => _MsgScreenState();
}

class _MsgScreenState extends State<MsgScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: const Text('Chatting Section'),
    );
  }
}
