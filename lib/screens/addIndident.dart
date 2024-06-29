import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class AddIncident extends StatefulWidget {
  final Map<dynamic, dynamic> users;

  const AddIncident({Key? key, required this.users}) : super(key: key);

  @override
  State<AddIncident> createState() => _AddIncidentState();
}

class _AddIncidentState extends State<AddIncident> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _typeController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final DatabaseReference _database = FirebaseDatabase.instance.ref();

  bool isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _typeController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  Future<void> reportIncident() async {
    if (_nameController.text.isEmpty ||
        _typeController.text.isEmpty ||
        _locationController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill all fields'),
        ),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      String incidentName = _nameController.text;
      String incidentType = _typeController.text;
      String incidentLocation = _locationController.text;
var mobileNumber= widget.users['Mobile Number'];
      await _database.child('incidents').child(mobileNumber+incidentName).set({
        'name': incidentName,
        'type': incidentType,
        'location': incidentLocation,
        'reportedBy': widget.users['Name'],
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Incident reported successfully!'),
        ),
      );

      // Clear the form fields after submission
      _nameController.clear();
      _typeController.clear();
      _locationController.clear();
    } catch (error) {
      print('Error reporting incident: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error reporting incident. Please try again.'),
        ),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Report Incident',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 20),
              Text('Name: ${widget.users['Name']}'),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Incident Name',
                  hintText: 'Enter the name of the incident',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the incident name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _typeController,
                decoration: const InputDecoration(
                  labelText: 'Incident Type',
                  hintText: 'Enter the type of incident',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the incident type';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _locationController,
                decoration: const InputDecoration(
                  labelText: 'Location',
                  hintText: 'Enter the location of the incident',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the incident location';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: isLoading ? null : reportIncident,
                child: isLoading
                    ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2,
                  ),
                )
                    : const Text('Report Incident'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
