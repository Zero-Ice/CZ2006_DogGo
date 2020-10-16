import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AddVet extends StatefulWidget {
  @override
  //  _AddDogState createState() => _AddDogState();
  _AddVetState createState() => _AddVetState();
}


  class _AddVetState extends State<AddVet>{
  String strDogName = "";
    String strDate="";
    String strTime="";
    DateTime saveDate;
    TimeOfDay saveTime;
    DateTime _dateTime;
    TimeOfDay _time;
    TimeOfDay selectedTime = TimeOfDay(hour: 00, minute: 00);
    List saveVet;

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
                    Expanded(child: TextField(
                      decoration: InputDecoration(hintText: "Type in Dog name",),
                      onChanged: (String input) {
                        setState(() {
                          strDogName=input;
                        });
                      },
                    ),
                    )],),

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
                              saveVet=["$strDogName","$saveDate","$saveTime"];
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