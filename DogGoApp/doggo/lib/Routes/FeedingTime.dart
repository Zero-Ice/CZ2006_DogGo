
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
    TextEditingController foodController = TextEditingController();
    TextEditingController timeCon1 = TextEditingController();
    TextEditingController timeCon2 = TextEditingController();
    foodController.text = "${dogList[index].getFood}";
    DateTime dt1 = dogList[index].getFeedTimings[0];// add condition for empty value
    DateTime dt2 = dogList[index].getFeedTimings[1];
    timeCon1.text = printTime(dt1);
    timeCon2.text = printTime(dt2);
    TimeOfDay t1, t2;

    final now = new DateTime.now();
    bool timeChange1 = false; bool timeChange2 = false;
    return showDialog(context: context, builder: (context){
      return AlertDialog(

        title: Text("${dogList[index].getName}"),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,

          children:<Widget>[
            TextFormField (
                controller: foodController,
                decoration: InputDecoration(
                  //border: OutlineInputBorder(),
                    labelText: "Food"
                )
            ),
            TextFormField(
              enableInteractiveSelection : false,
              controller: timeCon1,
              decoration: InputDecoration(
                //border: OutlineInputBorder(),
                labelText: 'Feeding Time 1',
              ),
              onTap: () async {
                TimeOfDay time = TimeOfDay.now(); //TimeOfDay.fromDateTime(dogList[index].getFeedTimings[0]);
                FocusScope.of(context).requestFocus(new FocusNode());
                //timeChange1 = true;
                TimeOfDay picked =
                await showTimePicker(context: context, initialTime: time);
                if (picked != null) { //picked != time
                    setState(() {
                    //time = picked;
                    //t1 = time;
                      t1= picked;
                    dt1 = new DateTime(now.year, now.month, now.day, t1.hour, t1.minute);
                    timeCon1.text = printTime(dt1);
                  });
                }
              },
            ),
            TextFormField(
              enableInteractiveSelection : false,
              controller: timeCon2,
              decoration: InputDecoration(
                //border: OutlineInputBorder(),
                labelText: 'Feeding Time 2',
              ),
              onTap: () async {
                TimeOfDay time = TimeOfDay.now();//TimeOfDay.fromDateTime(dogList[index].getFeedTimings[1]);
                FocusScope.of(context).requestFocus(new FocusNode());

                TimeOfDay picked =
                await showTimePicker(context: context, initialTime: time);
                if (picked != null) { //picked != null &&  picked != time
                  //timeChange2 = true;
                  setState(() {
                    //time = picked;
                    //t2 = time;
                    t2 = picked;
                    dt2 = new DateTime(now.year, now.month, now.day, t2.hour, t2.minute);
                    timeCon2.text = printTime(dt2);
                  });
                }
              },
            ),

          ],
        ),

        actions:<Widget>[
          MaterialButton(
            elevation: 5.0,
            child: Text("Save"),
            onPressed: (){
              setState(() {
                List dtList= [dt1,dt2];
                dogList[index].setTimings = dtList;
                dogList[index].setFood = foodController.text.toString();
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
                              'Feeding Times: ${dogList[index].printFeedTimings}'),
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
                          if (val == 2){ //add delete confirmation dialog
                            dogList.removeAt(index);
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

String printTime(DateTime dt){
  String result;
  var hour;
  var minute;
  hour = int.parse("${dt.hour}");
  minute = int.parse("${dt.minute}");
  if (hour < 10) hour = hour.toString().padLeft(2, '0');
  if (minute < 9) minute = minute.toString().padLeft(2, '0');

  result = "$hour:$minute";
  return result;
}

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
  List get getFeedTimings{
    return feedTimings;
  }
  String get printFeedTimings {
    //var period;
    List<String> temp = new List();
    var result;
    var hour;
    var minute;
    for (var i = 0; i < feedTimings.length; i++) {
      hour = int.parse("${feedTimings[i].hour}");
      minute = int.parse("${feedTimings[i].minute}");
      if (hour < 10) hour = hour.toString().padLeft(2, '0');
      if (minute < 9) minute = minute.toString().padLeft(2, '0');

      result = "$hour:$minute";
      temp.add(result);
    }

    return temp.join(", ");
  }

  String get getFood {
    return food;
  }

  set setFrequency(int frequency) {
    this.frequency = frequency;
  }

  set setTimings(List feedTimings){
    this.feedTimings = feedTimings;
  }

  set deleteTiming(int index){
    feedTimings.removeAt(index);
    this.feedTimings = feedTimings;
  }

  set setFood(String food) {
    this.food = food;
  }
}
