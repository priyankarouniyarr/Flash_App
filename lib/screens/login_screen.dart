import 'package:flash_chat_flutter/constants.dart';
import 'package:flash_chat_flutter/componet/roundbutton.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  static const String id='login_screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Hero(
              tag: 'logo',
              child: Container(
                height: 200.0,
                child: Image.asset('images/logo.png'),
              ),
            ),
            SizedBox(
              height: 48.0,
            ),
            TextField(
              onChanged: (value) {
                //Do something with the user input.
              },
              decoration:  kTextfieldDecoration.copyWith(hintText: 'Enter a email'),
            ),
            SizedBox(
              height: 8.0,
            ),
            TextField(
              onChanged: (value) {
                //Do something with the user input.
              },
              decoration: kTextfieldDecoration.copyWith(hintText: 'Enter a password'),
            ),
            SizedBox(
              height: 24.0,
            ),
            RoundButton(
              color: Colors.lightBlueAccent,
              title: 'Login',
              onpressed: () {
                //Implement login functionality.
              },
            ),
          
          ],
        ),
      ),
    );
  }
}
