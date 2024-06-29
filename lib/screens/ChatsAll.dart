import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class ChatsAll extends StatefulWidget {
  final Map<dynamic, dynamic> users;

  const ChatsAll({Key? key, required this.users}) : super(key: key);

  @override
  State<ChatsAll> createState() => _ChatsAllState();
}

class _ChatsAllState extends State<ChatsAll> {
  final DatabaseReference _database = FirebaseDatabase.instance.ref().child('chatts');
  List<Map<dynamic, dynamic>> _chats = [];

  @override
  void initState() {
    super.initState();
    _fetchChats();
  }

  void _fetchChats() {
    _database.onValue.listen((event) {
      if (event.snapshot.value != null) {
        Map<dynamic, dynamic> chatsMap = event.snapshot.value as Map<dynamic, dynamic>;
        List<Map<dynamic, dynamic>> chatsList = chatsMap.entries.map((e) => e.value as Map<dynamic, dynamic>).toList();

        setState(() {
          _chats = chatsList;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    String loggedInUserName = widget.users['Name'] ?? 'User';

    return Scaffold(
      body: _chats.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        reverse: true,
        itemCount: _chats.length,
        itemBuilder: (context, index) {
          Map<dynamic, dynamic> chat = _chats[index];
          String chatUserName = chat['Name'] ?? 'Unknown User';
          bool isCurrentUser = chatUserName == loggedInUserName;
          Color nameColor = isCurrentUser ? Colors.green : Colors.red;

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 4,
              child: ListTile(
                title: Text(
                  chatUserName,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: nameColor,
                  ),
                ),
                subtitle: Text(
                  chat['message'] ?? 'No message',
                  style: TextStyle(fontSize: 14),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
