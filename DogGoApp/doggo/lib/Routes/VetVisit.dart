
import 'package:doggo/Routes/vetRoutes/addVet.dart';
import 'package:doggo/Routes/vetRoutes/deleteVet.dart';
import 'package:doggo/Routes/vetRoutes/editVet.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

var time1 = new DateTime(2020, 1, 1, 9, 0);
var time2 = new DateTime(2020, 1, 1, 19, 30);
List timings = [time1, time2];

var vDate=new DateTime(2020,1, 1, 9, 0);
var vTime = new TimeOfDay(hour: 00, minute: 00);
List vDateTime = [vDate, vTime];

var appt1 = new Appointment("Doggo1", vDateTime);
var appt2 = new Appointment("Doggo2", vDateTime);
var appt3 = new Appointment("Doggo3", vDateTime);



class VetVisit extends StatefulWidget{
  @override
  _VetVisitState createState() => _VetVisitState();
}

class _VetVisitState extends State<VetVisit> {
  List<Appointment> apptList = [appt1,appt2,appt3];

  TimeOfDay _time = TimeOfDay.now();
  Future<Null> selectTime(BuildContext context) async {
    TimeOfDay selectedTime = await showTimePicker(
      context: context,
      initialTime: _time,
    );
  }
  Future<Appointment>_showEditForm(int index){
    TextEditingController timeCon1 = TextEditingController();
    TextEditingController timeCon2 = TextEditingController();
    DateTime dt1 = apptList[index].getAppt[0];// add condition for empty value
    TimeOfDay dt2 = apptList[index].getAppt[1];
    //if (dt1 != null)
    timeCon1.text = printDate(dt1);
    //if (dt2 != null)
    timeCon2.text = printTime(dt2);
    TimeOfDay t1, t2;
    DateTime d1;

    final now = new DateTime.now();
    bool timeChange1 = false; bool timeChange2 = false;
    return showDialog(context: context, builder: (context){
      return AlertDialog(

        title: Text("${apptList[index].getDogName}"),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,

          children:<Widget>[

            TextFormField(
              enableInteractiveSelection : false,
              controller: timeCon1,
              decoration: InputDecoration(
                //border: OutlineInputBorder(),
                labelText: 'Change Date',
              ),
              onTap: () async {
                TimeOfDay time = TimeOfDay.now(); //TimeOfDay.fromDateTime(dogList[index].getFeedTimings[0]);
                DateTime date = DateTime.now();
                FocusScope.of(context).requestFocus(new FocusNode());
                //timeChange1 = true;
                DateTime picked =
                await showDatePicker(context: context, initialDate: date, firstDate: DateTime.now(), lastDate:DateTime(2021),
                );
                if (picked != null) { //picked != time
                  setState(() {
                    //time = picked;
                    //t1 = time;
                    d1= picked;
                    dt1 = new DateTime(d1.year,d1.month,d1.day);
                    timeCon1.text = printDate(dt1);
                  });
                }
              },
            ),
            TextFormField(
              enableInteractiveSelection : false,
              controller: timeCon2,
              decoration: InputDecoration(
                //border: OutlineInputBorder(),
                labelText: 'Change Time',
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
                    dt2 = t2;
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
                apptList[index].setAllAppt = dtList;
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
        title: Text("Vet Appointment"),
      ),
      body: Container(
          child: Column(
            children: [
              Expanded(
                  child: Container(
                      child: ListView.separated(
                        padding: const EdgeInsets.all(8),
                        itemCount: apptList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                              height: 80,
                              color: Colors.blueAccent,
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
                                              '${apptList[index].getDogName}'),
                                          Text(
                                              'Appointment Date: ${apptList[index].printTime}'),

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
                                        apptList.removeAt(index);
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

String printTime(TimeOfDay time){
  String result;
  var hour;
  var minute;
  hour = int.parse("${time.hour}");
  minute = int.parse("${time.minute}");
  if (hour < 10) hour = hour.toString().padLeft(2, '0');
  if (minute <= 9) minute = minute.toString().padLeft(2, '0');

  result = "$hour:$minute";
  return result;
}

String printDate(DateTime dt){
  String result;
  var year;
  var month;
  var day;
  year = int.parse("${dt.year}");
  month = int.parse("${dt.month}");
  day = int.parse("${dt.day}");



  result = "$year:$month:$day";
  return result;
}





class Appointment{
  String dogName;
  String strDate="";
  String strTime="";
  List allAppt;


  Appointment(String dogName,  List allAppt){
    this.dogName = dogName;
    this.strDate = strDate;
    this.strTime = strTime;
    this.allAppt = allAppt;
  }

  String get getDogName{
    return dogName;
  }

  String get getStrDate{
    return strDate;
  }

  String get getStrTime{
    return strTime;
  }

  List get getAppt{
    return allAppt;
  }
  set setStrDate(String date){
    this.strDate = date;
  }

  set setStrTime (String time){
    this.strTime = time;
  }

  set setAllAppt (List allAppt){
    this.allAppt = allAppt;
  }

  set deleteAppt(int index){
    allAppt.removeAt(index);
    this.allAppt = allAppt;
  }
  String get printTime {
    //var period;


    var result;
    var hour;
    var minute;
    var year;
    var month;
    var day;
    /*for (var i = 0; i < allAppt.length; i++) {
      hour = int.parse("${allAppt[i].hour}");
      minute = int.parse("${allAppt[i].minute}");
      if (hour < 10) hour = hour.toString().padLeft(2, '0');
      if (minute <= 9) minute = minute.toString().padLeft(2, '0');

      result = "$hour:$minute";
      temp.add(result);
    }*/
    hour = int.parse("${allAppt[1].hour}");
    minute = int.parse("${allAppt[1].minute}");
    year = int.parse("${allAppt[0].year}");
    month = int.parse("${allAppt[0].month}");
    day = int.parse("${allAppt[0].day}");

    if (hour < 10) hour = hour.toString().padLeft(2, '0');
    if (minute <= 9) minute = minute.toString().padLeft(2, '0');

    result = "$year/$month/$day - $hour:$minute";

    return result;
  }





}



