import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class HomePage extends StatefulWidget {
  final Map<dynamic, dynamic> users;

  const HomePage({Key? key, required this.users}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final DatabaseReference _database = FirebaseDatabase.instance.ref().child('incidents');
  List<Map<dynamic, dynamic>> _incidents = [];

  @override
  void initState() {
    super.initState();
    _fetchIncidents();
  }

  Future<void> _fetchIncidents() async {
    _database.onValue.listen((event) {
      if (event.snapshot.value != null) {
        Map<dynamic, dynamic> incidentsMap = event.snapshot.value as Map<dynamic, dynamic>;
        List<Map<dynamic, dynamic>> incidentsList = incidentsMap.entries.map((e) => e.value as Map<dynamic, dynamic>).toList();

        setState(() {
          _incidents = incidentsList;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Retrieve the name of the user from the 'users' map
    String userName = widget.users['Name'] ?? 'User';

    return Scaffold(
      appBar: AppBar(
        title: Text("Hello $userName 👋️ ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),),
      ),
      body: _incidents.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: _incidents.length,
        itemBuilder: (context, index) {
          Map<dynamic, dynamic> incident = _incidents[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 4,
              child: ListTile(
                title: Text(
                  incident['name'] ?? 'Unnamed Incident',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      incident['type'] ?? 'Unknown Type',
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      'Reported by: ${incident['reportedBy'] ?? 'Unknown'}',
                      style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
