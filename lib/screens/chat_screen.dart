import 'dart:js_interop';

import 'package:flutter/material.dart';
import 'package:flash_chat_flutter/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/rendering.dart';

final _firestore = FirebaseFirestore.instance;
User? logInuser;

class ChatScreen extends StatefulWidget {
  static const String id = "chat_screen";
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messagetextcontroller = TextEditingController();
  final _auth = FirebaseAuth.instance;
  
  String? messageText;
  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        logInuser = user;
//print(logInuser!.email);
      }
    } catch (e) {
      print(e);
    }
  }
//  void getMessage() async {
//   // Retrieve data
//   final messages = await _firestore.collection('messages').get();
//   for (var message in messages.docs) {
//     print(message.data());
//   }
// }

  // void messageStream() async {
  //   // Stream of messages collection
  //   await for (var snapshot in _firestore.collection('messages').snapshots()) {
  //     for (var message in snapshot.docs) {
  //       print(message.data());
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                //    getMessage();
              //  messageStream();
                //Implement logout functionality
                 _auth.signOut();
                 Navigator.pop(context);
              }),
        ],
        title: const Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            MessageStream(firestore: _firestore),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: messagetextcontroller,
                      onChanged: (value) {
                        //Do something with the user input.
                        messageText = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      //Implement send functionality.
                      messagetextcontroller.clear();
                      _firestore.collection('messages').doc(DateTime.now().toString()).set({
                        //  _firestore.collection('messages').add({
                        'text': messageText,
                        'sender': logInuser!.email,
                      });
                    },
                    child: const Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessageStream extends StatelessWidget {
  const MessageStream({
    super.key,
    required FirebaseFirestore firestore,
  }) : _firestore = firestore;

  final FirebaseFirestore _firestore;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('messages').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
                child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlueAccent,
            ));
          }
          final messages = snapshot.data!.docs.reversed;//reverse ky liye
          List<Messagebubble> messageBubbles = [];
          for (QueryDocumentSnapshot message in messages) {
            final messageText = message['text'];
            final messageSender = message['sender'];
            final currentUser = logInuser?.email.toString();
          //  print(currentUser);
           
            final messageBubble = Messagebubble(
                text: messageText,
                sender: messageSender,
                isMe: currentUser == messageSender);

            messageBubbles.add(messageBubble);
          }
          return Expanded(
            child: ListView(
              reverse: true,
              padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
              children: messageBubbles,
            ),
          );
        });
  }
}

class Messagebubble extends StatelessWidget {
  Messagebubble({this.sender, this.text, required this.isMe});
  final String? text;
  final String? sender;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: isMe? CrossAxisAlignment.end:CrossAxisAlignment.start,
        children: [
          Text('$sender',
              style: const TextStyle(fontSize: 12.0, color: Colors.black54)),
          Material(
            elevation: 5.0,
            borderRadius:  isMe? const BorderRadius.only(
                bottomLeft: Radius.circular(30.0),
                topLeft: Radius.circular(30.0),
                bottomRight: Radius.circular(30.0)):const BorderRadius.only(
                bottomLeft: Radius.circular(30.0),
                
                bottomRight: Radius.circular(30.0),topRight: Radius.circular(30.0)),
            color: isMe ? Colors.blueAccent : Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Text(
                '$text',
                style: TextStyle(fontSize: 15.0, 
                color:
                isMe? Colors.white:Colors.black54),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
