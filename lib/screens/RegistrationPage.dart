
import 'package:flutter/material.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:my_app/regDone.dart';

class Registration extends StatefulWidget {
  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  int currentStep = 0;
  bool isLoading = false;

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  // final databaseRef = FirebaseDatabase.instance.ref('Users');

  Future<void> registerUser() async {
    setState(() {
      isLoading = true;
    });

    // Simulate registration process
    await Future.delayed(Duration(seconds: 2));

    // Navigate to registration done page
    // Navigator.pushReplacement(
    //   context,
    //   MaterialPageRoute(builder: (context) => RegDone()),
    // );

    setState(() {
      isLoading = false;
    });
  }

  List<Step> stepList() => [
    Step(
      isActive: currentStep >= 0,
      title: const Text('Personal Info'),
      content: Column(
        children: [
          TextField(
            controller: firstNameController,
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'First Name',
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: lastNameController,
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Last Name',
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: mobileController,
            keyboardType: TextInputType.phone,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Mobile Number',
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: passwordController,
            obscureText: true,
            keyboardType: TextInputType.visiblePassword,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Password',
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: confirmPasswordController,
            obscureText: true,
            keyboardType: TextInputType.visiblePassword,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Confirm Password',
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              if (firstNameController.text.isEmpty ||
                  lastNameController.text.isEmpty ||
                  mobileController.text.isEmpty ||
                  passwordController.text.isEmpty ||
                  confirmPasswordController.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Please fill all fields correctly'),
                    duration: Duration(seconds: 2),
                  ),
                );
                return;
              }

              if (passwordController.text != confirmPasswordController.text) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Passwords do not match'),
                    duration: Duration(seconds: 2),
                  ),
                );
                return;
              }

              if (!isLoading) {
                registerUser();
              }
            },
            child: isLoading
                ? SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 2,
              ),
            )
                : const Text('Submit'),
          ),
        ],
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User Registration"),
      ),
      body: Stepper(
        type: StepperType.vertical,
        steps: stepList(),
        currentStep: currentStep,
        onStepContinue: () {
          final isLastStep = currentStep == stepList().length - 1;
          if (isLastStep) {
            print('COMPLETED');
          } else {
            setState(() => currentStep += 1);
          }
        },
        onStepCancel: () {
          if (currentStep > 0) {
            setState(() => currentStep -= 1);
          }
        },
      ),
    );
  }
}
