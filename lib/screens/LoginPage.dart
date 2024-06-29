import 'package:flutter/material.dart';

class UserLogin extends StatelessWidget {
  final mobileController = TextEditingController();
  final passwordController = TextEditingController();
  final ValueNotifier<bool> passToggle = ValueNotifier<bool>(true);

  UserLogin({super.key});

  @override
  void dispose() {
    mobileController.dispose();
    passwordController.dispose();
    passToggle.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: size.height * 0.1),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.person, size: 75.0),
                ],
              ),
              SizedBox(height: size.height * 0.02),
              const Text(
                'LOGIN',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 60,
                  color: Colors.black,
                ),
              ),
              const Text(
                'Please use accurate credentials',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),
              Form(
                child: Column(
                  children: [
                    SizedBox(height: size.height * 0.05),
                    TextFormField(
                      keyboardType: TextInputType.phone,
                      controller: mobileController,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.phone),
                        labelText: 'Mobile Number',
                        hintText: 'Enter your mobile number',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        ),
                      ),
                    ),
                    SizedBox(height: size.height * 0.03),
                    ValueListenableBuilder<bool>(
                      valueListenable: passToggle,
                      builder: (context, isObscured, child) {
                        return TextFormField(
                          obscureText: isObscured,
                          keyboardType: TextInputType.visiblePassword,
                          controller: passwordController,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.lock_outline),
                            labelText: 'Password',
                            hintText: 'Enter your password',
                            border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(20.0)),
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(isObscured ? Icons.visibility_off : Icons.visibility),
                              onPressed: () {
                                passToggle.value = !isObscured;
                              },
                            ),
                          ),
                        );
                      },
                    ),
                    SizedBox(height: size.height * 0.03),
                    Align(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        onTap: () {},
                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(fontSize: 16, color: Colors.blue),
                        ),
                      ),
                    ),
                    SizedBox(height: size.height * 0.1),
                    SizedBox(
                      width: size.width * 0.5,
                      height: size.height * 0.07,
                      child: ElevatedButton(
                        onPressed: () {
                          _handleUserSignIn(context);
                        },
                        child: const Text('LOGIN'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleUserSignIn(BuildContext context) {
    // Navigate to User Home Page
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => UserHomePage(),
      ),
    );
  }
}

class UserHomePage extends StatelessWidget {
  const UserHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Home Page'),
      ),
      body: const Center(
        child: Text('Welcome to User Home Page'),
      ),
    );
  }
}
