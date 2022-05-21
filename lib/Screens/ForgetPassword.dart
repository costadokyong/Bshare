import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:bshare/routes/router.gr.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  State<ForgetPassword> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<ForgetPassword> {
  final TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

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
                  'Reset Your Password',
                  style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.w500,
                      fontSize: 30),
                ),
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: TextFormField(
                        controller: _emailController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          icon: Icon(Icons.email),
                          labelText: 'Email',
                        ),
                        validator: (value) {
                          if (EmailValidator.validate(value!) == false) {
                            return 'Invalid Email Address';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                  height: 50,
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: ElevatedButton(
                    child: const Text('Reset Password'),
                    onPressed: () {
                      if (_emailController.text.isNotEmpty) {
                        resetPassword(_emailController.text.toString())
                            .then((user) {
                          if (user == null) {
                            //
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text('Mail has been Sent'),
                                // content:
                                //     const Text('Do you want to exit an App'),
                                actions: [
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(true),
                                    child: const Text('OKay'),
                                  ),
                                ],
                              ),
                            );

                            //

                            _formKey.currentState!.validate();
                            _emailController.clear();
                          }
                        });
                      }
                    },
                  )),
              Row(
                children: <Widget>[
                  //const Text('Does not have account?'),
                  TextButton(
                    child: const Text(
                      'Login',
                      style: TextStyle(fontSize: 20),
                    ),
                    onPressed: () {
                      context.navigateTo(const SignInRoute());
                    },
                  )
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ),
            ],
          )),
    );
  }

  // resetPassword Method
  Future resetPassword(String email) async {
    //String email = _emailController.text.toString();

    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print(e);
    }
  }

  createAlertDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text(
                "Please entered with Your Registered Email Address.."),
            actions: [
              MaterialButton(
                elevation: 5.0,
                child: const Text("Ok"),
                onPressed: () {
                  Navigator.of(context).pop();
                  _emailController.clear();
                },
              )
            ],
          );
        });
  }
}
