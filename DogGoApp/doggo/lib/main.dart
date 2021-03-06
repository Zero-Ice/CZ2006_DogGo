import 'dart:async';
import 'dart:convert';
import 'package:doggo/ForecastComponent.dart';
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
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'forecast.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter/services.dart';
import 'package:doggo/Notification.dart' as notification;
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;


void main() {
  runApp(new MaterialApp(
    title: 'My First DogGo',
    initialRoute: '/',
    routes: {
      '/': (context) => Home(),
      '/FeedingTime': (context) => FeedingTime(),
      '/VetVisit': (context) => VetVisit(),
      '/HotlineLinks': (context) => HotlineLinks(),
    },
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
  ));
}

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
    notification.init();
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
        GoToAddDog(context);
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
          child: Text("<Insert dog details>"),
        ),
    );

    void _onRefresh() async{
      UpdateHourArray();
      dogProfile.refresh();
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
        // backgroundColor: Colors.white,
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
              title: Text('Hotlines'),
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
              forecastWidget,
              weatherWidget,
            const Divider(height: 20),
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
