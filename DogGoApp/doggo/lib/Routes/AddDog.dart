import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;

class AddDog extends StatefulWidget {
  final String eName;
  final String eFood;
  final String eBday;
  String imgFileName = "";
  AddDog({this.eName,this.eFood,this.eBday, this.imgFileName});

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
  List<String> saveBt = ["","","",""];
  DateTime _dateTime;

  File _image;
  final picker = ImagePicker();
  String imgFileName;

  Future getImage() async {
    final imageFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (imageFile != null) {
        _image = File(imageFile.path);
      } else {
        print('No image selected.');
      }
    });

    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final fileName = path.basename(imageFile.path);
    final savedImage = await _image.copy('${appDir.path}/$fileName');
    print("Saving img with filename " + fileName);

    imgFileName = '${appDir.path}/$fileName';
  }

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
    imgFileName = "assets/ProfileIcon_Dog.png";

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
                  icon: Icon(Icons.calendar_today,color: Colors.grey[625],),
                  iconSize: 30,
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
        if(imgFileName==null){
          imgFileName="assets/ProfileIcon_Dog.png";
        }
        saveBt=[conDogName.text,conDogFood.text,"$strBirthday", imgFileName];
        // setState(() {
        //         //
        //         // });
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
      child: Row(
        children: [
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

    Widget getCircleAvatar() {
      print("Getting circle avatar");
      print(widget.imgFileName);
      if(_image == null && widget.imgFileName == null) {
        return new CircleAvatar(backgroundColor: Colors.grey[300],
            radius: 60.0,
            // backgroundImage: AssetImage(widget.imgFileName),
            child: Text("Select image"));
      } else {
        if(widget.imgFileName != null && widget.imgFileName.isNotEmpty) {
          return CircleAvatar(backgroundColor: Colors.grey[300],
            backgroundImage: AssetImage(widget.imgFileName),
            radius: 60.0,);
        } else {
          return CircleAvatar(
            backgroundColor: Colors.grey[300],
            // backgroundImage: AssetImage('assets/ProfileIcon_Dog.png'),
            backgroundImage:Image.file(_image).image,
            // child: ClipOval(child: _image == null ? Center(child: Text("No image selected")) : Image.file(_image)),

            radius: 60.0,);
        }
      }
    }

    Widget profileImage  = Container(
      child: Center(
          child: GestureDetector(
            onTap: () {
              getImage();
            },
            child:getCircleAvatar(),
          )
      )
    );


    return Scaffold(
      appBar: AppBar(
        title: Text("Add a Dog"),
      ),

      body: Padding(
        padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
        child: SingleChildScrollView(
          child: Container(
            //color: Colors.orange,
            child: Column(
              children: [
                SizedBox(height: 20,),
                profileImage,
                Divider( height:30,color: Colors.grey[600],),
                dogParticulars,
                SizedBox(height: 30,),
                buttonContainer,



            ],
            ),

          ),
        ),

      ),

    );
  }
}
