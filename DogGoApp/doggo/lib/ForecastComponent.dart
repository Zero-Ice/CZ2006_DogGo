
import 'package:doggo/main.dart';
import 'package:flutter/material.dart';
import 'package:weather_icons/weather_icons.dart';

import 'forecast.dart';
import 'weather.dart';
import 'StringUtils.dart';

class ForecastWidget extends StatefulWidget {
  final List<String> hoursArray;

  const ForecastWidget(this.hoursArray);

  @override
  _ForecastState createState() => _ForecastState();
}

class _ForecastState extends State<ForecastWidget> {
  Future<List<Forecast>> futureForecasts;

  @override
  void initState() {
    super.initState();
    futureForecasts = fetchAllForecasts(widget.hoursArray);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Forecast>>(
        future: futureForecasts,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print("Forecast data");
            print(snapshot.data);
            return Container(
                height: 64,
                width: MediaQuery.of(context).size.width,
                child: GridView.count(
                  crossAxisCount: 5,
                  children: List.generate(5, (index) {
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
                ));
            //return Text(returnData);
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }

          // By default, show a loading spinner.
          return CircularProgressIndicator();
        });
  }
}