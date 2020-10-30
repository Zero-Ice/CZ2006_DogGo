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
    int id, String dogName, tz.TZDateTime timeToShowNotif) async {
  final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
  var androidDets = new AndroidNotificationDetails(
      "DoggoApp", "My First DogGo", "channelDescription",
      importance: Importance.max);
  var genDet = new NotificationDetails(android: androidDets);
  // var timeToShow = DateTime.now().add(Duration(seconds: 5));
  // var time = tz.TZDateTime.now(tz.local).add(Duration(seconds: 5));
  tz.TZDateTime twoHoursBefore = timeToShowNotif.subtract(const Duration(hours: 2));
  String title = "Vet Appointment";
  String time = formatTime(timeToShowNotif);
  String msg1 = "$dogName's vet visit today at $time";
  String msg2 = "$dogName's vet visit now at $time";
  try{
    await notif.zonedSchedule(id+1, title, msg1, twoHoursBefore.toLocal(), genDet,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
        payload: twoHoursBefore.toString());
  }
  catch (e){
    print(e);
  }

  await notif.zonedSchedule(id+2, title, msg2, timeToShowNotif.toLocal(), genDet,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
      UILocalNotificationDateInterpretation.absoluteTime,
      payload: timeToShowNotif.toString());
  //pendingNotificationRequests();
  // final List<PendingNotificationRequest> pendingNotificationRequests =
  // await notif.pendingNotificationRequests();
  // print("PENDING NOTIF SIZE: " + pendingNotificationRequests.length.toString());
  // if(pendingNotificationRequests != null && pendingNotificationRequests.length > 0) {
  //   print(pendingNotificationRequests[0].payload);
  // }

}

Future<void> scheduleDailyNotification(
    int id, String title, String body1, String body2, tz.TZDateTime t1, tz.TZDateTime t2) async {
  var androidDets = new AndroidNotificationDetails(
      "DoggoApp", "My First DogGo", "channelDescription",
      importance: Importance.max);
  var genDet = new NotificationDetails(android: androidDets);

  await notif.zonedSchedule(id+1, title, body1, t1.toLocal(), genDet,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
      UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time, //daily
      payload: t1.toString());

  await notif.zonedSchedule(id+2, title, body2, t2.toLocal(), genDet,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
      UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
      payload: t2.toString());
}
Future<void> pendingNotificationRequests() async{
  List<PendingNotificationRequest> requestList = await notif.pendingNotificationRequests();
  for (int i = 0; i< requestList.length; i++){
    print("upcoming noti:");
    print(requestList[i].payload);
  }
}

Future<void> cancelNoti(int id) async {
  await notif.cancel(id+1);
  await notif.cancel(id+2);
}

String formatTime(tz.TZDateTime dt){
  var hour, minute;
  hour = dt.hour;
  minute = dt.minute;
  if (hour < 10) hour = hour.toString().padLeft(2, '0');
  if (minute <= 9) minute = minute.toString().padLeft(2, '0');
  return "$hour:$minute";
}


