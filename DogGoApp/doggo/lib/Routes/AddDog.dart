import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AddDog extends StatefulWidget {
  @override
  _AddDogState createState() => _AddDogState();
}

class _AddDogState extends State<AddDog> {
  String strDogName="";
  String strDogFood="";
  DateTime _dateTime;
  @override
  Widget build(BuildContext context) {

    /*
    Widget DOB = Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget> [
        Text(
        Text(
          'Date of Birth',
          style: TextStyle(fontSize: 20),
        ),
        SizedBox(width: 10,),
        Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: "Type in favourite food",
              ),
            )),
            ],
    );
     */
    var dogNameCon = TextEditingController();
    var dogFoodCon = TextEditingController();

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
                  child: Text((_dateTime == null? "chosen" :
                  _dateTime.toString()),
                ),),
              ],),

          ],
        ),
    );

    Widget calendarIcon = Container(
    );

    Widget saveButton = RaisedButton(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15)
      ),
      color: Colors.blue,
      textColor: Colors.white,
      child: Text( "Save",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold)),
      onPressed: (){
        Navigator.pop(context);
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
              SizedBox(height: 180,),
              saveButtonContainer,


          ],
          ),

        ),

      ),

    );
  }
}
