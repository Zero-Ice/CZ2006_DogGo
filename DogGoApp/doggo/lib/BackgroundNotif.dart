import 'package:doggo/checkConditions.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';

var noti = "It's time to walk your dog!";

class BackgroundNotif {
  BackgroundNotif._();

  factory BackgroundNotif() => _instance;

  static final BackgroundNotif _instance = BackgroundNotif._();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  bool _initialized = false;

  Future<void> init() async {
    if (!_initialized) {
      // ios (later)
      _firebaseMessaging.requestNotificationPermissions();
      _firebaseMessaging.configure();

      // debug
      String token = await _firebaseMessaging.getToken();
      print("FirebaseMessaging token: $token");

      _initialized = true;
    }
  }
}

// void BackgroundNotif() {
//   if(checkConditions()) {
//     final fbm = FirebaseMessaging();
//     fbm.requestNotificationPermissions();
//   }
// }