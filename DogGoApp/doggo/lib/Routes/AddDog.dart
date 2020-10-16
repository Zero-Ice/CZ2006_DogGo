import 'package:doggo/Routes/DogProfile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class AddDog extends StatefulWidget {
  final String eName;
  final String eFood;
  final String eBday;
  AddDog({this.eName,this.eFood,this.eBday});

  @override
  _AddDogState createState() => _AddDogState();
}

class _AddDogState extends State<AddDog> {
  String strDogName="";
  String strDogFood="";
  String strBirthday="Not Specified";
  TextEditingController conDogName;
  TextEditingController conDogFood;
  TextEditingController conBday;
  List<String> saveBt = ["","",""];
  DateTime _dateTime;

  Widget dateTextHandling(){
    if(conBday.text=="" || conBday.text=="Not Specified"){
      return Text("Not Specfied",style: TextStyle(color: Colors.grey[600]),);
    }else{
      return Text(conBday.text);
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    conDogName = TextEditingController(text: widget.eName);
    conDogFood = TextEditingController(text: widget.eFood);
    conBday = TextEditingController(text: widget.eBday);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Widget dogParticulars = Container(
      //color: Colors.yellow,
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
              controller: conDogName,
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
                    controller: conDogFood,
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
                  child:
                    (_dateTime == null?
                    //null
                    dateTextHandling() :
                    //date
                    Text(strBirthday = new DateFormat.yMd().format(_dateTime))
                    ),
                ),
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
          saveBt=[conDogName.text,conDogFood.text,"$strBirthday"];
        });
        Navigator.pop(context,saveBt);
      },
    );

    Widget cancelButton = RaisedButton(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15)
      ),
      color: Colors.blue,
      textColor: Colors.white,
      child: Text( "Cancel",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold)),
      onPressed: (){
        Navigator.pop(context);
      },
    );


    Widget buttonContainer =Container(
        alignment: Alignment.bottomRight,
     // margin: const EdgeInsets.only(right: 10.0),

      child: Row(
        children: [
          SizedBox(width: 185,),
        SizedBox(
            height: 45,
            width: 100,
            child: cancelButton),
          SizedBox(width: 10,),
          SizedBox(
              height: 45,
              width: 100,
              child: saveButton),
        ]
      ));

    Widget profileImage  = Container(
      child: Center(
          child: CircleAvatar(
                    backgroundColor: Colors.grey[300],
                    backgroundImage: AssetImage('assets/ProfileIcon_Dog.png'),
                    radius: 60.0,)
      )
    );


    return Scaffold(
      appBar: AppBar(
        title: Text("Add a Dog"),
      ),

      body: Padding(
        padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
        child: Container(
          //color: Colors.orange,
          child: Column(
            children: [
              SizedBox(height: 20,),
              profileImage,
              Divider( height:30,color: Colors.grey[600],),
              dogParticulars,
              SizedBox(height: 20,),
//              Text("Mybut: $strDogName"),
//              SizedBox(height: 20,),
//              Text("food: $strDogFood"),
//              Text(saveBt[0]),
//              Text(saveBt[1]),
//              Text(saveBt[2]),
              SizedBox(height: 30,),
              buttonContainer,



          ],
          ),

        ),

      ),

    );
  }
}
