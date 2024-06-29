import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_database/firebase_database.dart';

class AuthService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final DatabaseReference _database = FirebaseDatabase.instance.ref();

  Future<void> saveDeviceToken(String userId) async {
    String? token = await _firebaseMessaging.getToken();
    if (token != null) {
      await _database.child('users').child(userId).update({
        'deviceToken': token,
      });
    }
  }
}


