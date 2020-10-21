import 'dart:async';
import 'dart:convert';
import 'package:doggo/BackgroundNotif.dart';
import 'package:doggo/ForecastComponent.dart';
import 'package:doggo/HotlineListComponent.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/material.dart';
import 'Routes/AddDog.dart';
import 'Routes/NotificationSettings.dart';
import 'Routes/DogProfile.dart';
import 'Routes/FeedingTime.dart';
import 'Routes/VetVisit.dart';
import 'Routes/HotlineLinks.dart';
import 'StringUtils.dart';
import 'WeatherComponent.dart';
import 'checkConditions.dart';
import 'weather.dart';
import 'package:weather_icons/weather_icons.dart';
import 'DogProfileComponent.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'forecast.dart';
import 'package:doggo/DogListComponent.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter/services.dart';
// import 'BackgroundNotif.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:workmanager/workmanager.dart';

void main() {
//   WidgetsFlutterBinding.ensureInitialized();
//   Workmanager.initialize(
//       callbackDispatcher,
//       isInDebugMode: true
//   );
//   // Periodic task registration
//   Workmanager.registerPeriodicTask(
//     "2",
//
//     // returned in callbackDispatcher
//     "simplePeriodicTask",
//
//     // Minimum frequency is 15 min
//     frequency: Duration(minutes: 15),
//   );
  runApp(new MaterialApp(
    title: 'My First DogGo',
    initialRoute: '/',
    routes: {
      '/': (context) => Home(),
      '/NotificationSettings': (context) => NotificationSettings(),
      '/FeedingTime': (context) => FeedingTime(),
      '/VetVisit': (context) => VetVisit(),
      '/HotlineLinks': (context) => HotlineLinks(),
    },
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
  ));
}

// Notification config
// void callbackDispatcher() {
//   Workmanager.executeTask((task, inputData) {
//
//     // initialise the plugin of flutterlocalnotifications.
//     FlutterLocalNotificationsPlugin flip = new FlutterLocalNotificationsPlugin();
//
//     // app_icon needs to be a added as a drawable
//     // resource to the Android head project.
//     var android = new AndroidInitializationSettings('@mipmap/ic_launcher');
//     var IOS = new IOSInitializationSettings();
//
//     // initialise settings for both Android and iOS device.
//     var settings = new InitializationSettings(android, IOS);
//     flip.initialize(settings);
//     _showNotificationWithDefaultSound(flip);
//     return Future.value(true);
//   });
// }
//
// Future _showNotificationWithDefaultSound(flip) async {
//
//   // Show a notification after every 15 minute with the first
//   // appearance happening a minute after invoking the method
//   var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
//       ' ',
//       importance: Importance.Max,
//       priority: Priority.High
//   );
//   var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
//
//   // initialise channel platform for both Android and iOS device.
//   var platformChannelSpecifics = new NotificationDetails(
//       androidPlatformChannelSpecifics,
//       iOSPlatformChannelSpecifics
//   );
//   await flip.show(0, 'Dog waiting for you',
//       'You must walk your dog now',
//       platformChannelSpecifics, payload: 'Default_Sound'
//   );
// }

// Returns a list of string from +=2 from current hour and current hour, starting from -2 to +2
List<String> UpdateHourArray() {
  print("Updating hour array");
  DateFormat dateFormat = DateFormat("yyyy-MM-dd");
  String current_day = dateFormat.format(DateTime.now()) + 'T';

  var now = new DateTime.now();
  int current_hour = now.hour;

  int hour_back1 = current_hour - 1;
  String hour_back1_s = toHourString(hour_back1);

  int hour_back2 = current_hour - 2;
  String hour_back2_s = toHourString(hour_back2);

  int hour_forward1 = current_hour + 1;
  String hour_forward1_s = toHourString(hour_forward1);

  int hour_forward2 = current_hour + 2;
  String hour_forward2_s = toHourString(hour_forward2);

  return [
    current_day + hour_back2_s,
    current_day + hour_back1_s,
    current_day + toHourString(current_hour),
    current_day + hour_forward1_s,
    current_day + hour_forward2_s
  ];
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
  // State<StatefulWidget> createState2() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentHour = DateTime.now().hour;
  List<String> hoursArray = [];

  DogProfile dogProfile = new DogProfile();

  @override
  void initState() {
    super.initState();
    hoursArray = UpdateHourArray();
  }

  Future<List<String>> GoToAddDog(BuildContext context) async{
    List<String> result =await Navigator.push(context,MaterialPageRoute(builder: (context) => AddDog()));
    dogProfile.addToDogList(result);
  }

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    Widget addbutton=  FloatingActionButton(
      onPressed: ()  {
        setState((){
          GoToAddDog(context);
        });
      },
      child:
      Icon(
        Icons.add,
        size: 30,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50.0),
      ),
    );

    // Widget Weather Section
    Color color = Theme.of(context).primaryColor;

    WeatherWidget weatherWidget = WeatherWidget(hoursArray);
    // weatherWidget.setHoursArray(hoursArray);

    ForecastWidget forecastWidget = ForecastWidget(hoursArray);
    // forecastWidget.setHoursArray(hoursArray);

    // Widget Should I walk my dog detail
    Widget walkDogSection = Container(
        child: Center(
          child: Text("TEST"),
        ),
    );

    // Widget useful links
    Widget usefulLinkSection = Container(
        height: 80,
        child: Column(
          children: [
            Align(alignment: Alignment.topCenter, child: Text('Useful links')),
            Expanded(child: fetchHotlineList().run(),)
          ],
        ));

    void _onRefresh() async{
      UpdateHourArray();
      setState(() {

      });
      // monitor network fetch
      await Future.delayed(Duration(milliseconds: 1000));
      // if failed,use refreshFailed()
      _refreshController.refreshCompleted();
    }

    void _onLoading() async{
      // monitor network fetch
      await Future.delayed(Duration(milliseconds: 1000));
      // if failed,use loadFailed(),if no data return,use LoadNodata()
      if(mounted)
        setState(() {
        });
      _refreshController.loadComplete();
    }

    // var test = new BackgroundNotif().init();

    return Scaffold(
      appBar: AppBar(
        title: Text('My First DogGo'),
        actions: [
          IconButton(
            icon: Icon(
              Icons.refresh,
              color: Colors.white,
            ),
            iconSize: 35,
            onPressed: () {
              UpdateHourArray();
              setState(() {
                fetchDogList().getSPlist();
                fetchHotlineList().getSPlist();
              });
            },
          ),
        ],
      ),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        'Settings',
                        style: TextStyle(fontSize: 25, color: Colors.white),
                      ),
                    ),
                  ],
                )),
            ListTile(
              title: Text('Notification Settings'),
              onTap: () {
                // Update the state of the app.
                Navigator.pushNamed(context, '/NotificationSettings');
                // ...
              },
            ),
            // ListTile(
            //   title: Text('Dog Profile'),
            //   onTap: () {
            //     // Update the state of the app.
            //     Navigator.pushNamed(context, '/DogProfile');
            //     // ...
            //   },
            // ),
            ListTile(
              title: Text('Feeding Times'),
              onTap: () {
                // Update the state of the app.
                Navigator.pushNamed(context, '/FeedingTime');
                // ...
              },
            ),
            ListTile(
              title: Text('Vet Visits'),
              onTap: () {
                // Update the state of the app.
                Navigator.pushNamed(context, '/VetVisit');
                // ...
              },
            ),
            ListTile(
              title: Text('Hotline and Links'),
              onTap: () {
                // Update the state of the app.
                Navigator.pushNamed(context, '/HotlineLinks');
                // ...
              },
            ),
          ],
        ),
      ),
      body: SmartRefresher(
        enablePullDown: true,
        enablePullUp: false,
        header: WaterDropHeader(),
        footer: CustomFooter(
          builder: (BuildContext context, LoadStatus mode) {
            Widget body;
            if (mode == LoadStatus.idle) {
              body = Text("pull up load");
            } else if (mode == LoadStatus.loading) {
              body = CupertinoActivityIndicator();
            } else if (mode == LoadStatus.failed) {
              body = Text("Load Failed!Click retry!");
            } else if (mode == LoadStatus.canLoading) {
              body = Text("release to load more");
            } else {
              body = Text("No more Data");
            }
            return Container(
              height: 55.0,
              child: Center(child: body),
            );
          },
        ),
        controller: _refreshController,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        child: Container(
            child: Column(
          children: [
            // const SizedBox(height: 20),
              forecastWidget,
              // const SizedBox(height: 20),
              weatherWidget,
              const SizedBox(height: 20),
              walkDogSection,
              const SizedBox(height: 10),
              // fetchDogList().run(),
              dogProfile,

              // const SizedBox(height: 15),
              // Align(alignment: Alignment.topCenter, child: Text('Useful links')),
              // const SizedBox(height: 10),
              // fetchHotlineList().run()
          ],
        )),
      ),
        floatingActionButton: Container(
          height: 65.0,
          width: 65.0,
          child: FittedBox(
              child:addbutton),
        ),
    );
  }
}
