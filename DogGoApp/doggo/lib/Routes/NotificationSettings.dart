import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationSettings extends StatefulWidget {
  @override
  _NotificationSettingsState createState() => _NotificationSettingsState();
}

class _NotificationSettingsState extends State<NotificationSettings> {
  FlutterLocalNotificationsPlugin notif;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var andrNoti = new AndroidInitializationSettings('doggo_notif_icon');
    var initSetting = new InitializationSettings(android: andrNoti);
    notif = new FlutterLocalNotificationsPlugin();
    notif.initialize(initSetting, onSelectNotification: doThis);

  }

  Future _showNotif() async{
    var androidDets = new AndroidNotificationDetails("channelId", "doggo", "channelDescription",importance: Importance.max);
    var genDet = new NotificationDetails(android: androidDets);
    print("notif bef");
    await notif.show(0, "title", "body", genDet);
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
              onPressed: _showNotif,
              child: Text('Click Me!'),
            )
          ],
        ),
      ),
    );
  }

  Future doThis(String stuff) async{

  }
}
