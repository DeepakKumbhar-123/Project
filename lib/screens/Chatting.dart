import 'package:alertify/screens/ChatsAll.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart'; // Firebase Realtime Database

class Chatting extends StatefulWidget {
  final Map<dynamic, dynamic> users;

  const Chatting({Key? key, required this.users}) : super(key: key);

  @override
  State<Chatting> createState() => _ChattingState();
}

class _ChattingState extends State<Chatting> {
  final TextEditingController _messageController = TextEditingController();
  final DatabaseReference _database = FirebaseDatabase.instance.ref(); // Database reference

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  void _sendMessage(String message) {
    // Handle sending message logic here
    if (message.isNotEmpty) {
      // Assuming users map contains mobileNumber as a key for identification
      String mobileNumber = widget.users['Mobile Number'];
String name= widget.users['Name'];
var time= DateTime.now().millisecondsSinceEpoch.toString();
      // Push message to Firebase Realtime Database under 'chatts' node with mobileNumber as key
      _database.child('chatts').child(mobileNumber+time).set({
        'Name': name,
        'Mobile Number': mobileNumber,
        'message': message,
        'timestamp': DateTime.now().millisecondsSinceEpoch, // Timestamp for sorting
      }).then((_) {
        print('Message sent to Firebase: $message');
        _messageController.clear(); // Clear text field after sending
      }).catchError((error) {
        print('Failed to send message: $error');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            Text("Hello ${widget.users['Name']} 👋️", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),

          ],
        ),

      ),
      body: ChatsAll(users: widget.users),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _messageController,
                  decoration: InputDecoration(hintText: 'Type a message...'),
                ),
              ),
              IconButton(
                icon: Icon(Icons.send),
                onPressed: () {
                  _sendMessage(_messageController.text);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
