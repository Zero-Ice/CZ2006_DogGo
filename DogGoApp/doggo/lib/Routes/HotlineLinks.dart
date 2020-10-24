import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:doggo/HotlineCreationClass.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class HotlineLinks extends StatefulWidget {
  @override
  _HotlineLinksState createState() => _HotlineLinksState();
}

class _HotlineLinksState extends State<HotlineLinks> {
  List<HotlineCreation> hotlineList = new List<HotlineCreation>();
  SharedPreferences prefs;



  @override
  void initState() {
    // TODO: implement initState
    initSP();
    super.initState();
  }

  void initSP()async{
    prefs = await SharedPreferences.getInstance();
    loadData();
  }

  void saveData(){
    List<String> spList = hotlineList.map((index) => json.encode(index.toMap())).toList();
    prefs.setStringList("hotlineData", spList);
    print(spList);
  }

  void loadData(){
    List<String> spList = prefs.getStringList("hotlineData");
    hotlineList = spList.map((index) => HotlineCreation.fromMap(json.decode(index))).toList();
    setState(() {});

  }




  Future _showAddForm(BuildContext context) async{
    TextEditingController nameCon = TextEditingController();
    TextEditingController hotlineCon = TextEditingController();

    return showDialog(context: context, builder: (context){
      bool enableSaveButton;
      bool isValidated(){
        setState(() {
          if(nameCon.text=="" || hotlineCon.text==""){
            enableSaveButton = false;
          }else{
            enableSaveButton = true;
          }
        });
        return enableSaveButton;
      }
      return AlertDialog(
            title: Text("Add HotLine"),
            content: SingleChildScrollView(
              child: Container(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      TextFormField(
                        autovalidate: true,
                        controller: nameCon,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "required";
                          } else {
                            return null;
                          }

                        },
                        decoration:
                            InputDecoration(labelText: "Name of Hotline"),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        autovalidate: true,
                        controller: hotlineCon,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "required";
                          } else {
                            return null;
                          }
                        },
                        decoration:
                            InputDecoration(labelText: "Hotline Link/Number"),
                      ),
                    ]),
              ),
            ),
            actions: <Widget>[
              MaterialButton(
                elevation: 5.0,
                child: Text("Cancel"),
                onPressed: () {
                  setState(() {});
                  Navigator.of(context).pop();
                },
              ),
              MaterialButton(
                elevation: 5.0,
                child: Text("Save"),
                onPressed:() {
                  if(isValidated()==true){
                    setState(() {
                      hotlineList.add(HotlineCreation(nameCon.text, hotlineCon.text));
                      saveData();
                    });
                    Navigator.of(context).pop();
                  }else{
                    return null;
                  }

                },
              )
            ],
          );
        });
  }

  Future<HotlineCreation>_showEditForm(int index){
    TextEditingController nameCon = TextEditingController();
    TextEditingController hotlineCon = TextEditingController();
    nameCon.text = "${hotlineList[index].getName}";
    hotlineCon.text = "${hotlineList[index].getHotline}";

    return showDialog(context: context, builder: (context){
      bool enableSaveButton;
      bool isValidated(){
        setState(() {
          if(nameCon.text=="" || hotlineCon.text==""){
            enableSaveButton = false;
          }else{
            enableSaveButton = true;
          }
        });
        return enableSaveButton;
      }
      return AlertDialog(

        title: Text("Edit Hotline"),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,

          children:<Widget>[
            TextFormField (
              autovalidate: true,
              controller: nameCon,
              validator: (value) {
                if (value.isEmpty) {
                  return "required";
                } else {
                  return null;
                }
              },
              decoration: InputDecoration(
                  labelText: "Name of Hotline"
              ),
            ),
            SizedBox(height: 15,),
            TextFormField (
              autovalidate: true,
              controller: hotlineCon,
              validator: (value) {
                if (value.isEmpty) {
                  return "required";
                } else {
                  return null;
                }
              },
              decoration: InputDecoration(
                  labelText: "Hotline Link/Number"
              ),
            ),
          ],
        ),

        actions:<Widget>[
          MaterialButton(
            elevation: 5.0,
            child: Text("Cancel"),
            onPressed: (){
              setState(() {
              });
              Navigator.of(context).pop();
            },
          ),
          MaterialButton(
            elevation: 5.0,
            child: Text("Save"),
            onPressed: (){
              if(isValidated()==true) {
                setState(() {
                  hotlineList[index].setName = nameCon.text;
                  hotlineList[index].setHotline = hotlineCon.text;
                  saveData();
                });
                Navigator.of(context).pop();
              }else{
                return null;
              }
            },
          )
        ],
      );
    });
  }


  @override
  Widget build(BuildContext context) {
    Widget addbutton=  FloatingActionButton(
      onPressed: ()  {
        setState((){
          _showAddForm(context);
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

    Widget hotlineListBuilder =  Expanded(
        child: Container(
            child: ListView.separated(
              padding: const EdgeInsets.all(15),
              itemCount: hotlineList.length,
              itemBuilder: (BuildContext context, int index){
                return Container(
                    child: Row(children: [
                      Expanded(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Name: ",
                                style: TextStyle(fontSize: 15,color: Colors.grey[500]),
                                ),
                                Text(
                                  '${hotlineList[index].getName}',
                                  style: TextStyle(fontSize: 23),
                                ),
                                SizedBox(height: 8,),
                                Text("Hotline:  ",
                                  style: TextStyle(fontSize: 15,color: Colors.grey[500] ),
                                ),
                                Text('${hotlineList[index].getHotline}',
                                  style: TextStyle(fontSize: 16 ),
                                ),

                              ])),
                      PopupMenuButton<int>(
                        onSelected: (val) { //1: edit, 2: delete
                          setState(() {
                            if (val == 1){
                              _showEditForm(index);
                            }
                            if (val == 2){ //add delete confirmation dialog
                              hotlineList.removeAt(index);
                              saveData();
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
                );
              },separatorBuilder: (BuildContext context, int index) => const Divider( height: 20,),
            )
        )
    );


    return Scaffold(
      appBar: AppBar(
        title: Text("HotlineLinks"),
      ),
      body: Center(
        child: Column(
            children: [
              hotlineListBuilder,
            ]
        ),
      ),
      floatingActionButton: Container(
        height: 65.0,
        width: 65.0,
        child: FittedBox(
            child:addbutton),
      ),
    );
  }
}