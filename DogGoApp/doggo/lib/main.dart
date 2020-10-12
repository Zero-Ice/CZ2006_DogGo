import 'dart:async';
import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/material.dart';
import 'Routes/NotificationSettings.dart';
import 'Routes/DogProfile.dart';
import 'Routes/FeedingTime.dart';
import 'Routes/VetVisit.dart';
import 'Routes/HotlineLinks.dart';
import 'weather.dart';
import 'package:weather_icons/weather_icons.dart';
import 'DogProfileComponent.dart';

void main() {
  runApp(new MaterialApp(
    title: 'Fetch weather test',
    initialRoute: '/',
    routes: {
      '/': (context) => Home(),
      '/NotificationSettings': (context) => NotificationSettings(),
      '/DogProfile': (context) => DogProfile(),
      '/FeedingTime': (context) => FeedingTime(),
      '/VetVisit': (context) => VetVisit(),
      '/HotlineLinks': (context) => HotlineLinks(),
    },
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
  ));
}
//
String toHourString(int hour) {
  if (hour < 10) {
    return "0" + hour.toString() + ":00";
  }
  return hour.toString() + ":00";
}

class Home extends StatelessWidget {
  @override
  Future<Weather> futureWeather = fetchWeather();

  Widget build(BuildContext context) {
    // Widget Weather Section
    Color color = Theme.of(context).primaryColor;
    int currentHour = DateTime.now().hour;

    // String tempLabel pretty redundant as we get the data from our builder
    // TODO: Remove the tempLabel
    Widget _buildWeatherInfoColumn(
        Color color, IconData icon, String timeLabel, String tempLabel) {
      return FutureBuilder<Weather>(
          future: futureWeather,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              String returnData = snapshot.data.metadata.stations[0].name +
                  " Temperature : " +
                  snapshot.data.items[0].readings[0].value.toString() +
                  "C";
              String temperatureString =
                  snapshot.data.items[0].readings[0].value.toString() + "C";
              return Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BoxedIcon(WeatherIcons.day_sunny
                      // Package https://pub.dev/packages/weather_icons
                      // Dynamic weather
                      // WeatherIcons.fromString(
                      //     weatherCode,
                      //     // Fallback is optional, throws if not found, and not supplied.
                      //     fallback: WeatherIcons.na
                      // ),
                      ),
                  Container(
                    margin: const EdgeInsets.only(top: 8),
                    child: Text(
                      timeLabel,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: color,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 8),
                    child: Text(
                      temperatureString,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: color,
                      ),
                    ),
                  ),
                ],
              );
              //return Text(returnData);
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }

            // By default, show a loading spinner.
            return CircularProgressIndicator();
          });
    }

    Widget weatherSection = Container(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildWeatherInfoColumn(
            color, Icons.star, toHourString(currentHour - 2), '26C'),
        _buildWeatherInfoColumn(
            color, Icons.star, toHourString(currentHour - 1), '28C'),
        _buildWeatherInfoColumn(color, Icons.star, "now", '29C'),
        _buildWeatherInfoColumn(
            color, Icons.star, toHourString(currentHour + 1), '26C'),
        _buildWeatherInfoColumn(
            color, Icons.star, toHourString(currentHour + 2), '27C'),
      ],
    ));

    // Widget Should I walk my dog button
    Widget walkDogSection = Container(
        child: RaisedButton(
      onPressed: () {},
      child: Text('Should I walk my dog?', style: TextStyle(fontSize: 20)),
    ));

    // Widget useful links
    Widget usefulLinkSection = Container(
      height: 80,
        child: Column(
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: Text('Useful links')),
        Text('ASDF'),
        Text('DSGSDG'),
      ],
    ));

    return Scaffold(
      appBar: AppBar(
        title: Text('My First DogGo'),
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
              child: Text('Settings'),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text('Notification Settings'),
              onTap: () {
                // Update the state of the app.
                Navigator.pushNamed(context, '/NotificationSettings');
                // ...
              },
            ),
            ListTile(
              title: Text('Dog Profile'),
              onTap: () {
                // Update the state of the app.
                Navigator.pushNamed(context, '/DogProfile');
                // ...
              },
            ),
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
      body: Container(
          child: Column(
        children: [
          const SizedBox(height: 20),
          weatherSection,
          const SizedBox(height: 20),
          walkDogSection,
          const SizedBox(height: 10),
          dogProfileComponent,
          const SizedBox(height: 20),
          Align(
            alignment: Alignment.bottomCenter,
            child:Padding(
              padding: const EdgeInsets.all(8.0),
              child: usefulLinkSection,
            ),
          )
        ],
      )),
    );
  }
}
