import 'dart:ffi';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:doggo/DogCreationClass.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:convert';

class NotificationSettings extends StatefulWidget {
  @override
  _NotificationSettingsState createState() => _NotificationSettingsState();
}

class _NotificationSettingsState extends State<NotificationSettings> {
  FlutterLocalNotificationsPlugin notif;
  SharedPreferences prefs;
  List<DogCreation> dogsList = List<DogCreation>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var andrNoti = new AndroidInitializationSettings('doggo_notif_icon');
    var initSetting = new InitializationSettings(android: andrNoti);
    notif = new FlutterLocalNotificationsPlugin();
    notif.initialize(initSetting);
    tz.initializeTimeZones();
    initSP();

  }

  void initSP() async {
    prefs = await SharedPreferences.getInstance();
    loadData();
  }

  void loadData() {
    List<String> spList = prefs.getStringList("dogData");
    dogsList =
        spList.map((index) => DogCreation.fromMap(json.decode(index))).toList();
    setState(() {});

  }

  Future<void> _scheduledNotif() async{
    var androidDets = new AndroidNotificationDetails("DoggoApp", "My First DogGo", "channelDescription",importance: Importance.max);
    var genDet = new NotificationDetails(android: androidDets);
    var timeToShow = DateTime.now().add(Duration(seconds: 5));
    var time= tz.TZDateTime.now(tz.local).add(Duration(seconds: 5));

    print("notif bef");
    await notif.zonedSchedule(0, "title", "body", time, genDet, uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime, androidAllowWhileIdle: true);
    print("notif ret");


  }




  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: Text("Notification Settings"),
      ),
      body: Center(
        child: Row(
          children: [
            RaisedButton(
              onPressed: () {
                // Navigate back to first screen when tapped.
                Navigator.pop(context);
              },
              child: Text('Go back!'),
            ),
            RaisedButton(
              onPressed: _scheduledNotif,
              child: Text('Click Me!'),
            )
          ],
        ),
      ),
    );


  }

}
