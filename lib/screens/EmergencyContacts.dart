import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:permission_handler/permission_handler.dart';

class EmergencyContactsPage extends StatelessWidget {
  final Map<String, String> emergencyContacts = {
    'Police': '+91 8850990106',
    'Fire Department': '101',
    'Ambulance': '102',
    'Disaster Management Services': '108',
    'Poison Control': '+91 11-2658-9300',
    'National Emergency Number': '112',
    'Railway Enquiry': '139',
    'Gas Leakage': '1906',
    'Traffic Police': '103',
  };

  // Future<void> _makePhoneCall(String phoneNumber) async {
  //   PermissionStatus status = await Permission.phone.request();
  //
  //   if (status.isGranted) {
  //     final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);
  //     if (await canLaunchUrl(phoneUri)) {
  //       await launchUrl(phoneUri);
  //     } else {
  //       throw 'Could not launch $phoneNumber';
  //     }
  //   } else if (status.isDenied) {
  //     print('Phone permission denied');
  //   } else if (status.isPermanentlyDenied) {
  //     print('Phone permission permanently denied');
  //     await openAppSettings();
  //   }
  // }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri phoneUri = Uri(scheme: 'tel', path: Uri.encodeComponent(phoneNumber));
    try {
      if (await canLaunch(phoneUri.toString())) {
        await launch(phoneUri.toString());
      } else {
        throw 'Could not launch $phoneNumber';
      }
    } catch (e) {
      print('Error launching phone call: $e');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Emergency Contacts'),
      ),
      body: ListView.builder(
        itemCount: emergencyContacts.length,
        itemBuilder: (context, index) {
          String contactName = emergencyContacts.keys.elementAt(index);
          String contactNumber = emergencyContacts[contactName]!;

          return Card(
            margin: EdgeInsets.all(8.0),
            child: ListTile(
              title: Text(contactName),
              subtitle: Text(contactNumber),
              trailing: IconButton(
                icon: Icon(Icons.call),
                onPressed: () => _makePhoneCall(contactNumber),
              ),
            ),
          );
        },
      ),
    );
  }
}

