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
import 'package:intl/intl.dart';
import 'forecast.dart';
import 'package:doggo/AddDogList.dart';

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

String toHourString(int hour) {
  if (hour < 10) {
    return "0" + hour.toString() + ":00:00";
  } else if (hour >= 25) {
    return "0" + (hour - 24).toString() + ":00:00";
  }

  return hour.toString() + ":00:00";
}

// Air Temperature
Future<List<Weather>> fetchAllWeather(List<String> hours) async {
  print('AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAa');
  List<Weather> weathers = new List(5);
  for (int i = 0; i < hours.length; i++) {
    print("fetching weather " + hours[i]);
    var response = await http.get(
        ('https://api.data.gov.sg/v1/environment/air-temperature?date_time=' +
            hours[i]));
    print("got response");
    if (response.statusCode == 200) {
      weathers[i] = (Weather.fromJson(json.decode(response.body)));
    } else {
      // throw Exception('N/A');
    }
  }

  return weathers;
}

// Fetch weather all forecasts
Future<List<Forecast>> fetchAllForecasts(List<String> hours) async {
  print('AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAa');
  print(hours.length);
  List<Forecast> forecasts = new List(5);
  for (int i = 0; i < hours.length; i++) {
    print('fetching forecast' + hours[i]);
    var response = await http.get(
        ('https://api.data.gov.sg/v1/environment/2-hour-weather-forecast?date_time=' +
            hours[i]));
    print('got forecast response ' + response.statusCode.toString());
    if (response.statusCode == 200) {
      print('adding response');
      forecasts[i] = (Forecast.fromJson(json.decode(response.body)));
    } else {
      // throw Exception('N/A');
    }
  }

  return forecasts;
}

// Get weather code
String getWeatherCodeFromForecast(String forecast) {
  String weatherCode = "";
  switch (forecast) {
    case "ForecastEnum.CLOUDY":
      weatherCode = 'wi-day-cloudy';
      break;
    case "ForecastEnum.HEAVY_THUNDERY_SHOWERS_WITH_GUSTY_WINDS":
      weatherCode = 'wi-day-thunderstorm';
      break;
    case "ForecastEnum.LIGHT_RAIN":
      weatherCode = 'wi-day-rain';
      break;
    case "ForecastEnum.MODERATE_RAIN":
      weatherCode = 'wi-day-rain-wind';
      break;
    case "ForecastEnum.THUNDERY_SHOWERS":
      weatherCode = 'wi-thunderstorm';
      break;
    default:
      weatherCode = 'wi-day-cloudy';
  }
  
  return weatherCode;
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
}

class _HomeState extends State<Home> {
  int currentHour = DateTime.now().hour;
  List<String> hoursArray = [];

  Future<List<Weather>> futureWeather;
  Future<List<Forecast>> futureForecasts;

  @override
  void initState() {
    super.initState();
    hoursArray = UpdateHourArray();
    print(hoursArray);
    futureWeather = fetchAllWeather(hoursArray);
    futureForecasts = fetchAllForecasts(hoursArray);
    print('init');
  }

  Widget build(BuildContext context) {
    // Widget Weather Section
    Color color = Theme.of(context).primaryColor;

    Widget _buildAllWeatherInfoColumn() {
      return FutureBuilder<List<Weather>>(
          future: futureWeather,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              // String weather =
              //     snapshot.data.items[0].readings[0].value.toString() +
              //         "C"; // The value of the temperature in string
              print("Weather data");
              print(snapshot.data);
              return Container(
                height: 100,
                width: MediaQuery.of(context).size.width,
                child: Center(

                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 5,
                    itemBuilder: (context, index){
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 8),
                            child: Text(
                              "A",
                              // hoursArray[index],
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
                              snapshot.data[index] != null ? snapshot.data[index].items[0].readings[0].value.toString() + "C" : "C", // Temperature value
                              style: TextStyle(
                                fontSize: 12, // font of the temperature
                                fontWeight: FontWeight.w400,
                                color: color,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              );
              //return Text(returnData);
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }

            // By default, show a loading spinner.
            return CircularProgressIndicator();
          });
    }

    Widget _buildForecastInfoSection() {
      return FutureBuilder<List<Forecast>>(
          future: futureForecasts,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              print("Forecast data");
              print(snapshot.data);
              return Container(
                height: 100,
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  itemBuilder: (context, index){
                    return Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          BoxedIcon(
                            snapshot.data[index] != null ?
                            WeatherIcons.fromString(getWeatherCodeFromForecast(snapshot.data[index].items[0].forecasts[0].forecast.toString()),
                                fallback: WeatherIcons.na) : WeatherIcons.na, // Icons
                            // icon
                          )
                        ]);
                  },
                ),
              );
              //return Text(returnData);
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }

            // By default, show a loading spinner.
            return CircularProgressIndicator();
          });
    }
    
    Widget weatherSection = _buildAllWeatherInfoColumn();

    Widget forecastSection = _buildForecastInfoSection();

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
            Align(alignment: Alignment.topCenter, child: Text('Useful links')),
            Text('ASDF'),
            Text('DSGSDG'),
          ],
        ));

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
              setState(() {
                AddDogList().getSPlist();
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
          forecastSection,
          const SizedBox(height: 20),
          weatherSection,
          const SizedBox(height: 20),
          walkDogSection,
          const SizedBox(height: 10),
          AddDogList().run(),
          const SizedBox(height: 20),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: usefulLinkSection,
            ),
          )
        ],
      )),
    );
  }
}
