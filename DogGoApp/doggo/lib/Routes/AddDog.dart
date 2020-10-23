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
  final String imgFileName;
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
  bool enableSaveButton;

  // Image picker variables
  PickedFile _imageFile;
  dynamic _pickImageError;
  String _retrieveDataError;
  final ImagePicker _picker = ImagePicker();

  String imgFileName;

  Future getImage() async {
    final pickedFile = await _picker.getImage(source: ImageSource.gallery);

    bool picked = false;
    setState(() {
      if (pickedFile != null) {
        picked = true;
        _imageFile = pickedFile;
      } else {
        print('No image selected.');
      }
    });

    if(picked) {
      final appDir = await syspaths.getApplicationDocumentsDirectory();
      final fileName = path.basename(pickedFile.path);
      final savedImage = await File(pickedFile.path).copy(
          '${appDir.path}/$fileName');
      print("Saving img with filename " + fileName);

      imgFileName = '${appDir.path}/$fileName';
    }
  }

  Future saveImage() async {
    if(_imageFile != null) {
      print("SAVING IMAGE");
      final appDir = await syspaths.getApplicationDocumentsDirectory();
      final fileName = path.basename(_imageFile.path);
      final savedImage = await File(_imageFile.path).copy(
          '${appDir.path}/$fileName');
      print("Saving img with filename " + fileName);

      imgFileName = '${appDir.path}/$fileName';
    }
  }

  Future<void> retrieveLostData() async {
    final LostData response = await _picker.getLostData();
    if (response.isEmpty) {
      return;
    }
    bool isVideo;
    if (response.file != null) {
      if (response.type == RetrieveType.video) {
        isVideo = true;
      } else {
        isVideo = false;
        setState(() {
          _imageFile = response.file;
        });
      }
    } else {
      _retrieveDataError = response.exception.code;
    }
  }

  Widget _previewImage() {
    final Text retrieveError = _getRetrieveErrorWidget();
    if (retrieveError != null) {
      return retrieveError;
    }
    if (_imageFile != null) {
      return GestureDetector(
        onTap: () {
          getImage();
        },
        child: CircleAvatar(
          backgroundImage: FileImage(File(_imageFile.path)),
          radius: 60.0,
        ),
      );
    } else if (_pickImageError != null) {
      return Text(
        'Pick image error: $_pickImageError',
        textAlign: TextAlign.center,
      );
    } else {
      return GestureDetector(
        onTap: () {
          getImage();
        },
        child: CircleAvatar(
          backgroundColor: Colors.grey[300],
          radius: 60.0,
          child: const Text(
            'You have not yet picked an image.',
            textAlign: TextAlign.center,
          ),
        ),
      );
    }
  }

  Text _getRetrieveErrorWidget() {
    if (_retrieveDataError != null) {
      final Text result = Text(_retrieveDataError);
      _retrieveDataError = null;
      return result;
    }
    return null;
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
    print("INIT ADD DOG");
    conDogName = TextEditingController(text: widget.eName);
    conDogFood = TextEditingController(text: widget.eFood);
    conBday = TextEditingController(text: widget.eBday);
    _imageFile = null;
    imgFileName = "";
    if(widget.imgFileName != null) {
      imgFileName = widget.imgFileName;
    }

    if(imgFileName.isNotEmpty) {
      print("imgFileName: " + imgFileName);
    } else {
      print("imgFileName is empty");
    }

    super.initState();
  }

  bool hasDogName(){
    setState(() {
      if(conDogName.text==""){
        enableSaveButton = false;
      }else{
        enableSaveButton = true;
      }
    });
    return enableSaveButton;
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
              Expanded(child: TextFormField(
              autovalidate: true,
              decoration: InputDecoration(hintText: "Type in Dog name",),
              validator: (value){
                if(value.isEmpty){
                  return "required to save";
                }else{
                  return null;
                }
              },
              controller: conDogName,
              onChanged: (val){
                hasDogName();
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
      onPressed: hasDogName()?(){
      if(imgFileName==null){
        imgFileName="";
      }
      saveBt=[conDogName.text,conDogFood.text,"$strBirthday", imgFileName];
      saveImage();
      // setState(() {
      //         //
      //         // });
      Navigator.pop(context,saveBt);
    }:null,
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

    Widget addDogProfileImage  = Container(
      child: Center(
          child: FutureBuilder<void>(
            future: retrieveLostData(),
            builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                  return CircleAvatar(
                    backgroundColor: Colors.grey[300],
                    radius: 60.0,
                    child: const Text(
                      'You have not yet picked an image.',
                      textAlign: TextAlign.center,
                    ),
                  );
                case ConnectionState.done:
                  return _previewImage();
                default:
                  if (snapshot.hasError) {
                    return Text(
                      'Pick image error: ${snapshot.error}}',
                      textAlign: TextAlign.center,
                    );
                  } else {
                    return GestureDetector(
                      onTap: () {
                        getImage();
                      },
                      child: CircleAvatar(
                        backgroundColor: Colors.grey[300],
                        radius: 60.0,
                        child: const Text(
                          'You have not yet picked an image.',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  }
              }
            },
          ),
    ));

    Widget displayDogProfileImage = Container(
      child: Center(
        child: GestureDetector(
            onTap: () {
              getImage();
            },
          child: CircleAvatar(
            // backgroundImage: AssetImage(imgFileName),
            backgroundImage: FileImage(File(imgFileName)),
            radius: 60.0
          )
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
                imgFileName == null || imgFileName == ""?
                addDogProfileImage :
                displayDogProfileImage,
                // addDogProfileImage,
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
