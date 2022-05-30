import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

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
