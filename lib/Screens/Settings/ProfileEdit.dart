// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class ProfileEdit extends StatelessWidget {
  const ProfileEdit({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
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
              title: const Text(
                'Profile Settings',
                style: TextStyle(color: Colors.black),
              ),
            ),
            resizeToAvoidBottomInset: false,
            body: ProfileEditSettings()),
      ),
    );
  }
}

class ProfileEditSettings extends StatefulWidget {
  ProfileEditSettings({Key? key}) : super(key: key);

  @override
  State<ProfileEditSettings> createState() => _ProfileEditSettingsState();
}

class _ProfileEditSettingsState extends State<ProfileEditSettings> {
  //here goes the profile image file of the user
  String url =
      'https://cdn.pixabay.com/photo/2016/08/08/09/17/avatar-1577909_960_720.png';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.only(top: 60.0),
          child: Stack(
            children: [
              CircleAvatar(
                radius: 100,
                backgroundImage: NetworkImage(url),
              ),
              Positioned(
                right: 10,
                bottom: 10,
                child: InkWell(
                  onTap: () {},
                  child: Icon(
                    Icons.camera_alt_rounded,
                    size: 30.0,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 30.0,
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 0, horizontal: 12.0),
          //The user can edit his name in this placeholder
          child: TextFormField(
            textAlign: TextAlign.center,
            // ignore: prefer_const_constructors
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: 'Enter your username',
            ),
          ),
        ),

        const SizedBox(
          height: 248.0,
        ),
        // Align(
        //   alignment: Alignment.bottomCenter,
        //   child: Expanded(
        //     child: ElevatedButton(
        //       onPressed: () {},
        //       child: const Text('Done'),
        //     ),
        //   ),
        // )

        InkWell(
          onTap: () {
            print('Pushed');
          },
          child: Container(
            width: 100,
            height: 60,
            alignment: Alignment.center,
            color: Colors.black26,
            child: const Text(
              'Done',
              style: TextStyle(fontSize: 20.0),
            ),
          ),
        ),
      ],
    );
  }
}
