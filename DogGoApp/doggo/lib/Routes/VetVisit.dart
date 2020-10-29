
import 'dart:convert';
import 'dart:io';
import 'package:doggo/Notification.dart';
import 'package:doggo/Routes/vetRoutes/addVet.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:doggo/DogCreationClass.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';



var vDate=new DateTime(2020,1, 1, 9, 0);
var vTime = new TimeOfDay(hour: 00, minute: 00);
List vDateTime = [vDate, vTime];

List<DogCreation> dogsList = List<DogCreation>();





class VetVisit extends StatefulWidget{
  @override
  _VetVisitState createState() => _VetVisitState();
}

class _VetVisitState extends State<VetVisit> {
  int i = 0;
  int j = 0;
  String dogName;
  String newDate;
  String newTime;
  List l =List();
  List<dynamic> data;
  List<DogCreation> dogsList = List<DogCreation>();
  List<Appointment> apptList = [];
  SharedPreferences prefs;
  int currentID;
  var rng = new Random();
  bool expired = false;
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
    for (int i = 0; i < apptList.length; i++){
      List temp = new List<String>();
      temp.add(apptList[i].getAppt[0].toString());
      temp.add(todToStr(apptList[i].getAppt[1]));
      apptList[i].setAllAppt = temp;
    }
    List<String> spList = apptList.map((index) => json.encode(index.toMap()))
        .toList();
    prefs.setStringList("vetData", spList);

  }

  void loadData() {
    //get image from dog class
    List<String> dog = prefs.getStringList("dogData");
    dogsList = dog.map((index) => DogCreation.fromMap(json.decode(index))).toList();


    List<String> spList = prefs.getStringList("vetData");
    apptList =
        spList.map((index) => Appointment.fromMap(json.decode(index))).toList();
    for (int i = 0; i < apptList.length; i++){
      List temp = new List<dynamic>();
      temp.add(DateTime.parse(apptList[i].getAppt[0]));
      temp.add(strToTOD(apptList[i].getAppt[1]));
      apptList[i].setAllAppt = temp;
    }

    setState(() {});
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
  dynamic getImage(String dogName){
    try{
      for (int i = 0; i < dogsList.length; i++){
        print(dogsList[i].getName);
        if (dogsList[i].getName == dogName){
          return FileImage(File(dogsList[i].getFileName));
        }
      }
    }
    on RangeError catch (e){
      print(e);
    }

  }
  tz.TZDateTime notiDT(int year, int month, int day, int hour, int minute){
    tz.TZDateTime scheduledDate =
    tz.TZDateTime(tz.local, year, month, day, hour, minute);
    return scheduledDate;
  }
  bool checkFuture(int year, int month, int day, int hour, int minute){
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    DateTime temp = DateTime(year, month, day, hour, minute);
    if (temp.isAfter(now)){
      return true;
    }
    return false;
  }

  // TimeOfDay _time = TimeOfDay.now();
  // Future<Null> selectTime(BuildContext context) async {
  //   TimeOfDay selectedTime = await showTimePicker(
  //     context: context,
  //     initialTime: _time,
  //   );
  // }
  Future<Appointment>_showEditForm(int index){
    TextEditingController timeCon1 = TextEditingController();
    TextEditingController timeCon2 = TextEditingController();
    DateTime dt1;
    TimeOfDay dt2;
    dogName = apptList[index].getDogName;
    try{
      currentID = apptList[index].getNotificationID;
    }
    on FormatException catch (e){
      print(e);
    }
    try{
      dt1 = apptList[index].getAppt[0];// add condition for empty value
      dt2 = apptList[index].getAppt[1];
      timeCon1.text = printDate(dt1);
      timeCon2.text = printTime(dt2);
      final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
      DateTime temp = DateTime(dt1.year, dt1.month, dt1.day, dt2.hour, dt2.minute);
      if (temp.isAfter(now)) {
        expired = true;
      }
    }
    on RangeError catch (e) {
      print(e);
    }
    on NoSuchMethodError catch (e) {
      print("editform");
      print(e);
    }
    on FormatException catch (e) {
      print(e);
    }

    TimeOfDay t1, t2;
    DateTime d1;

    // final now = new DateTime.now();
    // bool timeChange1 = false; bool timeChange2 = false;
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
              if (checkFuture(dt1.year, dt1.month, dt1.day, dt2.hour, dt2.minute) == false){
                return "appointment date must be in the future";
              }
              setState(() {
                cancelNoti(currentID);
                int randomID = rng.nextInt(900000) + 100000;
                List dtList= [dt1,dt2];
                apptList[index].setAllAppt = dtList;
                apptList[index].setNotificationID = randomID;
                scheduleNotification(randomID, "$dogName"
                    ,notiDT(dt1.year, dt1.month, dt1.day, dt2.hour, dt2.minute));
                saveData();
                loadData();
              });
              Navigator.of(context).pop();
            },
          )
        ],
      );
    });
  }


  /*Future<List<String>> GoToAddVet(BuildContext context) async{
    List<dynamic> result =await Navigator.push(context,MaterialPageRoute(builder: (context) => AddVet()));
    SharedPreferences prefs1 = await SharedPreferences.getInstance();
    String dogName1 = result[0];
    List newDateTime = [result[1],result[2]];
    var newAppt = new Appointment(dogName1,newDateTime);
    apptList.add(newAppt);
    prefs1.setStringList(j.toString(), result);
    List<dynamic> share = prefs1.getStringList(j.toString());
    j++;
    setState(() {
      data= share;
      dogName= data[0];
      newDate=data[1];
      newTime=data[2];
      l.add(data);
      print(prefs1.get("0"));
      print(prefs1.get("1"));
      print(l);
    });
  }
  */
  Future<List<String>> GoToAddVet(BuildContext context) async{
    List<dynamic> result =await Navigator.push(context,MaterialPageRoute(builder: (context) => AddVet()));
   // print(result[0]);
    //print(result[1]);
   // print(result[2]);

    setState(() {
      int randomID = rng.nextInt(900000) + 100000;
      String dogName1 = result[0].toString();
      DateTime newDate = DateTime.parse(result[1]);
      TimeOfDay newTime = TimeOfDay(hour:int.parse(result[2].split(":")[0]),minute: int.parse(result[2].split(":")[1]));
      List newDateTime = [newDate, newTime];
      scheduleNotification(randomID, "$dogName1"
          , notiDT(newDate.year, newDate.month, newDate.day, newTime.hour, newTime.minute));
      Appointment newAppt = new Appointment(dogName1,newDateTime, randomID);
      apptList.add(newAppt);
      saveData();
      loadData();
    });
  }

  @override
  Widget build(BuildContext context) {

    Widget addbutton=  FloatingActionButton(
      onPressed: ()  {
        setState((){
          GoToAddVet(context);
          i+=1;
        });
      },
      child:
      Icon(
        Icons.add,
        size: 30,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50.0),
      ),


    );
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
                              //color: Colors.blueAccent,
                              child: Row(children: [
                                const SizedBox(width: 15),
                                CircleAvatar(
                                  backgroundColor: Colors.grey[300],
                                  backgroundImage: getImage(apptList[index].getDogName),
                                  radius: 35,
                                  //child: Text('AH'),
                                ),
                                const SizedBox(width: 30),

                                Expanded(
                                    child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              '${apptList[index].getDogName}'),
                                          SizedBox(height: 5,),
                                          Text(
                                              'Appointment Date: '),
                                          SizedBox(height: 5,),
                                          Text('${apptList[index].printDateTime}',
                                              style: TextStyle(
                                                  decoration: checkFuture(apptList[index].getAppt[0].year, apptList[index].getAppt[0].month,
                                                      apptList[index].getAppt[0].day, apptList[index].getAppt[1].hour, apptList[index].getAppt[0].minute) ?
                                                  TextDecoration.none : TextDecoration.lineThrough
                                              ),),

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
                                        cancelNoti(apptList[index].getNotificationID);
                                        apptList.removeAt(index);
                                        saveData();
                                        loadData();
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
                        const Divider(height: 20,),
                      )))
            ],
          )),

        floatingActionButton: Container(
          height: 65.0,
          width: 65.0,
          child: FittedBox(
              child:addbutton),
        ));
  }

}



String printTime(TimeOfDay time){
  String result;
  var hour;
  var minute;
  try{
    hour = int.parse("${time.hour}");
    minute = int.parse("${time.minute}");
    if (hour < 10) hour = hour.toString().padLeft(2, '0');
    if (minute <= 9) minute = minute.toString().padLeft(2, '0');

    result = "$hour:$minute";
    return result;
  }
  on NoSuchMethodError catch (e) {
    print("printTime");
    print(e);
  }


}

String printDate(DateTime dt){
  String result;
  var year;
  var month;
  var day;
  try{
    year = int.parse("${dt.year}");
    month = int.parse("${dt.month}");
    day = int.parse("${dt.day}");
    result = "$year:$month:$day";
    return result;
  }

  on NoSuchMethodError catch (e) {
    print("printDate");
    print(e);
  }


}





class Appointment{
  String dogName;
  String strDate="";
  String strTime="";
  List allAppt;
  int notificationID;


  Appointment(String dogName,  List allAppt, int notificationID){
    this.dogName = dogName;
    this.strDate = strDate;
    this.strTime = strTime;
    this.allAppt = allAppt;
    this.notificationID = notificationID;
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

  int get getNotificationID{
    return notificationID;
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
  set setNotificationID(int notificationID){
    this.notificationID = notificationID;
  }
  set deleteAppt(int index){
    allAppt.removeAt(index);
    this.allAppt = allAppt;
  }
  String get printDateTime {
    //var period;


    var result;
    var hour;
    var minute;
    var year;
    var month;
    var day;
    try{
      year = int.parse("${allAppt[0].year}");
      month = int.parse("${allAppt[0].month}");
      day = int.parse("${allAppt[0].day}");
      hour = int.parse("${allAppt[1].hour}");
      minute = int.parse("${allAppt[1].minute}");


      if (hour < 10) hour = hour.toString().padLeft(2, '0');
      if (minute <= 9) minute = minute.toString().padLeft(2, '0');

      result = "$year/$month/$day - $hour:$minute";

      return result;
    }
    on NoSuchMethodError catch (e) {
      print("printDateTime");
      print(e);
    }



  }

  Appointment.fromMap(Map<String, dynamic> map){
    this.dogName = map['dogName'];
    this.allAppt = map['allAppt'];
    this.notificationID = map['notificationID'];
  }

  Map<String, dynamic>toMap() {
    return {
      'dogName': this.dogName,
      'allAppt': this.allAppt,
      'notificationID': this.notificationID,
    };
  }



}



