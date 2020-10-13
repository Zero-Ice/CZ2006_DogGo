
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

var time1 = new DateTime(2020, 1, 1, 9, 0);
var time2 = new DateTime(2020, 1, 1, 19, 30);
List timings = [time1, time2];

var dog1 = new Dog("Doggo1", timings, "Kibble");
var dog2 = new Dog("Doggo2", timings, "Kibble");

class FeedingTime extends StatefulWidget {
  @override
  _FeedingTimeState createState() => _FeedingTimeState();
}

class _FeedingTimeState extends State<FeedingTime> {
  List<Dog> dogList = [dog1, dog2];
  TimeOfDay _time = TimeOfDay.now();
  Future<Null> selectTime(BuildContext context) async {
    TimeOfDay selectedTime = await showTimePicker(
      context: context,
      initialTime: _time,
    );
  }
  Future<Dog>_showEditForm(int index){
    TextEditingController customController = TextEditingController();
    return showDialog(context: context, builder: (context){
      return AlertDialog(

        title: Text("${dogList[index].getName}"),
        content: TextField(
            controller: customController,
            decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: "Food",
          ),
        ),



        actions:<Widget>[
          MaterialButton(
            elevation: 5.0,
            child: Text("Save"),
            onPressed: (){
              setState(() {
                dogList[index].setFood = customController.text.toString();
              });
              Navigator.of(context).pop();
            },
          )
        ],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Feeding Time"),
      ),
      body: Container(
          child: Column(
        children: [
          Expanded(
              child: Container(
                  child: ListView.separated(
            padding: const EdgeInsets.all(8),
            itemCount: dogList.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                  height: 80,
                  color: Colors.amber[600],
                  child: Row(children: [
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
                          Text(
                              '${dogList[index].getName} - ${dogList[index].getFrequency} time(s) per day'),
                          Text(
                              'Feeding Times: ${dogList[index].getFeedTimings}'),
                          Text('Food: ${dogList[index].getFood}'),
                        ])),
                    const SizedBox(width: 15),
                    //_popupSettings(index),

                    PopupMenuButton<int>(
                      onSelected: (val) { //1: edit, 2: delete
                        setState(() {
                          if (val == 1){
                            _showEditForm(index);
                          }
                          if (val == 2){
                            dogList.removeAt(index);
                            print(dogList);
                          }

                        });

                      },
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          value: 1,
                          child: Row(
                            children: <Widget>[
                              Icon(Icons.edit),
                              Text('Edit'),
                            ],
                          ),
                        ),
                        PopupMenuItem(
                          value: 2,
                          child: Row(
                            children: <Widget>[
                              Icon(Icons.delete),
                              Text('Delete'),
                            ],
                          ),
                        ),
                      ],
                    )
                  ])
                  //child: Center(child: Text('Dog ${entries[index]}')),
                  );
            },
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(),
          )))
        ],
      )),
    );
  }
}



/*
Widget FeedingProfile = Expanded(
    child: Container(
        child: ListView.separated(
  padding: const EdgeInsets.all(8),
  itemCount: dogList.length,
  itemBuilder: (BuildContext context, int index) {
    return Container(
        height: 80,
        color: Colors.amber[colorCodes[index]],
        child: Row(children: [
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
                Text(
                    '${dogList[index].getName} - ${dogList[index].getFrequency} time(s) per day'),
                Text('Feeding Times: ${dogList[index].getFeedTimings}'),
                Text('Food: ${dogList[index].getFood}'),
              ])),
          const SizedBox(width: 15),
          //_popupSettings(index),

          PopupMenuButton<int>(
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 1,
                child: Row(
                  children: <Widget>[
                    Icon(Icons.edit),
                    Text('Edit'),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 2,
                child: Row(
                  children: <Widget>[
                    Icon(Icons.delete),
                    Text('Delete'),
                  ],
                ),
              ),
            ],
          )
        ])
        //child: Center(child: Text('Dog ${entries[index]}')),
        );
  },
  separatorBuilder: (BuildContext context, int index) => const Divider(),
)));

 */

class Dog {
  String name;
  int frequency;
  List feedTimings;
  String food;

  Dog(String name, List feedTimings, String food) {
    this.name = name;
    this.frequency = feedTimings.length;
    this.feedTimings = feedTimings;
    this.food = food;
  }

  String get getName {
    return name;
  }

  int get getFrequency {
    return frequency;
  }

  String get getFeedTimings {
    //var period;
    List<String> temp = new List();
    var result;
    var hour;
    var minute;
    for (var i = 0; i < feedTimings.length; i++) {
      hour = int.parse("${feedTimings[i].hour}");
      minute = int.parse("${feedTimings[i].minute}");
      if (hour < 10) hour = hour.toString().padLeft(2, '0');
      if (minute == 0) minute = minute.toString().padLeft(2, '0');
      /*
      if (hour > 12){
        period = "PM";
      } else period = "AM";
      */
      result = "$hour:$minute";
      temp.add(result);
    }

    return temp.join(", ");
  }

  String get getFood {
    return food;
  }

  set setFreqency(int frequency) {
    this.frequency = frequency;
  }

  set setTimings(List feedTimings) {
    this.feedTimings = feedTimings;
  }

  set setFood(String food) {
    this.food = food;
  }
}



/*
Widget _popupSettings() => PopupMenuButton<int>(
  itemBuilder: (context) => [
    PopupMenuItem(
      value: 1,
      child: Row(
        children: <Widget>[
          Icon(Icons.edit),
          Text('Edit'),
        ],
      ),
    ),
    PopupMenuItem(
      value: 2,
      child: Row(
        children: <Widget>[
          Icon(Icons.delete),
          Text('Delete'),
        ],
      ),
    ),
  ],
);
 */
