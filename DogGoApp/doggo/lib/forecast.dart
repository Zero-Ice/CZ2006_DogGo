import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

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
