// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class Upload extends StatelessWidget {
  final String title = "Upload File";
  const Upload({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            backgroundColor: Colors.white,
            leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
                onPressed: () {
                  Navigator.pop(context, true);
                }),
            title: Text(
              title,
              style: TextStyle(color: Colors.black),
            ),
          ),
          body: UploadFile(),
        ),
      ),
    );
  }
}

class UploadFile extends StatefulWidget {
  UploadFile({Key? key}) : super(key: key);

  @override
  State<UploadFile> createState() => _UploadFileState();
}

class _UploadFileState extends State<UploadFile> {
  //String dropDownValue = 'Categories';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        //reverse: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            InkWell(
              onTap: () {},
              child: Container(
                margin: const EdgeInsets.symmetric(
                    vertical: 30.0, horizontal: 150.0),
                padding: const EdgeInsets.symmetric(
                    vertical: 12.0, horizontal: 12.0),
                height: 90.0,
                width: 60.0,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                  ),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    const Icon(
                      Icons.camera_alt,
                      size: 50.0,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 15.0,
            ),
            Divider(
              indent: 20.0,
              endIndent: 20.0,
              height: 5.0,
              thickness: 1.0,
              color: Colors.teal[100],
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
              //The user can edit his name in this placeholder
              child: TextFormField(
                textAlign: TextAlign.start,
                // ignore: prefer_const_constructors
                decoration: InputDecoration(
                  labelText: 'Title',
                ),
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Divider(
              indent: 20.0,
              endIndent: 20.0,
              height: 5.0,
              thickness: 1.0,
              color: Colors.teal[100],
            ),
            const SizedBox(
              height: 5.0,
            ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 10.0),
            //   child: DropdownButton<String>(
            //     value: dropDownValue,
            //     isExpanded: true,
            //     onChanged: (String? newValue) {
            //       setState(() {
            //         dropDownValue = newValue!;
            //       });
            //     },
            //     items: <String>['Categories']
            //         .map<DropdownMenuItem<String>>((String value) {
            //       return DropdownMenuItem<String>(
            //         value: value,
            //         child: Text(value),
            //       );
            //     }).toList(),
            //   ),
            // ),
            // const SizedBox(
            //   height: 15.0,
            // ),
            Padding(
              // padding: EdgeInsets.only(
              //     bottom: MediaQuery.of(context).viewInsets.bottom),
              padding: EdgeInsets.all(10.0),
              // ignore: prefer_const_constructors
              child: TextField(
                obscureText: true,
                decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Enter Your desired Price',
                ),
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            Padding(
              padding: EdgeInsets.all(5.0),
              child: Expanded(
                child: TextFormField(
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Give a description of your book',
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 160.0,
            ),
            Divider(
              indent: 20.0,
              endIndent: 20.0,
              height: 10.0,
              thickness: 1.0,
              color: Colors.teal[100],
            ),
            InkWell(
              onTap: () {
                print('Pushed');
              },
              child: Container(
                width: 100,
                height: 50,
                alignment: Alignment.center,
                color: Colors.black26,
                child: const Text(
                  'Done',
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
