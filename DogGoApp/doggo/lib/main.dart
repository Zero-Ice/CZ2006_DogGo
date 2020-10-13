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



Future<Forecast> forecast1() async{
  final response=
  await http.get('https://api.data.gov.sg/v1/environment/2-hour-weather-forecast?date_time='+current_day+hour_back2_s+'%3A00%3A00');

  if (response.statusCode ==200){
    return Forecast.fromJson(json.decode(response.body));
  } else{
    throw Exception('failed to load data');
  }
}
Future<Forecast> forecast2() async{
  final response=
  await http.get('https://api.data.gov.sg/v1/environment/2-hour-weather-forecast?date_time='+current_day+hour_back1_s+'%3A00%3A00');

  if (response.statusCode ==200){
    return Forecast.fromJson(json.decode(response.body));
  } else{
    throw Exception('failed to load data');
  }
}
Future<Forecast> forecast3() async{
  final response=
  await http.get('https://api.data.gov.sg/v1/environment/2-hour-weather-forecast?date_time='+current_day+current_hour+'%3A45%3A00');

  if (response.statusCode ==200){
    return Forecast.fromJson(json.decode(response.body));
  } else{
    throw Exception('failed to load data');
  }
}
Future<Forecast> forecast4() async{
  final response=
  await http.get('https://api.data.gov.sg/v1/environment/2-hour-weather-forecast?date_time='+current_day+hour_forward1_s+'%3A00%3A00');

  if (response.statusCode ==200){
    return Forecast.fromJson(json.decode(response.body));
  } else{
    throw Exception('failed to load data');
  }
}
Future<Forecast> forecast5() async{
  final response=
  await http.get('https://api.data.gov.sg/v1/environment/2-hour-weather-forecast?date_time='+current_day+hour_forward2_s+'%3A00%3A00');

  if (response.statusCode ==200){
    return Forecast.fromJson(json.decode(response.body));
  } else{
    throw Exception('failed to load data');
  }
}


class Home extends StatelessWidget {
  Future<Weather> futureWeather1 = fetchWeather1(); // gets temperature from api
  Future<Weather> futureWeather2 = fetchWeather2();
  Future<Weather> futureWeather3 = fetchWeather3();
  Future<Weather> futureWeather4 = fetchWeather4();
  Future<Weather> futureWeather5 = fetchWeather5();

  @override
  Future<Forecast> futureforecast1 = forecast1();
  Future<Forecast> futureforecast2 = forecast2();
  Future<Forecast> futureforecast3 = forecast3();
  Future<Forecast> futureforecast4 = forecast4();
  Future<Forecast> futureforecast5 = forecast5();


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
              String weather =
                  snapshot.data.items[0].readings[0].value.toString() + "C"; // The value of the temperature in stirng
              return Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
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

    Widget _buildForecastInfoColumn1(
        Color color, String timeLabel) {
      return FutureBuilder<Forecast>(
          future: futureforecast1,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              String weathercodetest1 = snapshot.data.items[0].forecasts[0].forecast.toString();
              print(weathercodetest1);
              // ignore: unnecessary_statements
              (() {
                switch(weathercodetest1) {
                  case "ForecastEnum.CLOUDY":
                    weathercodetest1 = 'wi-day-cloudy';
                    break;
                  case "ForecastEnum.HEAVY_THUNDERY_SHOWERS_WITH_GUSTY_WINDS":
                    weathercodetest1 = 'wi-day-thunderstorm';
                    break;
                  case "ForecastEnum.LIGHT_RAIN":
                    weathercodetest1 = 'wi-day-rain';
                    break;
                  case "ForecastEnum.MODERATE_RAIN":
                    weathercodetest1 = 'wi-day-rain-wind';
                    break;
                  case "ForecastEnum.THUNDERY_SHOWERS":
                    weathercodetest1 = 'wi-thunderstorm';
                    break;
                  default:
                    weathercodetest1 = 'wi-day-cloudy';
                }
              }());
               return Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  BoxedIcon(
                  WeatherIcons.fromString(weathercodetest1, fallback: WeatherIcons.na), // Icons
            // icon

            )]);
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }

            // By default, show a loading spinner.
            return CircularProgressIndicator();
          });
    }
    Widget _buildForecastInfoColumn2(
        Color color, String timeLabel) {
      return FutureBuilder<Forecast>(
          future: futureforecast2,
          builder: ( context, snapshot1) {
            if (snapshot1.hasData) {
              String weathercodetest2 = snapshot1.data.items[0].forecasts[0].forecast.toString();
              (() {
                switch(weathercodetest2) {
                  case "ForecastEnum.CLOUDY":
                    weathercodetest2 = 'wi-day-cloudy';
                    break;
                  case "ForecastEnum.HEAVY_THUNDERY_SHOWERS_WITH_GUSTY_WINDS":
                    weathercodetest2 = 'wi-day-thunderstorm';
                    break;
                  case "ForecastEnum.LIGHT_RAIN":
                    weathercodetest2 = 'wi-day-rain';
                    break;
                  case "ForecastEnum.MODERATE_RAIN":
                    weathercodetest2 = 'wi-day-rain-wind';
                    break;
                  case "ForecastEnum.THUNDERY_SHOWERS":
                    weathercodetest2 = 'wi-thunderstorm';
                    break;
                  default:
                    weathercodetest2 = 'wi-day-cloudy';
                }
              }());
              return Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    BoxedIcon(
                      WeatherIcons.fromString(weathercodetest2, fallback: WeatherIcons.na), // Icons
                      // icon

                    )]);
            } else if (snapshot1.hasError) {
              return Text("${snapshot1.error}");
            }

            // By default, show a loading spinner.
            return CircularProgressIndicator();
          });
    }
    Widget _buildForecastInfoColumn3(
        Color color, String timeLabel) {
      return FutureBuilder<Forecast>(
          future: futureforecast3,
          builder: ( context, snapshot) {
            if (snapshot.hasData) {
              String weathercodetest3 = snapshot.data.items[0].forecasts[0].forecast.toString();
              (() {
                switch(weathercodetest3) {
                  case "ForecastEnum.CLOUDY":
                    weathercodetest3 = 'wi-day-cloudy';
                    break;
                  case "ForecastEnum.HEAVY_THUNDERY_SHOWERS_WITH_GUSTY_WINDS":
                    weathercodetest3 = 'wi-day-thunderstorm';
                    break;
                  case "ForecastEnum.LIGHT_RAIN":
                    weathercodetest3 = 'wi-day-rain';
                    break;
                  case "ForecastEnum.MODERATE_RAIN":
                    weathercodetest3 = 'wi-day-rain-wind';
                    break;
                  case "ForecastEnum.THUNDERY_SHOWERS":
                    weathercodetest3 = 'wi-thunderstorm';
                    break;
                  default:
                    weathercodetest3 = 'wi-day-cloudy';
                }
              }());
              return Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    BoxedIcon(
                      WeatherIcons.fromString(weathercodetest3, fallback: WeatherIcons.na), // Icons
                      // icon

                    )]);
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }

            // By default, show a loading spinner.
            return CircularProgressIndicator();
          });
    }
    Widget _buildForecastInfoColumn4(
        Color color, String timeLabel) {
      return FutureBuilder<Forecast>(
          future: futureforecast4,
          builder: ( context, snapshot) {
            if (snapshot.hasData) {
              String weathercodetest4 = snapshot.data.items[0].forecasts[0].forecast.toString();
              (() {switch(weathercodetest4) {
                case "ForecastEnum.CLOUDY":
                  weathercodetest4 = 'wi-day-cloudy';
                  break;
                case "ForecastEnum.HEAVY_THUNDERY_SHOWERS_WITH_GUSTY_WINDS":
                  weathercodetest4 = 'wi-day-thunderstorm';
                  break;
                case "ForecastEnum.LIGHT_RAIN":
                  weathercodetest4 = 'wi-day-rain';
                  break;
                case "ForecastEnum.MODERATE_RAIN":
                  weathercodetest4 = 'wi-day-rain-wind';
                  break;
                case "ForecastEnum.THUNDERY_SHOWERS":
                  weathercodetest4 = 'wi-thunderstorm';
                  break;
                default:
                  weathercodetest4 = 'wi-day-cloudy';
              }
              }());
              return Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    BoxedIcon(
                      WeatherIcons.fromString(weathercodetest4, fallback: WeatherIcons.na), // Icons
                      // icon

                    )]);
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }

            // By default, show a loading spinner.
            return CircularProgressIndicator();
          });
    }
    Widget _buildForecastInfoColumn5(
        Color color, String timeLabel) {
      return FutureBuilder<Forecast>(
          future: futureforecast5,
          builder: ( context, snapshot) {
            if (snapshot.hasData) {
              String weathercodetest5 = (snapshot.data.items[0].forecasts[0].forecast).toString();
              print(weathercodetest5);

              (() {
                switch(weathercodetest5) {
                  case "ForecastEnum.CLOUDY":
                    weathercodetest5='wi-day-cloudy';
                    break;
                  case "ForecastEnum.HEAVY_THUNDERY_SHOWERS_WITH_GUSTY_WINDS":
                    weathercodetest5 = 'wi-day-thunderstorm';
                    break;
                  case "ForecastEnum.LIGHT_RAIN":
                    weathercodetest5 = 'wi-day-rain';
                    break;
                  case "ForecastEnum.MODERATE_RAIN":
                    weathercodetest5 = 'wi-day-rain-wind';
                    break;
                  case "ForecastEnum.THUNDERY_SHOWERS":
                    weathercodetest5 = 'wi-thunderstorm';
                    break;
                  default:
                    weathercodetest5='wi-day-cloudy';

                }

              }());
              return Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    BoxedIcon(
                      WeatherIcons.fromString(weathercodetest5, fallback: WeatherIcons.na), // Icons
                      // icon

                    )]);
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

    Widget forecastSection = Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildForecastInfoColumn1(
                color, toHourString(currentHour - 2)),
            _buildForecastInfoColumn2(
                color, toHourString(currentHour - 1)),
            _buildForecastInfoColumn3(color, "now"),
            _buildForecastInfoColumn4(
                color, toHourString(currentHour+1)),
            _buildForecastInfoColumn5(
                color, toHourString(currentHour+2)),
          ],
        ));


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
          forecastSection,
          const SizedBox(height:20),
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


