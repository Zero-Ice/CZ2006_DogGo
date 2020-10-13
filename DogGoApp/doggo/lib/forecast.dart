import 'package:flutter/cupertino.dart';
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
    this.areaMetadata,
    this.items,
    this.apiInfo,

  });

  List<AreaMetadatum> areaMetadata;
  List<Item> items;
  ApiInfo apiInfo;

  factory Forecast.fromJson(Map<String, dynamic> json) => Forecast(
    areaMetadata: List<AreaMetadatum>.from(json["area_metadata"].map((x) => AreaMetadatum.fromJson(x))),
    items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
    apiInfo: ApiInfo.fromJson(json["api_info"]),
  );

  Map<String, dynamic> toJson() => {
    "area_metadata": List<dynamic>.from(areaMetadata.map((x) => x.toJson())),
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

class AreaMetadatum {
  AreaMetadatum({
    this.name,
    this.labelLocation,
  });

  Name name;
  LabelLocation labelLocation;

  factory AreaMetadatum.fromJson(Map<String, dynamic> json) => AreaMetadatum(
    name: nameValues.map[json["name"]],
    labelLocation: LabelLocation.fromJson(json["label_location"]),
  );

  Map<String, dynamic> toJson() => {
    "name": nameValues.reverse[name],
    "label_location": labelLocation.toJson(),
  };
}

class LabelLocation {
  LabelLocation({
    this.latitude,
    this.longitude,
  });

  double latitude;
  double longitude;

  factory LabelLocation.fromJson(Map<String, dynamic> json) => LabelLocation(
    latitude: json["latitude"].toDouble(),
    longitude: json["longitude"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "latitude": latitude,
    "longitude": longitude,
  };
}

enum Name { ANG_MO_KIO, BEDOK, BISHAN, BOON_LAY, BUKIT_BATOK, BUKIT_MERAH, BUKIT_PANJANG, BUKIT_TIMAH, CENTRAL_WATER_CATCHMENT, CHANGI, CHOA_CHU_KANG, CLEMENTI, CITY, GEYLANG, HOUGANG, JALAN_BAHAR, JURONG_EAST, JURONG_ISLAND, JURONG_WEST, KALLANG, LIM_CHU_KANG, MANDAI, MARINE_PARADE, NOVENA, PASIR_RIS, PAYA_LEBAR, PIONEER, PULAU_TEKONG, PULAU_UBIN, PUNGGOL, QUEENSTOWN, SELETAR, SEMBAWANG, SENGKANG, SENTOSA, SERANGOON, SOUTHERN_ISLANDS, SUNGEI_KADUT, TAMPINES, TANGLIN, TENGAH, TOA_PAYOH, TUAS, WESTERN_ISLANDS, WESTERN_WATER_CATCHMENT, WOODLANDS, YISHUN }

final nameValues = EnumValues({
  "Ang Mo Kio": Name.ANG_MO_KIO,
  "Bedok": Name.BEDOK,
  "Bishan": Name.BISHAN,
  "Boon Lay": Name.BOON_LAY,
  "Bukit Batok": Name.BUKIT_BATOK,
  "Bukit Merah": Name.BUKIT_MERAH,
  "Bukit Panjang": Name.BUKIT_PANJANG,
  "Bukit Timah": Name.BUKIT_TIMAH,
  "Central Water Catchment": Name.CENTRAL_WATER_CATCHMENT,
  "Changi": Name.CHANGI,
  "Choa Chu Kang": Name.CHOA_CHU_KANG,
  "City": Name.CITY,
  "Clementi": Name.CLEMENTI,
  "Geylang": Name.GEYLANG,
  "Hougang": Name.HOUGANG,
  "Jalan Bahar": Name.JALAN_BAHAR,
  "Jurong East": Name.JURONG_EAST,
  "Jurong Island": Name.JURONG_ISLAND,
  "Jurong West": Name.JURONG_WEST,
  "Kallang": Name.KALLANG,
  "Lim Chu Kang": Name.LIM_CHU_KANG,
  "Mandai": Name.MANDAI,
  "Marine Parade": Name.MARINE_PARADE,
  "Novena": Name.NOVENA,
  "Pasir Ris": Name.PASIR_RIS,
  "Paya Lebar": Name.PAYA_LEBAR,
  "Pioneer": Name.PIONEER,
  "Pulau Tekong": Name.PULAU_TEKONG,
  "Pulau Ubin": Name.PULAU_UBIN,
  "Punggol": Name.PUNGGOL,
  "Queenstown": Name.QUEENSTOWN,
  "Seletar": Name.SELETAR,
  "Sembawang": Name.SEMBAWANG,
  "Sengkang": Name.SENGKANG,
  "Sentosa": Name.SENTOSA,
  "Serangoon": Name.SERANGOON,
  "Southern Islands": Name.SOUTHERN_ISLANDS,
  "Sungei Kadut": Name.SUNGEI_KADUT,
  "Tampines": Name.TAMPINES,
  "Tanglin": Name.TANGLIN,
  "Tengah": Name.TENGAH,
  "Toa Payoh": Name.TOA_PAYOH,
  "Tuas": Name.TUAS,
  "Western Islands": Name.WESTERN_ISLANDS,
  "Western Water Catchment": Name.WESTERN_WATER_CATCHMENT,
  "Woodlands": Name.WOODLANDS,
  "Yishun": Name.YISHUN
});

class Item {
  Item({
    this.updateTimestamp,
    this.timestamp,
    this.validPeriod,
    this.forecasts,
  });

  DateTime updateTimestamp;
  DateTime timestamp;
  ValidPeriod validPeriod;
  List<ForecastElement> forecasts;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    updateTimestamp: DateTime.parse(json["update_timestamp"]),
    timestamp: DateTime.parse(json["timestamp"]),
    validPeriod: ValidPeriod.fromJson(json["valid_period"]),
    forecasts: List<ForecastElement>.from(json["forecasts"].map((x) => ForecastElement.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "update_timestamp": updateTimestamp.toIso8601String(),
    "timestamp": timestamp.toIso8601String(),
    "valid_period": validPeriod.toJson(),
    "forecasts": List<dynamic>.from(forecasts.map((x) => x.toJson())),
  };
}

class ForecastElement {
  ForecastElement({
    this.area,
    this.forecast,
  });

  Name area;
  ForecastEnum forecast;

  factory ForecastElement.fromJson(Map<String, dynamic> json) => ForecastElement(
    area: nameValues.map[json["area"]],
    forecast: forecastEnumValues.map[json["forecast"]],
  );

  Map<String, dynamic> toJson() => {
    "area": nameValues.reverse[area],
    "forecast": forecastEnumValues.reverse[forecast],
  };
}

enum ForecastEnum { CLOUDY, HEAVY_THUNDERY_SHOWERS_WITH_GUSTY_WINDS, MODERATE_RAIN, THUNDERY_SHOWERS, LIGHT_RAIN }

final forecastEnumValues = EnumValues({
  "Cloudy": ForecastEnum.CLOUDY,
  "Heavy Thundery Showers with Gusty Winds": ForecastEnum.HEAVY_THUNDERY_SHOWERS_WITH_GUSTY_WINDS,
  "Light Rain": ForecastEnum.LIGHT_RAIN,
  "Moderate Rain": ForecastEnum.MODERATE_RAIN,
  "Thundery Showers": ForecastEnum.THUNDERY_SHOWERS
});

class ValidPeriod {
  ValidPeriod({
    this.start,
    this.end,
  });

  DateTime start;
  DateTime end;

  factory ValidPeriod.fromJson(Map<String, dynamic> json) => ValidPeriod(
    start: DateTime.parse(json["start"]),
    end: DateTime.parse(json["end"]),
  );

  Map<String, dynamic> toJson() => {
    "start": start.toIso8601String(),
    "end": end.toIso8601String(),
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
