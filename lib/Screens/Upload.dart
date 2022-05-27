// ignore_for_file: prefer_const_constructors

import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:bshare/DataBase.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:searchfield/searchfield.dart';
import 'package:uuid/uuid.dart';
import 'package:bshare/Screens/SignUp.dart';
import 'SignIn.dart';

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
  List<String> _majorListForUpload = [];
  List<SearchFieldListItem<String>> majorListforUploadItems =
      <SearchFieldListItem<String>>[];

  final _formKey = GlobalKey<FormState>();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController MajorController = TextEditingController();
  final TextEditingController descpController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  Image bookImage = Image.asset(
    'images/bookiicon.png',
    width: 200,
    height: 200,
  );
  File? bookImageFile;
  var bookId = Uuid();
  double price = 0;
  int intPrice = 0;

  @override
  void initState() {
    _setUp();
    super.initState();
  }

  _setUp() async {
    List<String> mList = await MySingUpState().getMajorList();

    setState(() {
      _majorListForUpload = mList.toSet().toList();
      majorListforUploadItems =
          _majorListForUpload.map<SearchFieldListItem<String>>((item) {
        return SearchFieldListItem<String>(item);
      }).toList();
    });
  }

  Future pickImage(ImageSource source) async {
    final image = await ImagePicker().pickImage(source: source);
    if (image == null) return;
    final imageTemporary = File(image.path);
    bookImageFile = imageTemporary;

    setState(() {
      this.bookImage = Image.file(
        imageTemporary,
        width: 200,
        height: 200,
      );
    });
  }

  void _getBookImage() {
    if (Platform.isIOS) {
      showCupertinoModalPopup(
        context: context,
        builder: (context) => CupertinoActionSheet(
          actions: [
            CupertinoActionSheetAction(
              onPressed: (() async {
                pickImage(ImageSource.camera);
                Navigator.pop(context);
              }),
              child: Text('Camera'),
            ),
            CupertinoActionSheetAction(
              onPressed: (() async {
                pickImage(ImageSource.gallery);
                Navigator.pop(context);
              }),
              child: Text('Gallery'),
            )
          ],
        ),
      );
    } else {
      showModalBottomSheet(
          context: context,
          builder: (context) => ListView(
                children: [
                  ListTile(
                    leading: Icon(Icons.camera_alt),
                    title: Text('Camera'),
                    onTap: () async {
                      pickImage(ImageSource.camera);
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.photo_album),
                    title: Text('Gallery'),
                    onTap: () async {
                      pickImage(ImageSource.gallery);
                      Navigator.pop(context);
                    },
                  )
                ],
              ));
    }
  }

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
              onTap: () {
                _getBookImage();
              },
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
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        const Icon(
                          Icons.camera_alt,
                          size: 50.0,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 15.0,
            ),
            Container(child: bookImage),
            Divider(
              indent: 20.0,
              endIndent: 20.0,
              height: 5.0,
              thickness: 1.0,
              color: Colors.teal[100],
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12.0, horizontal: 12.0),
                    //The user can edit his name in this placeholder
                    child: TextFormField(
                      controller: titleController,
                      textAlign: TextAlign.start,
                      // ignore: prefer_const_constructors
                      decoration: InputDecoration(
                        labelText: 'Title',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Required Field';
                        }
                      },
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
                  MySingUpState().majorListDropDown(
                      title: 'Choose the major of the book',
                      controller: MajorController,
                      itemList: majorListforUploadItems),
                  const SizedBox(
                    height: 5.0,
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Expanded(
                      child: TextFormField(
                        controller: descpController,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Give a description of your book',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Required Field';
                          }
                        },
                      ),
                    ),
                  ),
                ],
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
                  Slider(
                    value: price,
                    min: 0,
                    max: 100000,
                    divisions: 10,
                    label: '$intPrice₩',
                    onChanged: (value) {
                      setState(() {
                        price = value;
                        intPrice = price.toInt();
                      });
                    },
                  ),
                  Text(
                    'Price: $intPrice₩',
                    style: TextStyle(fontSize: 20),
                  ),
                ],
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
              onTap: () async {
                if (bookImageFile != null &&
                    _formKey.currentState!.validate()) {
                  await uploadBookImage(bookImageFile!, titleController.text);
                  await uploadBook(bookId.v1(), titleController.text,
                      MajorController.text, descpController.text, intPrice);

                  showDialog(
                      context: context,
                      builder: (context) => CustomDialogAuth(
                            title: 'Book uploaded',
                            isSignIn: false,
                            isUpload: true,
                          ));
                  titleController.clear();
                  MajorController.clear();
                  descpController.clear();
                  priceController.clear();
                  setState(() {
                    bookImage = Image.asset(
                      'images/bookiicon.png',
                      width: 200,
                      height: 200,
                    );
                  });
                  bookImageFile = null;
                } else if (bookImageFile == null) {
                  showDialog(
                    context: context,
                    builder: (context) => CustomDialog(
                      title: 'Error',
                      description: 'Please insert an image of your book',
                    ),
                  );
                }
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
