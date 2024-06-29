import 'package:flutter/material.dart';

class AddIncident extends StatefulWidget {
  final Map<dynamic, dynamic> users;


  const AddIncident({Key? key, required this.users});

  @override
  State<AddIncident> createState() => _AddIncidentState();
}

class _AddIncidentState extends State<AddIncident> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _typeController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _typeController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Report Incident'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(widget.users['Name']),
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
              SizedBox(height: 20),
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
              SizedBox(height: 20),
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
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Validate the form inputs
                  if (_nameController.text.isEmpty ||
                      _typeController.text.isEmpty ||
                      _locationController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please fill all fields'),
                      ),
                    );
                  } else {
                    // Process the incident report logic here
                    String incidentName = _nameController.text;
                    String incidentType = _typeController.text;
                    String incidentLocation = _locationController.text;

                    // Print or process the data as needed
                    print('Incident Name: $incidentName');
                    print('Incident Type: $incidentType');
                    print('Incident Location: $incidentLocation');

                    // Optionally, you can clear the form fields after submission
                    _nameController.clear();
                    _typeController.clear();
                    _locationController.clear();

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Incident reported successfully!'),
                      ),
                    );
                  }
                },
                child: const Text('Report Incident'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
