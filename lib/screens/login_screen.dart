import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat_flutter/constants.dart';
import 'package:flash_chat_flutter/componet/roundbutton.dart';
import 'package:flash_chat_flutter/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  final _auth = FirebaseAuth.instance;
  bool showSpinner=false;
  String? email;
  String? password;
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Hero(
                  tag: 'logo',
                  child: Container(
                    height: 200.0,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              TextField(
                keyboardType:
                    TextInputType.emailAddress, //to show keyboard email pattern
                textAlign: TextAlign.center,
                onChanged: (value) {
                  //Do something with the user input.
                  email = value;
                },
                decoration:
                    kTextfieldDecoration.copyWith(hintText: 'Enter a email'),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                obscureText: true,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  //Do something with the user input.
                  password = value;
                },
                decoration:
                    kTextfieldDecoration.copyWith(hintText: 'Enter a password'),
              ),
              SizedBox(
                height: 24.0,
              ),
              RoundButton(
                  color: Colors.lightBlueAccent,
                  title: 'Login',
                  onpressed: () async {
                    setState(() {
                      showSpinner = true;
                    });
                    //Implement login functionality.
                    //   print(email);
                    //   print(password);
               
               try
        {                  final user = await _auth.signInWithEmailAndPassword(
                        email: '$email', password: '$password');
                    if (user!= null) {
                      Navigator.pushNamed(context, ChatScreen.id);
                    }
                    setState(() {
                      showSpinner = false;
                    });
                    }
                    
                    catch(e){
                      print(e);
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
