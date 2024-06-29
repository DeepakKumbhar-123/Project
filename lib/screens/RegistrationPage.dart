import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

import 'LoginPage.dart'; // Replace with your actual LoginPage import

class RegPage extends StatefulWidget {
  const RegPage({Key? key}) : super(key: key);

  @override
  State<RegPage> createState() => _RegPageState();
}

class _RegPageState extends State<RegPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final DatabaseReference _database = FirebaseDatabase.instance.ref();

  bool _isRegistering = false; // State variable for tracking registration progress

  @override
  void dispose() {
    nameController.dispose();
    mobileController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> registerUser() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isRegistering = true; // Start showing progress indicator
      });

      try {
        String mobileNumber = mobileController.text;
        await _database.child('users').child(mobileNumber).set({
          'Name': nameController.text.toUpperCase(),
          'Mobile Number': mobileController.text,
          'password': passwordController.text,
          // Add more fields as needed
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('User registered successfully!'),
            duration: Duration(seconds: 2),
          ),
        );

        Navigator.of(context).pushReplacement(
          MaterialPageRoute<LoginPage>(
            builder: (BuildContext context) {
              return LoginPage(); // Replace with your LoginPage route
            },
          ),
        );
        // Optionally, navigate to the next screen or show a success message
      } catch (error) {
        print('Error registering user: $error');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Error registering user. Please try again.'),
            duration: Duration(seconds: 2),
          ),
        );
      } finally {
        setState(() {
          _isRegistering = false; // Hide progress indicator
        });
      }
    }
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
          title: const Text('Register Here'),
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
                  child: Column(
                    children: [
                      TextFormField(
                        controller: nameController,
                        decoration: const InputDecoration(labelText: 'Name'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 15),
                      TextFormField(
                        controller: mobileController,
                        decoration: const InputDecoration(
                            labelText: 'Mobile Number'),
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your mobile number';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 15),
                      TextFormField(
                        controller: passwordController,
                        decoration: const InputDecoration(labelText: 'Password'),
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 15),
                      TextFormField(
                        controller: confirmPasswordController,
                        decoration: const InputDecoration(
                            labelText: 'Confirm Password'),
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please confirm your password';
                          }
                          if (value != passwordController.text) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 25),
                      _isRegistering
                          ? CircularProgressIndicator() // Show progress indicator
                          : ElevatedButton(
                        onPressed: registerUser,
                        child: const Text('Register'),
                      ),
                      SizedBox(height: 20,),
                      Row(
                        children: [
                          Text("Already have an Account ? "),
                          InkWell(
                              onTap: (){
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute<LoginPage>(
                                    builder: (BuildContext context) {
                                      return LoginPage(); // Replace with your LoginPage route
                                    },
                                  ),
                                );
                              },
                              child: Text("Login"))
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
    );
  }
}
