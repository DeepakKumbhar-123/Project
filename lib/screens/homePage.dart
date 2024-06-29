import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final Map<dynamic, dynamic> users;

  const HomePage({Key? key, required this.users}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Retrieve the name of the user from the 'users' map
    String userName = users['Name'] ?? 'User';

    return Scaffold(
      body: Text(
          "Hello $userName",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),

    );
  }
}
