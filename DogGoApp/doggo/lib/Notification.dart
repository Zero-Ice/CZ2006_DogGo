import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/material.dart';

FlutterLocalNotificationsPlugin notif;

void init() {
  var andrNoti = new AndroidInitializationSettings('doggo_notif_icon');
  var initSetting = new InitializationSettings(android: andrNoti);
  notif = new FlutterLocalNotificationsPlugin();
  notif.initialize(initSetting);
  tz.initializeTimeZones();
  tz.setLocalLocation(tz.getLocation('Asia/Singapore'));
}

Future<void> scheduleNotification(
    String title, String body, tz.TZDateTime timeToShowNotif) async {
  var androidDets = new AndroidNotificationDetails(
      "DoggoApp", "My First DogGo", "channelDescription",
      importance: Importance.max);
  var genDet = new NotificationDetails(android: androidDets);
  var timeToShow = DateTime.now().add(Duration(seconds: 5));
  var time = tz.TZDateTime.now(tz.local).add(Duration(seconds: 5));

  await notif.zonedSchedule(0, title, body, time, genDet,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      payload: time.toString());

  // final List<PendingNotificationRequest> pendingNotificationRequests =
  // await notif.pendingNotificationRequests();
  // print("PENDING NOTIF SIZE: " + pendingNotificationRequests.length.toString());
  // if(pendingNotificationRequests != null && pendingNotificationRequests.length > 0) {
  //   print(pendingNotificationRequests[0].payload);
  // }
}
