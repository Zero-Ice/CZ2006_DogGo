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
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'weather.dart';
import 'package:intl/intl.dart';



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



DateFormat dateFormat = DateFormat("yyyy-MM-dd");
String current_day = dateFormat.format(DateTime.now())+'T';
DateFormat dateFormat1 = DateFormat("HH");
var now = new DateTime.now();
String current_hour = DateFormat('kk').format(now);


var now1 = new DateTime.now();
var current_hour_1 = now1.add(Duration(days: 0, hours: 1, minutes: 0));
String current_hour_11 = DateFormat('kk').format(now);

var now2 = new DateTime.now();
var current_hour_2 = now2.add(Duration(days: 0, hours: 2, minutes: 0));
String current_hour_22 = DateFormat('kk').format(now);

int hour_back1 = int.parse(current_hour) -1;
String hour_back1_s = "$hour_back1";

int hour_back2 = int.parse(current_hour) -2;
String hour_back2_s = "$hour_back2";

int hour_forward1 = int.parse(current_hour_11);
String hour_forward1_s = "$hour_forward1";

int hour_forward2 = int.parse(current_hour_22);
String hour_forward2_s = "$hour_forward2";

String toHourString(int hour) {
  if (hour < 10) {
    return "0" + hour.toString() + ":00";
  }
  else if(hour>=25)
  {
    return "0" + (hour-24).toString() + ":00";
  }

  return hour.toString() + ":00";
}

// Temperature
Future<Weather> fetchWeather1() async{
  final response=
  await http.get(('https://api.data.gov.sg/v1/environment/air-temperature?date_time='+current_day+hour_back2_s+'%3A45%3A00'));

  if (response.statusCode ==200){
    return Weather.fromJson(json.decode(response.body));
  } else{
    throw Exception('failed to load data');
  }
}

Future<Weather> fetchWeather2() async{
  final response=
  await http.get(('https://api.data.gov.sg/v1/environment/air-temperature?date_time='+current_day+hour_back1_s+'%3A45%3A00'));

  if (response.statusCode ==200){
    return Weather.fromJson(json.decode(response.body));
  } else{
    throw Exception('failed to load data');
  }
}

Future<Weather> fetchWeather3() async{
  final response=
  await http.get(('https://api.data.gov.sg/v1/environment/air-temperature?date_time='+current_day+current_hour+'%3A45%3A00'));

  if (response.statusCode ==200){
    return Weather.fromJson(json.decode(response.body));
  } else{
    throw Exception('failed to load data');
  }
}
Future<Weather> fetchWeather4() async{
  final response=
  await http.get(('https://api.data.gov.sg/v1/environment/air-temperature?date_time='+current_day+hour_forward1_s+'%3A45%3A00'));

  if (response.statusCode ==200){
    return Weather.fromJson(json.decode(response.body));
  } else{
    throw Exception('failed to load data');
  }
}

Future<Weather> fetchWeather5() async{
  final response=
  await http.get(('https://api.data.gov.sg/v1/environment/air-temperature?date_time='+current_day+hour_forward2_s+'%3A45%3A00'));

  if (response.statusCode ==200){
    return Weather.fromJson(json.decode(response.body));
  } else{
    throw Exception('failed to load data');
  }
}


/*
// Forecast
Future<Forecast> forecast1() async{
  final response=
  await http.get(('https://api.data.gov.sg/v1/environment/2-hour-weather-forecast?date='+current_day+hour_back2_s+'%3A45%3A00'));

  if (response.statusCode ==200){
    return Forecast.fromJson(json.decode(response.body));
  } else{
    throw Exception('failed to load data');
  }
}
Future<Forecast> forecast2() async{
  final response=
  await http.get('https://api.data.gov.sg/v1/environment/2-hour-weather-forecast?date='+current_day+hour_back1_s+'%3A45%3A00');

  if (response.statusCode ==200){
    return Forecast.fromJson(json.decode(response.body));
  } else{
    throw Exception('failed to load data');
  }
}
Future<Forecast> forecast3() async{
  final response=
  await http.get('https://api.data.gov.sg/v1/environment/2-hour-weather-forecast?date='+current_day+current_hour+'%3A45%3A00');

  if (response.statusCode ==200){
    return Forecast.fromJson(json.decode(response.body));
  } else{
    throw Exception('failed to load data');
  }
}
Future<Forecast> forecast4() async{
  final response=
  await http.get('https://api.data.gov.sg/v1/environment/2-hour-weather-forecast?date='+current_day+hour_forward1_s+'%3A45%3A00');

  if (response.statusCode ==200){
    return Forecast.fromJson(json.decode(response.body));
  } else{
    throw Exception('failed to load data');
  }
}
Future<Forecast> forecast5() async{
  final response=
  await http.get('https://api.data.gov.sg/v1/environment/2-hour-weather-forecast?date='+current_day+hour_forward2_s+'%3A45%3A00');

  if (response.statusCode ==200){
    return Forecast.fromJson(json.decode(response.body));
  } else{
    throw Exception('failed to load data');
  }
}

*/


class Home extends StatelessWidget {
  @override
  Future<Weather> futureWeather1 = fetchWeather1(); // gets temperature from api
  Future<Weather> futureWeather2 = fetchWeather2();
  Future<Weather> futureWeather3 = fetchWeather3();
  Future<Weather> futureWeather4 = fetchWeather4();
  Future<Weather> futureWeather5 = fetchWeather5();

 /*
  Future<Forecast> forecast1 = forecast1();
  Future<Forecast> forecast2 = forecast2();
  Future<Forecast> forecast3 = forecast3();
  Future<Forecast> forecast4 = forecast4();
  Future<Forecast> forecast5 = forecast5();
  String weathercode1 = snapshot.data[1].ForecastElement.forecast.toString();// The current weather
  */

  String weathercode1 = 'wi-night-clear'; // weathers data from https://github.com/worldturtlemedia/weather_icons/blob/master/lib/src/weather_icons_g.dart
  String weathercode2 = 'wi-day-snow-thunderstorm';
  String weathercode3 = 'wi-day-fog';
  String weathercode4 = 'wi-day-hail';
  String weathercode5 = 'wi-day-cloudy-windy';





  Widget build(BuildContext context) {
    // Widget Weather Section
    Color color = Theme.of(context).primaryColor;
    int currentHour = DateTime.now().hour;

    // String tempLabel pretty redundant as we get the data from our builder
    // TODO: Remove the tempLabel

    Widget _buildWeatherInfoColumn1(
        Color color, String timeLabel) {
      return FutureBuilder<Weather>(
          future: futureWeather1,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              /* String returnData = snapshot.data.metadata.stations[0].name +
                  " Temperature : " +
                  snapshot.data.items[0].readings[0].value.toString() +
                  "C"; */
              String weather =
                  snapshot.data.items[0].readings[0].value.toString() + "C"; // The value of the temperature in stirng

              return Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BoxedIcon(
                    WeatherIcons.fromString(weathercode1, fallback: WeatherIcons.na), // Icons
                    // icon

                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 8),
                    child: Text(
                      timeLabel,
                      style: TextStyle(
                        fontSize: 12, // font of the time
                        fontWeight: FontWeight.w400,
                        color: color,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 8),
                    child: Text(
                      weather, // Temperature value
                      style: TextStyle(
                        fontSize: 12, // font of the tmeperature
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
    Widget _buildWeatherInfoColumn2(
        Color color, String timeLabel) {
      return FutureBuilder<Weather>(
          future: futureWeather2,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              /* String returnData = snapshot.data.metadata.stations[0].name +
                  " Temperature : " +
                  snapshot.data.items[0].readings[0].value.toString() +
                  "C"; */
              String weather =
                  snapshot.data.items[0].readings[0].value.toString() + "C"; // The value of the temperature in stirng
              return Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BoxedIcon(WeatherIcons.fromString(weathercode2, fallback: WeatherIcons.na), // icon
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
                        fontSize: 12, // font of the time
                        fontWeight: FontWeight.w400,
                        color: color,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 8),
                    child: Text(
                      weather, // Temperature value
                      style: TextStyle(
                        fontSize: 12, // font of the tmeperature
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
    Widget _buildWeatherInfoColumn3(
        Color color, String timeLabel) {
      return FutureBuilder<Weather>(
          future: futureWeather3,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              /* String returnData = snapshot.data.metadata.stations[0].name +
                  " Temperature : " +
                  snapshot.data.items[0].readings[0].value.toString() +
                  "C"; */
              String weather =
                  snapshot.data.items[0].readings[0].value.toString() + "C"; // The value of the temperature in stirng
              return Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BoxedIcon(WeatherIcons.fromString(weathercode3, fallback: WeatherIcons.na), // icon
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
                        fontSize: 12, // font of the time
                        fontWeight: FontWeight.w400,
                        color: color,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 8),
                    child: Text(
                      weather, // Temperature value
                      style: TextStyle(
                        fontSize: 12, // font of the tmeperature
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
    Widget _buildWeatherInfoColumn4(
        Color color, String timeLabel) {
      return FutureBuilder<Weather>(
          future: futureWeather4,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              /* String returnData = snapshot.data.metadata.stations[0].name +
                  " Temperature : " +
                  snapshot.data.items[0].readings[0].value.toString() +
                  "C"; */
              String weather =
                  snapshot.data.items[0].readings[0].value.toString() + "C"; // The value of the temperature in stirng
              return Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BoxedIcon(WeatherIcons.fromString(weathercode4, fallback: WeatherIcons.na), // icon
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
                        fontSize: 12, // font of the time
                        fontWeight: FontWeight.w400,
                        color: color,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 8),
                    child: Text(
                      weather, // Temperature value
                      style: TextStyle(
                        fontSize: 12, // font of the tmeperature
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
    Widget _buildWeatherInfoColumn5(
        Color color, String timeLabel) {
      return FutureBuilder<Weather>(
          future: futureWeather5,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              /* String returnData = snapshot.data.metadata.stations[0].name +
                  " Temperature : " +
                  snapshot.data.items[0].readings[0].value.toString() +
                  "C"; */
              String weather =
                  snapshot.data.items[0].readings[0].value.toString() + "C"; // The value of the temperature in stirng
              return Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BoxedIcon(WeatherIcons.fromString(weathercode5, fallback: WeatherIcons.na), // icon
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
                        fontSize: 12, // font of the time
                        fontWeight: FontWeight.w400,
                        color: color,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 8),
                    child: Text(
                      weather, // Temperature value
                      style: TextStyle(
                        fontSize: 12, // font of the tmeperature
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
        _buildWeatherInfoColumn1(
            color, toHourString(currentHour - 2)),
        _buildWeatherInfoColumn2(
            color, toHourString(currentHour - 1)),
        _buildWeatherInfoColumn3(color, "now"),
        _buildWeatherInfoColumn4(
            color, toHourString(currentHour+1)),
        _buildWeatherInfoColumn5(
            color, toHourString(currentHour+2)),
      ],
    ));

    // Widget Should I walk my dog button
    Widget walkDogSection = Container(
        child: RaisedButton(
      onPressed: () {},
      child: Text("Should I walk my dog?", style: TextStyle(fontSize: 20)),
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
