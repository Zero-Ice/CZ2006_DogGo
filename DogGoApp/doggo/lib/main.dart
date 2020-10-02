import 'dart:async';
import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/material.dart';
import 'weather.dart';
import 'FirstRoute.dart';

void main() {
  runApp(MyApp());

  // runApp(MaterialApp(
  //   title: 'Navigation Basics',
  //   home: Foo(),
  // ));
}

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

  Column _buildWeatherInfoColumn(
      Color color, IconData icon, String timeLabel, String tempLabel) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: color),
        Container(
          margin: const EdgeInsets.only(top: 8),
          child: Text(
            timeLabel,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: color,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 8),
          child: Text(
            tempLabel,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: color,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // Widget Weather Section
    Color color = Theme.of(context).primaryColor;

    Widget weatherSection = Container(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildWeatherInfoColumn(color, Icons.star, '-2hr', '26C'),
        _buildWeatherInfoColumn(color, Icons.star, '-1hr', '28C'),
        _buildWeatherInfoColumn(color, Icons.star, 'now', '29C'),
        _buildWeatherInfoColumn(color, Icons.star, '1hr', '26C'),
        _buildWeatherInfoColumn(color, Icons.star, '2hr', '27C'),
      ],
    ));

    // Widget Should I walk my dog button
    Widget walkDogSection = Container(
        child: RaisedButton(
      onPressed: () {},
      child: Text('Should I walk my dog?', style: TextStyle(fontSize: 20)),
    ));

    // Widget Dog Profiles
    final List<String> entries = <String>['A', 'B', 'C'];
    final List<int> colorCodes = <int>[600, 500, 100];

    Widget dogProfileSection = Container(
        height: 250,
        child: ListView.separated(
          padding: const EdgeInsets.all(8),
          itemCount: entries.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              height: 80,
              color: Colors.amber[colorCodes[index]],
              child: Row(
                children: [
                  const SizedBox(width: 15),
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    backgroundImage: AssetImage('assets/ProfileIcon_Dog.png'),
                    //child: Text('AH'),
                  ),
                  const SizedBox(width: 30),
                  Expanded(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Dog ${entries[index]}'),
                        Text('Birthday: '),
                        Text('Fav Food: ')
                      ]
                    )
                  )
                ]
              )
              //child: Center(child: Text('Dog ${entries[index]}')),
            );
          },
          separatorBuilder: (BuildContext context, int index) =>
              const Divider(),
        )
    );

    // Widget useful links
    Widget usefulLinkSection = Container(
        child: Column(
      children: [Text('Useful links')],
    ));

    return MaterialApp(
      title: 'Fetch weather test',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('My First DogGo'),
        ),
        // body: Center(
        //   child: FutureBuilder<Weather>(
        //     future: futureWeather,
        //     builder: (context, snapshot) {
        //       if (snapshot.hasData) {
        //         String returnData = snapshot.data.metadata.stations[0].name + " Temperature : " + snapshot.data.items[0].readings[0].value.toString() +"C";
        //
        //         return Text(returnData);
        //       } else if (snapshot.hasError) {
        //         return Text("${snapshot.error}");
        //       }
        //
        //       // By default, show a loading spinner.
        //       return CircularProgressIndicator();
        //     },
        //   ),
        body: ListView(
          children: [
            const SizedBox(height: 30),
            weatherSection,
            const SizedBox(height: 30),
            walkDogSection,
            const SizedBox(height: 30),
            dogProfileSection,
            const SizedBox(height: 30),
            usefulLinkSection
          ],
        ),
      ),
    );
  }
}
