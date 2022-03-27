import 'package:bshare/Screens/SignIn.dart';
import 'package:bshare/Screens/SignUp.dart';
import 'package:bshare/main.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.grey[300],
      ),
      home: const FirstPage(),
    );
  }
}

class FirstPage extends StatelessWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //Firstpage Background Image
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('images/booksWallpper.jpg'),
                    fit: BoxFit.cover)),
          ),
          //Title container
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 100.0, horizontal: 35.0),
            child: Container(
              // decoration: BoxDecoration(
              //   borderRadius: BorderRadius.circular(3.0),
              // ),
              height: 100.0,
              width: 320,
              //color: Colors.yellow,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.yellow[500],
                  borderRadius: const BorderRadius.all(Radius.circular(10.0))),
              child: const Text(
                'BSHARE',
                style: TextStyle(
                    fontSize: 75.0,
                    fontWeight: FontWeight.w900,
                    fontStyle: FontStyle.italic,
                    color: Colors.black),
              ),
            ),
          ),
          //Sign Up and Log In buttons Implementation
          Container(
            margin: const EdgeInsets.only(bottom: 10.0),
            child: Expanded(
              flex: 3,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    height: 80,
                    width: double.infinity,
                    padding:
                        const EdgeInsets.only(top: 25, left: 24, right: 24),
                    child: RaisedButton(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25)),
                      color: Colors.indigo,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: ((context) {
                              return const MyHomePage(); //title: 'Bshare'
                            }),
                          ),
                        );
                      },
                      child: const Text(
                        'SIGN UP',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 80,
                    width: double.infinity,
                    padding:
                        const EdgeInsets.only(top: 25, left: 24, right: 24),
                    child: RaisedButton(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25)),
                      color: Colors.white,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: ((context) {
                              return const SignIn(); //title: 'Bshare'
                            }),
                          ),
                        );
                      },
                      child: const Text(
                        'ALREADY HAVE AN ACCOUNT?',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w900,
                          color: Colors.lightBlue,
                        ),
                      ),
                    ),
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

  // authentificationButton(
  //                     Colors.indigo, 'SIGN UP', Colors.white, context),
  //                 authentificationButton(Colors.white,
  //                     'ALREADY HAVE AN ACCOUNT?', Colors.lightBlue, context),