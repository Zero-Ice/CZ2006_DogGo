import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';

class NotificationCaller{
  FlutterLocalNotificationsPlugin notif;
  final BehaviorSubject<RecievedNotif> recievedLocalNotif = BehaviorSubject<RecievedNotif>();
  var initSetting;

  NotificationCaller(){
    init();
  }

  init() async{
    var andrNoti = new AndroidInitializationSettings('doggo_notif_icon');
    initSetting = new InitializationSettings(android: andrNoti);
    notif = new FlutterLocalNotificationsPlugin();
  }

  setOnNotifClick(Function onNotificationClick) async{
    notif.initialize(initSetting,
        onSelectNotification: (String payload) async{
          onNotificationClick(payload);
        });
  }

  setListenerForLowerVersions(Function onNotficationsInLowerVersions){

  }


}

class RecievedNotif{
  final int id;
  final String title;
  final String body;
  final String payload;

  RecievedNotif({
   @required this.id,
    @required this.title,
    @required this.body,
    @required this.payload,
  });

}