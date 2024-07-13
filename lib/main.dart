import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat_flutter/screens/welcome_screen.dart';
import 'package:flash_chat_flutter/screens/login_screen.dart';
import 'package:flash_chat_flutter/screens/registration_screen.dart';
import 'package:flash_chat_flutter/screens/chat_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();//makes sure Flutter is ready to use Firebase.

  await Firebase.initializeApp(//This setup is necessary to use Firebase services like authentication, database, and messaging in your Flutter app.
      options: FirebaseOptions(
    apiKey: "AIzaSyDTK-oE0UrTrmrNwIYhhNgtMKLoK5hOO3k",
    projectId: "flashchat-5e1bf",
    messagingSenderId: "22590683575",
    appId: "1:22590683575:web:f37f533f2f9a5028109032",
  ));
  return runApp(FlashChat());
}

class FlashChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: WelcomeScreen.id,
        routes: {
          WelcomeScreen.id: (context) => WelcomeScreen(),
          LoginScreen.id: (context) => LoginScreen(),
          RegistrationScreen.id: (context) => RegistrationScreen(),
          ChatScreen.id: (context) => ChatScreen(),
        });
  }
}
