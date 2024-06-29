import 'package:alertify/screens/RegistrationPage.dart';
import 'package:alertify/screens/bottomBar.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:alertify/screens/homePage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final DatabaseReference _database = FirebaseDatabase.instance.reference();
  List<Map<dynamic, dynamic>> _usersList = [];

  @override
  void initState() {
    super.initState();
    _fetchUsers();
  }

  void _fetchUsers() {
    _database.child('users').onValue.listen((event) {
      final data = event.snapshot.value as Map<dynamic, dynamic>;
      final List<Map<dynamic, dynamic>> users = [];
      data.forEach((key, value) {
        users.add({
          'username': key,
          ...value,
        });
      });
      setState(() {
        _usersList = users;
      });
    });
  }

  void loginUser() {
    if (_formKey.currentState!.validate()) {
      String username = usernameController.text;
      String password = passwordController.text;

      // Find user in _usersList
      var user = _usersList.firstWhere(
            (user) => user['Mobile Number'] == username && user['password'] == password,
        orElse: null,
      );

      if (user != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Login Successful'),
          ),
        );

        // Navigate to the next screen after successful login
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => appBottom(users: user,), // Replace with your next screen widget
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Invalid username or password'),
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.person),
              SizedBox(width: 25,),
              Text('Login'),
            ],
          ),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Center(
            child: Container(
              height: size.height,
              width: size.width,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(height: 40,),
                        TextFormField(
                          controller: usernameController,
                          decoration: const InputDecoration(labelText: 'Username'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a username';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 25),
                        TextFormField(
                          controller: passwordController,
                          decoration: const InputDecoration(labelText: 'Password'),
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a password';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 50),
                        ElevatedButton(
                          onPressed: loginUser,
                          child: const Text('Login'),
                        ),
                        SizedBox(height: 30,),
                        Row(
                          children: [
                            Text("Don't have an Account ? "),
                            InkWell(
                              onTap: (){
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute<LoginPage>(
                                    builder: (BuildContext context) {
                                      return RegPage(); // Replace with your LoginPage route
                                    },
                                  ),
                                );
                              },
                                child: Text("SigiUp"))
                          ],
                        ),

                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
