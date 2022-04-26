// ignore_for_file: prefer_const_constructors, avoid_print

import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:bshare/DataBase.dart';
import 'package:bshare/routes/router.gr.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class SingUp extends StatefulWidget {
  const SingUp({
    Key? key,
  }) : super(key: key); //required this.title

  @override
  State<SingUp> createState() => _MySingUpState();
}

class _MySingUpState extends State<SingUp> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final universityController = TextEditingController();
  final majorController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  List<String> _majorList = [];
  List<DropdownMenuItem<String>> majorListItems = <DropdownMenuItem<String>>[];
  String _dropdownValue = '';

  Future<List<String>> getMajorList() async {
    List<String> majorList = [];
    await rootBundle.loadString('major_list/majorlist.txt').then((major) {
      for (String i in LineSplitter().convert(major)) {
        majorList.add(i);
      }
    });
    return majorList;
  }

  @override
  void initState() {
    _setup();
    super.initState();
  }

  _setup() async {
    List<String> mList = await getMajorList();

    setState(() {
      _majorList = mList.toSet().toList();
      _dropdownValue = _majorList[0];
      majorListItems = _majorList.map<DropdownMenuItem<String>>((item) {
        return DropdownMenuItem<String>(value: item, child: Text(item));
      }).toList();
    });
  }

  @override
  void dispose() {
    //Clean up the controller when the Widget is disposed
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    universityController.dispose();
    majorController.dispose();
    super.dispose();
  }

  createAlertDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Signed up Sucessfully"),
            actions: [
              MaterialButton(
                elevation: 5.0,
                child: Text("Ok"),
                onPressed: () {
                  Navigator.of(context).pop();
                  nameController.clear();
                  emailController.clear();
                  passwordController.clear();
                  universityController.clear();
                  majorController.clear();

                  context.router.push(SignInRoute());
                },
              )
            ],
          );
        });
  }

  Widget majorListDropDown({required String title}) {
    return Container(
      alignment: Alignment.topRight,
      child: Column(children: [
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            title,
            style: TextStyle(
              fontSize: 14.0,
              color: Colors.grey,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
          child: DropdownButtonFormField<String>(
            value: _dropdownValue,
            hint: Text('Major'),
            elevation: 16,
            onChanged: (String? newValue) {
              setState(() {
                _dropdownValue = newValue!;
              });
            },
            items: majorListItems,
          ),
        )
      ]),
    );
  }

  Widget myContainer(
      {required String title,
      required String labelText,
      required TextEditingController controller,
      required bool isEmail,
      required bool isPassword}) {
    //String hintText
    return Container(
      alignment: Alignment.topLeft,
      child: Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              title,
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.grey,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
            child: TextFormField(
              obscureText: isPassword,
              style: TextStyle(height: 0.5, fontSize: 14.0),
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: labelText,
                //hintText: hintText,
              ),
              controller: controller,
              validator: (value) {
                if (isEmail) {
                  if (EmailValidator.validate(value!) == false) {
                    return 'Please enter a valid email';
                  }
                } else {
                  if (value == null || value.isEmpty) {
                    return 'Required Field';
                  }
                }
                return null;
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = ElevatedButton.styleFrom(
      textStyle: TextStyle(fontSize: 18.0, color: Colors.white),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          Form(
            key: _formKey,
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 20.0, horizontal: 8.0),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      'SignUp',
                      style: TextStyle(
                          fontSize: 25.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                myContainer(
                    title: '  Username',
                    labelText: 'Enter Username',
                    controller: nameController,
                    isEmail: false,
                    isPassword: false),
                SizedBox(
                  height: 5.0,
                ),
                myContainer(
                    title: '  Email',
                    labelText: 'Enter Email',
                    controller: emailController,
                    isEmail: true,
                    isPassword: false),
                SizedBox(
                  height: 5.0,
                ),
                myContainer(
                    title: '  Password',
                    labelText: 'Enter Password',
                    controller: passwordController,
                    isEmail: false,
                    isPassword: true),
                SizedBox(
                  height: 5.0,
                ),
                myContainer(
                    title: '  University',
                    labelText: 'Enter University',
                    controller: universityController,
                    isEmail: false,
                    isPassword: false),
                SizedBox(
                  height: 5.0,
                ),
                majorListDropDown(title: 'Major'),
                SizedBox(
                  height: 18.0,
                ),
                SizedBox(
                  width: 150.0,
                  height: 45.0,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      style: style,
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          await register(
                              nameController.text,
                              emailController.text,
                              passwordController.text,
                              universityController.text,
                              majorController.text);
                          createAlertDialog(context);
                        }
                      },
                      child: Text('Sign Up'),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
