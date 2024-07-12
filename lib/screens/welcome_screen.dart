import 'package:flash_chat_flutter/screens/login_screen.dart';
import 'package:flash_chat_flutter/screens/registration_screen.dart';
import 'package:flash_chat_flutter/componet/roundbutton.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/widgets.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcomeScreen';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  AnimationController? controller;
  Animation? animation; //for curved//value
  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    //animation = CurvedAnimation(
    // parent: controller!, curve: Curves.easeIn); //for curvedanimation//speed slow to fast
    animation = ColorTween(begin: Colors.blueGrey, end: Colors.white)
        .animate(controller!);
    controller!.forward();

    controller!.addListener(() {
      setState(() {}); //action
      //print(controller?.value);//here
      //print(animation?.value);
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(controller!.value),
      //backgroundColor: Colors.white,
      //backgroundColor: animation?.value,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: Container(
                    child: Image.asset('images/logo.png'),
                    height: 60.0,
                    //  height:controller?.value,
                    //  height:animation?.value*100,
                    //  height: 100,
                  ),
                ),
                TypewriterAnimatedTextKit(
                  //animation
                  // '${controller?.value.toStringAsFixed(2)}',
                  text: ['Flash Chat'],
                  textStyle: TextStyle(
                      fontSize: 45.0,
                      fontWeight: FontWeight.w900,
                      color:Colors.grey
                     // color: animation!.value)
                     // ,
                ),)
              ],
            ),
            const SizedBox(
              height: 48.0,
            ),
            RoundButton(
              color: Colors.blueAccent,
              onpressed: () {
                //Go to login screen.
                Navigator.pushNamed(context, LoginScreen.id);
              },
              title: 'Log In',
            ),
            RoundButton(
              onpressed: () {
                Navigator.pushNamed(context, RegistrationScreen.id);
              },
              color: Colors.blueAccent,
              title: 'Register',
            ),
          ],
        ),
      ),
    );
  }
}
