import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:doggo/DogCreationClass.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';



class AddVet extends StatefulWidget {
  @override
  //  _AddDogState createState() => _AddDogState();
  _AddVetState createState() => _AddVetState();
}


  class _AddVetState extends State<AddVet>{
    List<DogCreation> dogsList = List<DogCreation>();
    SharedPreferences prefs;





    void loadData() {
      List<String> spList = prefs.getStringList("dogData");
      dogsList =
          spList.map((index) => DogCreation.fromMap(json.decode(index))).toList();
      setState(() {});
    }

    List<DropdownMenuItem<DogCreation>> _dropdownMenuItems;
    DogCreation _selectedItem;

    String strDogName = "";
    String strDate="";
    String strTime="";
    DateTime saveDate;
    TimeOfDay saveTime;
    DateTime _dateTime;
    TimeOfDay _time;
    TimeOfDay selectedTime = TimeOfDay(hour: 00, minute: 00);
    List saveVet;


    List<DropdownMenuItem<DogCreation>> buildDropDownMenuItems(List dogsList) {
      List<DropdownMenuItem<DogCreation>> items = List();
      for (DogCreation listItem in dogsList) {
        items.add(
          DropdownMenuItem(
            child: Text(listItem.name),
            value: listItem,
          ),
        );
      }
      //print(dogsList[0]);
      return items;
    }




    void initState() {
      super.initState();
      initSP();
     // print(dogsList[0].getName);

    }

    void initSP() async {
      prefs = await SharedPreferences.getInstance();
      loadData();
      _dropdownMenuItems = buildDropDownMenuItems(dogsList);
      _selectedItem = _dropdownMenuItems[0].value;
      print(_selectedItem.name);
    }


  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add an appointment"),
      ),
      body: Container(
          child: Column(
            children: [
              const SizedBox(height: 20),
              Container(
                  child: Column(
                    children: [
                      Container(
                  color: Colors.blue,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget> [
                        Row(
                          children: [
                            Text(
                              'Dog:',
                              style: TextStyle(fontSize: 20),
                            ),
                            SizedBox(width: 10,),
                    Expanded(child: DropdownButton<DogCreation>(
                        value: _selectedItem,
                        items: _dropdownMenuItems,
                        onChanged: (value) {
                          setState(() {
                            _selectedItem = value;
                            strDogName=value.name;
                          });
                        })),
                    ],),

                        Row(
                          children: [
                            Text(
                              'Appointment date:',
                              style: TextStyle(fontSize: 20),
                            ),
                            SizedBox(width: 10,),
                            IconButton(
                              icon: Icon(Icons.calendar_today,color: Colors.black,),
                              onPressed: (){
                                showDatePicker(
                                    context: context,
                                    initialDate: _dateTime== null ? DateTime.now(): _dateTime,
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime(2021)).then((date) { setState(() {_dateTime=date;});});
                              },
                            ),
                            Expanded(
                              child: Text((_dateTime == null? "Appointment Date" : strDate = new DateFormat.yMd().format(_dateTime) ),
                              ),),
                          ],),
                        /////////////////////////////////
                        Row(
                          children: [
                            Text(
                              'Appointment time:',
                              style: TextStyle(fontSize: 20),
                            ),
                            SizedBox(width: 10,),
                            IconButton(
                              icon: Icon(Icons.schedule,color: Colors.black,),
                              onPressed: (){
                                showTimePicker(
                                    context: context,
                                    initialTime: _time== null? selectedTime: _time ).then((time) { setState(() {_time=time;});});

                              },
                            ),
                            Expanded(

                              child: Text((_time == null? "Appointment Time" : strTime = (_time.toString()).substring(10,15)),
                              ),),
                          ],
                        ),
                        //////////////////////////////////////
                        RaisedButton(
                          child: Text('Save'),
                          onPressed: () {
                            // Navigate back to first screen when tapped.
                            setState((){
                              saveDate = _dateTime;
                              saveTime = _time;
                              saveVet=["$strDogName","$saveDate","$strTime"];
                            });
                            Navigator.pop(context,saveVet);

                          },
                        ),

                      ],
                    ),
                  ),
                      SizedBox(height: 20,),


                    ],
                  ),

              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: RaisedButton(
                  onPressed: () {
                    // Navigate back to first screen when tapped.
                    Navigator.pop(context);
                  },
                  child: Text('Go back!'),
                ),
              )
            ],
          )),
    );
  }




}

