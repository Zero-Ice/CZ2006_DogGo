import 'dart:async';
import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<Weather> fetchWeather() async{
  final response=
      await http.get('https://api.data.gov.sg/v1/environment/air-temperature?date=2020-09-16');

  if (response.statusCode ==200){
    return Weather.fromJson(json.decode(response.body));
  } else{
    throw Exception('failed to load data');
  }
}


Weather weatherFromJson(String str) => Weather.fromJson(json.decode(str));

String weatherToJson(Weather data) => json.encode(data.toJson());

class Weather {
  Weather({
    this.metadata,
    this.items,
    this.apiInfo,
  });

  final Metadata metadata;
  final List<Item> items;
  final ApiInfo apiInfo;

  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
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

  final String status;

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

  final DateTime timestamp;
  final List<Reading> readings;

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

  final DeviceId stationId;
  final double value;

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

  final List<Station> stations;
  final String readingType;
  final String readingUnit;

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

  final DeviceId id;
  final DeviceId deviceId;
  final String name;
  final Location location;

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

  String getName(){
    return name;
  }
}

class Location {
  Location({
    this.latitude,
    this.longitude,
  });

  final double latitude;
  final double longitude;

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

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<Weather> futureWeather;

  @override
  void initState() {
    super.initState();
    futureWeather = fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch weather test',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Weather test [0]'),
        ),
        body: Center(
          child: FutureBuilder<Weather>(
            future: futureWeather,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                String returnData = snapshot.data.metadata.stations[0].name + " Temperature : " + snapshot.data.items[0].readings[0].value.toString() +"C";

                return Text(returnData);
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }

              // By default, show a loading spinner.
              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
