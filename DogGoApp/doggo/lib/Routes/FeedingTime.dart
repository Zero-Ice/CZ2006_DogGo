
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:doggo/DogCreationClass.dart';

class FeedingTime extends StatefulWidget {
  @override
  _FeedingTimeState createState() => _FeedingTimeState();
}

class _FeedingTimeState extends State<FeedingTime> {
  List<DogCreation> dogsList = List<DogCreation>();
  SharedPreferences prefs;
  TimeOfDay time = TimeOfDay.now();
  TimeOfDay t1, t2;

  @override
  void initState() {
    // TODO: implement initState
    initSP();
    super.initState();
  }

  void initSP() async {
    prefs = await SharedPreferences.getInstance();
    loadData();
  }

  void saveData() {
    List<String> spList = dogsList.map((index) => json.encode(index.toMap()))
        .toList();
    prefs.setStringList("dogData", spList);
  }

  void loadData() {
    List<String> spList = prefs.getStringList("dogData");
    dogsList =
        spList.map((index) => DogCreation.fromMap(json.decode(index))).toList();
    setState(() {});
  }

  void deleteFeed(int index) {
    dogsList[index].setFood = "";
    dogsList[index].setTimings = "";
    saveData();
  }

  String todToStr(TimeOfDay tod) {
    //what user sees
    String _addLeadingZeroIfNeeded(int value) {
      if (value < 10)
        return '0$value';
      return value.toString();
    }
    final String hourLabel = _addLeadingZeroIfNeeded(tod.hour);
    final String minuteLabel = _addLeadingZeroIfNeeded(tod.minute);

    return '$hourLabel:$minuteLabel';
  }

  TimeOfDay strToTOD(String s) {
    //"16:00" time string -> TimeOfDay object
    return TimeOfDay(
        hour: int.parse(s.split(":")[0]), minute: int.parse(s.split(":")[1]));
  }

  List<String> splitTime(String s) {
    return s.split(",");
  }

  Future<DogCreation> _showEditForm(int index) {
    TextEditingController foodController = TextEditingController();
    TextEditingController timeCon1 = TextEditingController();
    TextEditingController timeCon2 = TextEditingController();
    if (dogsList[index].getFood.isNotEmpty)
      foodController.text = "${dogsList[index].getFood}";
    else
      foodController.text = "";
    try {
      List<String> timeList = splitTime(dogsList[index].getFeedTimings);
      timeCon1.text = timeList[0];
      timeCon2.text = timeList[1];
      t1 = strToTOD(timeList[0]);
      t2 = strToTOD(timeList[1]);
    }
    on RangeError catch (e) {
      print(e);
    }
    on NoSuchMethodError catch (e) {
      print(e);
    }
    on FormatException catch (e) {
      print(e);
    }

    return showDialog(context: context, builder: (context) {
      return AlertDialog(

        title: Text("${dogsList[index].getName}"),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,

          children: <Widget>[
            TextFormField(
                controller: foodController,
                decoration: InputDecoration(
                    labelText: "Food"
                )
            ),
            TextFormField(
              enableInteractiveSelection: false,
              controller: timeCon1,
              decoration: InputDecoration(
                labelText: 'Feeding Time 1',
              ),
              onTap: () async {
                FocusScope.of(context).requestFocus(new FocusNode());
                TimeOfDay picked =
                await showTimePicker(context: context, initialTime: time);
                if (picked != null) { //picked != time
                  setState(() {
                    t1 = picked;
                    timeCon1.text = todToStr(t1);
                  });
                }
              },
            ),
            TextFormField(
              enableInteractiveSelection: false,
              controller: timeCon2,
              decoration: InputDecoration(
                labelText: 'Feeding Time 2',
              ),
              onTap: () async {
                FocusScope.of(context).requestFocus(new FocusNode());
                TimeOfDay picked =
                await showTimePicker(context: context, initialTime: time);
                if (picked != null) { //picked != null &&  picked != time
                  setState(() {
                    t2 = picked;
                    timeCon2.text = todToStr(t2);
                  });
                }
              },
            ),

          ],
        ),

        actions: <Widget>[
          MaterialButton(
            elevation: 5.0,
            child: Text("Save"),
            onPressed: () {
              setState(() {
                List strList = [timeCon1.text, timeCon2.text];
                String s = strList.join(",");
                dogsList[index].setTimings = s;
                dogsList[index].setFood = foodController.text.toString();
                saveData();
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
    Widget dogListBuilder = Expanded(
        child: Container(
            child: ListView.separated(
              padding: const EdgeInsets.all(8),
              itemCount: dogsList.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                    height: 80,
                    //color: Colors.amber[colorCodes[index]],
                    child: Row(children: [
                      const SizedBox(width: 15),
                      CircleAvatar(
                        backgroundColor: Colors.grey[300],
                        backgroundImage: AssetImage(
                            'assets/ProfileIcon_Dog.png'),
                        radius: 35,
                        //child: Text('AH'),
                      ),
                      const SizedBox(width: 30),
                      Expanded(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('${dogsList[index].getName}'),
                                SizedBox(height: 5,),
                                Text('Feeding Times: ${dogsList[index]
                                    .getFeedTimings}'.replaceAll(",", " ")),
                                SizedBox(height: 5,),
                                Text('Food: ${dogsList[index].getFood}'),
                                SizedBox(height: 5,),
                              ])),
                      PopupMenuButton<int>(
                        onSelected: (val) { //1: edit, 2: delete
                          setState(() {
                            if (val == 1) {
                              _showEditForm(index);
                              //saveData();
                            }
                            if (val == 2) { //add delete confirmation dialog
                              deleteFeed(index);
                              //saveData();
                            }
                          });
                        },
                        itemBuilder: (context) =>
                        [
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
                );
              },
              separatorBuilder: (BuildContext context,
                  int index) => const Divider(height: 20,),
            )
        )
    );


    return Scaffold(
      appBar: AppBar(
        title: Text("Feeding Time"),

      ),
      body: Center(
        child: Column(
            children: [
              dogListBuilder,
            ]
        ),
      ),

    );
  }
}
