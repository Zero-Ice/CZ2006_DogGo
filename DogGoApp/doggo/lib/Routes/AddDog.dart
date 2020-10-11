import 'package:doggo/Routes/DogProfile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class AddDog extends StatefulWidget {
  @override
  _AddDogState createState() => _AddDogState();
}

class _AddDogState extends State<AddDog> {
  String strDogName="";
  String strDogFood="";
  String strDate="";
  List<String> saveBt = ["A","B","not"];
  DateTime _dateTime;

  @override
  Widget build(BuildContext context) {
    Widget dogParticulars = Container(
      color: Colors.yellow,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget> [
            Row(
              children: [
            Text(
              'Dog Name        ',
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
            )),
            ],),
            SizedBox(height: 20,),
            /////////////////////////////////
            Row(
              children: [
              Text(
                'Favourite Food',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(width: 10,),
              Expanded(
                  child: TextField(
                    decoration: InputDecoration(hintText: "Type in favourite food",),
                    onChanged: (String input){
                      setState(() {
                        strDogFood=input;
                      });
                    },
                  )),
              ],
            ),
            SizedBox(height: 20,),
            //////////////////////////////////////
            Row(
              children: [
                Text(
                  'Date of Birth',
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(width: 10,),
                IconButton(
                  icon: Icon(Icons.calendar_today,color: Colors.black,),
                  onPressed: (){
                    showDatePicker(
                        context: context,
                        initialDate: _dateTime== null ? DateTime.now(): _dateTime,
                        firstDate: DateTime(2000),
                        lastDate: DateTime.now()).then((date) { setState(() {_dateTime=date;});});
                  },
                ),
                Expanded(
                  child: Text((_dateTime == null? "chosen" : strDate = new DateFormat.yMd().format(_dateTime)),
                ),),
              ],),

          ],
        ),
    );


    Widget saveButton = RaisedButton(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15)
      ),
      color: Colors.blue,
      textColor: Colors.white,
      child: Text( "Save",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold)),
      onPressed: (){
        setState(() {
          saveBt=["$strDogName","$strDogFood","$strDate"];
        });
        Navigator.pop(context,saveBt);
      },
    );

    Widget saveButtonContainer =Container(
      alignment: Alignment.bottomRight,
      margin: const EdgeInsets.only(right: 10.0),

      child: SizedBox(
        height: 45,
        width: 100,
        child: saveButton
    ),);




    return Scaffold(
      appBar: AppBar(
        title: Text("Add a Dog"),
      ),

      body: Padding(
        padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
        child: Container(
          color: Colors.orange,
          child: Column(
            children: [
              SizedBox(height: 200,),
              dogParticulars,
              SizedBox(height: 20,),
              Text("Mybut: $strDogName"),
              SizedBox(height: 20,),
              Text("food: $strDogFood"),
              Text(saveBt[0]),
              Text(saveBt[1]),
              Text(saveBt[2]),
              saveButtonContainer,



          ],
          ),

        ),

      ),

    );
  }
}
