// ignore_for_file: prefer_const_constructors

//import 'dart:html';

import 'dart:developer';
import 'package:bshare/DataBase.dart';
import 'package:bshare/Screens/home_screen.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<SignIn> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.all(10),
          child: ListView(
            children: <Widget>[
              Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    'Login',
                    style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.w500,
                        fontSize: 30),
                  )),
              Container(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    //icon: Icon(Icons.email),
                    labelText: 'email',
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: TextField(
                  obscureText: true,
                  controller: passwordController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    //icon: Icon(Icons.lock),
                    labelText: 'password',
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  //forgot password screen
                },
                child: const Text(
                  'Forgot Password',
                ),
              ),
              Container(
                  height: 50,
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: ElevatedButton(
                    child: const Text('Login'),
                    onPressed: () {
                      log(nameController.text);
                      log(passwordController.text);
                    },
                  )),
              Row(
                children: <Widget>[
                  const Text('Does not have account?'),
                  TextButton(
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(fontSize: 20),
                    ),
                    onPressed: () {
                      //signup screen
                    },
                  )
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ),
            ],
          )),
    );
  }

  //Jerry

  Widget customButton(Size size) {
    return GestureDetector(onTap: () {
      if (nameController.text.isNotEmpty &&
          passwordController.text.isNotEmpty) {
        setState(() {
          isLoading = true;
        });

        logIn(nameController.text, passwordController.text).then((user) {
          if (user != null) {
            log("Login Successful");
            setState(() {
              isLoading = false;
            });
            // Connection between HomePage And Login code
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => HomeScreen()));
          } else {
            log("Login Failed");
            setState(() {
              isLoading = false;
            });
          }
        });
      } else {
        log("Please fill in Form correctly");
      }
    });
  }
}
