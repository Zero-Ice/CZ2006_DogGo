import 'package:flutter/material.dart';

import 'weather.dart';
import 'StringUtils.dart';

class WeatherWidget extends StatefulWidget {
  List<String> hoursArray;

  WeatherWidget(this.hoursArray);

  @override
  _WeatherState myWeatherState = new _WeatherState();

  _WeatherState createState() => myWeatherState;
}

class _WeatherState extends State<WeatherWidget> {
  Future<List<Weather>> futureWeather;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new FutureBuilder<List<Weather>>(
        future: fetchAllWeather(widget.hoursArray),
        builder: (context, AsyncSnapshot<List<Weather>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // By default, show a loading spinner.
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return new Text('ERR');
          } else {
            // if(snapshot.hasData)
            // String weather =
            //     snapshot.data.items[0].readings[0].value.toString() +
            //         "C"; // The value of the temperature in string
            // print("Weather data WE GOT DATA BOYS");
            // print(snapshot.data);
            return Container(
              height: 64,
              width: MediaQuery.of(context).size.width,
              child: GridView.count(
                crossAxisCount: 5,
                children: List.generate(
                  5,
                  (index) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 8),
                          child: Text(
                            snapshot.data[index] != null ?
                            hourStringRemoveSeconds(widget.hoursArray[index]) : "N/A",
                            style: TextStyle(
                              fontSize: 12, // font of the time
                              fontWeight: FontWeight.w400,
                              // color: color,
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 8),
                          child: Text(
                            snapshot.data[index] != null
                                ? snapshot
                                        .data[index].items[0].readings[0].value
                                        .toString() +
                                    "C"
                                : "C", // Temperature value
                            style: TextStyle(
                              fontSize: 12, // font of the temperature
                              fontWeight: FontWeight.w400,
                              // color: color,
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
          }
        });
  }
}
