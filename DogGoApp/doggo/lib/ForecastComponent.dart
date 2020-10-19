
import 'package:doggo/main.dart';
import 'package:flutter/material.dart';
import 'package:weather_icons/weather_icons.dart';

import 'forecast.dart';
import 'weather.dart';
import 'StringUtils.dart';

class ForecastWidget extends StatefulWidget {

  List<String> hoursArray;

  ForecastWidget(this.hoursArray);

  _ForecastState myForecastState = new _ForecastState();
  @override
  _ForecastState createState() => myForecastState;

  void setHoursArray(List<String> hoursArray) {
    myForecastState.setHoursArray(hoursArray);
  }
}

class _ForecastState extends State<ForecastWidget> {
  Future<List<Forecast>> futureForecasts;
  // List<String> hoursArray;

  @override
  void initState() {
    super.initState();
    // futureForecasts = fetchAllForecasts(hoursArray);
  }

  void setHoursArray(List<String> hoursArray) {
    widget.hoursArray = hoursArray;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Forecast>>(
        future: fetchAllForecasts(widget.hoursArray),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // By default, show a loading spinner.
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return new Text('ERR');
          } else {
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
          }
        });
  }
}