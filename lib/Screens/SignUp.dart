// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:bshare/DataBase.dart';
import 'package:flutter/material.dart';
import 'package:bshare/Screens/SignIn.dart';

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
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SignIn()));
                },
              )
            ],
          );
        });
  }

  Widget myContainer(
      {required String title,
      required String labelText,
      required TextEditingController controller}) {
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
            child: TextField(
              style: TextStyle(height: 0.5, fontSize: 14.0),
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: labelText,
                //hintText: hintText,
              ),
              controller: controller,
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
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 20.0, horizontal: 8.0),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  'SignUp',
                  style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            myContainer(
                title: '  Username',
                labelText: 'Enter Username',
                controller: nameController),
            SizedBox(
              height: 5.0,
            ),
            myContainer(
                title: '  Email',
                labelText: 'Enter Email',
                controller: emailController),
            SizedBox(
              height: 5.0,
            ),
            myContainer(
                title: '  Password',
                labelText: 'Enter Password',
                controller: passwordController),
            SizedBox(
              height: 5.0,
            ),
            myContainer(
                title: '  University',
                labelText: 'Enter University',
                controller: universityController),
            SizedBox(
              height: 5.0,
            ),
            myContainer(
                title: '  Major',
                labelText: 'Enter Major',
                controller: majorController),
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
                    register(
                        nameController.text,
                        emailController.text,
                        passwordController.text,
                        universityController.text,
                        majorController.text);
                    createAlertDialog(context);
                  },
                  child: Text('Sign Up'),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
