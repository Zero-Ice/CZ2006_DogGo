import 'dart:convert';
import 'dart:io';
import 'package:doggo/Routes/AddDog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:doggo/DogCreationClass.dart';

class DogProfile extends StatefulWidget {
  @override
  _DogProfileState dpState = new _DogProfileState();
  _DogProfileState createState() => dpState;

  addToDogList(List<String> result) {
    dpState.addToDogList(result[0],result[1],result[2], result[3]);
  }
}

class _DogProfileState extends State<DogProfile> {
  List<DogCreation> dogsList = List<DogCreation>();
  String dogName;
  String dogFavFood;
  String dogBirthdate;
  SharedPreferences prefs;
  String fileName = "";

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
    List<String> spList = dogsList.map((index) => json.encode(index.toMap())).toList();
    prefs.setStringList("dogData", spList);
  }

  void loadData(){
    List<String> spList = prefs.getStringList("dogData");
    dogsList = spList.map((index) => DogCreation.fromMap(json.decode(index))).toList();
    setState(() {});

  }


  // Future<List<String>> GoToAddDog(BuildContext context) async{
  //     List<String> result =await Navigator.push(context,MaterialPageRoute(builder: (context) => AddDog()));
  //     addToDogList(result[0],result[1],result[2]);
  // }
  void addToDogList(name,food,bday, fileName){
    print("Adding dog " + name + " " + fileName);
    setState(() {
      dogsList.add(DogCreation(name, food, bday, fileName));
      saveData();
    });

  }

  @override
  Widget build(BuildContext context) {

    // Widget addbutton=  FloatingActionButton(
    //   onPressed: ()  {
    //     setState((){
    //       GoToAddDog(context);
    //     });
    //   },
    //   child:
    //   Icon(
    //     Icons.add,
    //     size: 30,
    //   ),
    //   shape: RoundedRectangleBorder(
    //     borderRadius: BorderRadius.circular(50.0),
    //   ),
    // );

    void editDogList(index,name,food,bday, fileName){
      setState(() {
        dogsList[index].setName=name;
        dogsList[index].setFavFood=food;
        dogsList[index].setBirthDate=bday;
        dogsList[index].setFileName=fileName;
        saveData();
      });
    }

    void editForm(index) async{
      List<String> edited =await Navigator.push(context,MaterialPageRoute(builder: (context) => AddDog(
        eName: '${dogsList[index].getName}',
        eBday: '${dogsList[index].birthDate}',
        eFood: '${dogsList[index].favFood}',
        imgFileName: '${dogsList[index].getFileName}',)));
      if(edited == null || edited.length == 0) {
        print("MaterialPageRoute AddDog returned null edit");
        return;
      }
      editDogList(index,edited[0],edited[1],edited[2], edited[3]);
    }

    Future _showWalkDogForm(BuildContext context) async{
      return showDialog(context: context, builder: (context){
        return  AlertDialog(
          title:  Center(child: Text("Walk Dog already?")),
          content:
          Container(
            height: 100,
            width: 100,
            child: Column(
              children: [
                MaterialButton(
                  elevation: 5.0,
                  child: Text("Yes"),
                  onPressed: (){
                    print("walked");
                    setState(() {
                    });
                    Navigator.of(context).pop();
                  },
                ),
                MaterialButton(
                  elevation: 5.0,
                  child: Text("Not yet"),
                  onPressed: (){
                    setState(() {
                    });
                    Navigator.of(context).pop();
                  },
                )
              ],
            ),
          ),


        );
      });
    }
    Future _showFeedDogForm(BuildContext context) async{
      return showDialog(context: context, builder: (context){
        return  AlertDialog(
          title: Center(child: Text("Feed Dog already?")),
          content:
          Container(
            height: 100,
            width: 100,
            child: Column(
              children: [
                MaterialButton(
                  elevation: 5.0,
                  child: Text("Yes"),
                  onPressed: (){
                    print("fed");
                    setState(() {
                    });
                    Navigator.of(context).pop();
                  },
                ),
                MaterialButton(
                  elevation: 5.0,
                  child: Text("Not yet"),
                  onPressed: (){
                    setState(() {
                    });
                    Navigator.of(context).pop();
                  },
                )
              ],
            ),
          ),


        );
      });
    }

    Widget dogFeedAndWalkIcon = Row(
      children: [
        InkWell(child: Container(
          child: Row(
            children: [
              Icon(FontAwesomeIcons.dog,size: 22,),
              const SizedBox(width: 5),
              Text("| Walk"),
            ],
          ),
        ),
          onTap: (){
            _showWalkDogForm(context);
          },
        ),
        SizedBox(width: 15,),
        InkWell(
          child: Container(
            child: Row(
              children: [
                Icon(FontAwesomeIcons.bone,size: 19,),
                const SizedBox(width: 10),
                Text("| Feed"),
              ],
            ),
          ),
          onTap: (){
            _showFeedDogForm(context);
          },
        )
      ],
    );

    return Expanded(
        child: Container(
          child: ListView.separated(
            padding: const EdgeInsets.all(8),
            itemCount: dogsList.length,
            itemBuilder: (BuildContext context, int index){
            return Container(
              child: Column(
                children: [
                  Row(children: [
                    const SizedBox(width: 15),
                    CircleAvatar(
                    backgroundColor: Colors.grey[300],
                    // backgroundImage: AssetImage(dogsList[index].getFileName),
                    backgroundImage: FileImage(File(dogsList[index].getFileName)),
                    radius: 35,
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Dog: ${dogsList[index].getName}'),
                            SizedBox(height: 5,),
                            Text('Fav Food: ${dogsList[index].geFavFood}'),
                            SizedBox(height: 5,),
                            Text('Birthday: ${dogsList[index].getBirthDate}'),
                            SizedBox(height: 8,),
                            dogFeedAndWalkIcon,
                          ])),
                    PopupMenuButton<int>(
                      onSelected: (val) { //1: edit, 2: delete
                        setState(() {
                          if (val == 1){
                            loadData();
                            editForm(index);
                          }
                          if (val == 2){ //add delete confirmation dialog
                            loadData();
                            dogsList.removeAt(index);
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

                ]),
                  Row(
                    children: [

                    ],
                  )
                  ]
                )
              );
            },separatorBuilder: (BuildContext context, int index) => const Divider( height: 20,),
        )
        )
    );


    // return Scaffold(
    //   appBar: AppBar(
    //     title: Text("DogProfile"),
    //
    //   ),
    //   body: Center(
    //     child: Column(
    //         children: [
    //           dogListBuilder,
    //         ]
    //     ),
    //   ),
    //
    //
    //   floatingActionButton: Container(
    //     height: 65.0,
    //     width: 65.0,
    //     child: FittedBox(
    //         child:addbutton),
    //   ),
    // );
  }

}

