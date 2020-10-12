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



// Forecast
Future<Forecast> forecast1() async{
  final response=
  await http.get(('https://api.data.gov.sg/v1/environment/2-hour-weather-forecast?date=2020-09-16'));

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




class Home extends StatelessWidget {
  @override
  Future<Weather> futureWeather1 = fetchWeather1(); // gets temperature from api
  Future<Weather> futureWeather2 = fetchWeather2();
  Future<Weather> futureWeather3 = fetchWeather3();
  Future<Weather> futureWeather4 = fetchWeather4();
  Future<Weather> futureWeather5 = fetchWeather5();


  Future<Forecast> futureforecast1 = forecast1();
  Future<Forecast> futureforecast2 = forecast2();
  Future<Forecast> futureforecast3 = forecast3();
  Future<Forecast> futureforecast4 = forecast4();
  Future<Forecast> futureforecast5 = forecast5();
  // String weathercode1 = snapshot.data.items[0].forecasts[0].forecast.toString();// The current weather


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

    Widget _buildForecastInfoColumn1(
        Color color, String timeLabel) {
      return FutureBuilder<Forecast>(
          future: futureforecast1,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              String weathercodetest = snapshot.data.items[0].update_timestamp[0].forecasts[0].forecast;
              // The value of the temperature in stirng


              return Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  BoxedIcon(
                  WeatherIcons.fromString(weathercode1, fallback: WeatherIcons.na), // Icons
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

    Widget forecastSection = Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildForecastInfoColumn1(
                color, toHourString(currentHour - 2)),
            _buildForecastInfoColumn1(
                color, toHourString(currentHour - 1)),
            _buildForecastInfoColumn1(color, "now"),
            _buildForecastInfoColumn1(
                color, toHourString(currentHour+1)),
            _buildForecastInfoColumn1(
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
          weatherSection,
          const SizedBox(height:20),
          forecastSection,
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


Future<Forecast> forecast() async{
  final response=
  await http.get('https://api.data.gov.sg/v1/environment/2-hour-weather-forecast?date=2018-10-24');

  if (response.statusCode ==200){
    return Forecast.fromJson(json.decode(response.body));
  } else{
    throw Exception('failed to load data');
  }
}


Forecast forecastFromJson(String str) => Forecast.fromJson(json.decode(str));

String forecastToJson(Forecast data) => json.encode(data.toJson());

class Forecast {
  Forecast({
    this.greeting,
    this.instructions,
  });

  String greeting;
  List<Instruction> instructions;

  factory Forecast.fromJson(Map<String, dynamic> json) => Forecast(
    greeting: json["greeting"],
    instructions: List<Instruction>.from(json["instructions"].map((x) => Instruction.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "greeting": greeting,
    "instructions": List<dynamic>.from(instructions.map((x) => x.toJson())),
  };
}

class Instruction {
  Instruction({
    this.metadata,
    this.items,
    this.apiInfo,
  });

  Metadata metadata;
  List<Item> items;
  ApiInfo apiInfo;

  factory Instruction.fromJson(Map<String, dynamic> json) => Instruction(
    metadata: Metadata.fromJson(json["metadata"]),
    items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
    apiInfo: ApiInfo.fromJson(json["api_info"]),
  );

  Map<String, dynamic> toJson() => {
    "metadata": metadata.toJson(),
    "items": List<dynamic>.from(items.map((x) => x.toJson())),
    "api_info": apiInfo.toJson(),
  };
}

class ApiInfo {
  ApiInfo({
    this.status,
  });

  String status;

  factory ApiInfo.fromJson(Map<String, dynamic> json) => ApiInfo(
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
  };
}

class Item {
  Item({
    this.timestamp,
    this.readings,
  });

  DateTime timestamp;
  List<Reading> readings;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    timestamp: DateTime.parse(json["timestamp"]),
    readings: List<Reading>.from(json["readings"].map((x) => Reading.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "timestamp": timestamp.toIso8601String(),
    "readings": List<dynamic>.from(readings.map((x) => x.toJson())),
  };
}

class Reading {
  Reading({
    this.stationId,
    this.value,
  });

  DeviceId stationId;
  double value;

  factory Reading.fromJson(Map<String, dynamic> json) => Reading(
    stationId: deviceIdValues.map[json["station_id"]],
    value: json["value"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "station_id": deviceIdValues.reverse[stationId],
    "value": value,
  };
}

enum DeviceId { S109, S117, S50, S107, S43, S108, S44, S121, S106, S111, S122, S60, S115, S24, S116, S104, S100 }

final deviceIdValues = EnumValues({
  "S100": DeviceId.S100,
  "S104": DeviceId.S104,
  "S106": DeviceId.S106,
  "S107": DeviceId.S107,
  "S108": DeviceId.S108,
  "S109": DeviceId.S109,
  "S111": DeviceId.S111,
  "S115": DeviceId.S115,
  "S116": DeviceId.S116,
  "S117": DeviceId.S117,
  "S121": DeviceId.S121,
  "S122": DeviceId.S122,
  "S24": DeviceId.S24,
  "S43": DeviceId.S43,
  "S44": DeviceId.S44,
  "S50": DeviceId.S50,
  "S60": DeviceId.S60
});

class Metadata {
  Metadata({
    this.stations,
    this.readingType,
    this.readingUnit,
  });

  List<Station> stations;
  String readingType;
  String readingUnit;

  factory Metadata.fromJson(Map<String, dynamic> json) => Metadata(
    stations: List<Station>.from(json["stations"].map((x) => Station.fromJson(x))),
    readingType: json["reading_type"],
    readingUnit: json["reading_unit"],
  );

  Map<String, dynamic> toJson() => {
    "stations": List<dynamic>.from(stations.map((x) => x.toJson())),
    "reading_type": readingType,
    "reading_unit": readingUnit,
  };
}

class Station {
  Station({
    this.id,
    this.deviceId,
    this.name,
    this.location,
  });

  DeviceId id;
  DeviceId deviceId;
  String name;
  Location location;

  factory Station.fromJson(Map<String, dynamic> json) => Station(
    id: deviceIdValues.map[json["id"]],
    deviceId: deviceIdValues.map[json["device_id"]],
    name: json["name"],
    location: Location.fromJson(json["location"]),
  );

  Map<String, dynamic> toJson() => {
    "id": deviceIdValues.reverse[id],
    "device_id": deviceIdValues.reverse[deviceId],
    "name": name,
    "location": location.toJson(),
  };
}
//data.items[0].forecasts[0].forecast
class Location {
  Location({
    this.latitude,
    this.longitude,
  });

  double latitude;
  double longitude;

  factory Location.fromJson(Map<String, dynamic> json) => Location(
    latitude: json["latitude"].toDouble(),
    longitude: json["longitude"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "latitude": latitude,
    "longitude": longitude,
  };
}

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
