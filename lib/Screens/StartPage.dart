import 'package:auto_route/auto_route.dart';
import 'package:bshare/routes/router.gr.dart';
import 'package:flutter/material.dart';

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
                        context.router.push(const SingUpRoute());
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
                        context.navigateTo(const SignInRoute());
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
