import 'dart:convert';
import 'package:doggo/Routes/AddDog.dart';
import 'package:doggo/SavedDogList.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:doggo/DogCreationClass.dart';


class DogProfile extends StatefulWidget {
  final List<String> addedData;
  DogProfile({this.addedData});
  @override
  _DogProfileState createState() => _DogProfileState(addedData);
}

class _DogProfileState extends State<DogProfile> {
  int i=0;
  int j =0;
  List<DogCreation> dogsList = List<DogCreation>();
  List<String> addedData;
  String dogName;
  String dogFavFood;
  String dogBirthdate;
  List l =List();
  SharedPreferences prefs;
  _DogProfileState(this.addedData);

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


  Future<List<String>> GoToAddDog(BuildContext context) async{
      List<String> result =await Navigator.push(context,MaterialPageRoute(builder: (context) => AddDog()));
      addToDogList(result[0],result[1],result[2]);
  }
  void addToDogList(name,food,bday){
    setState(() {
      dogsList.add(DogCreation(name, food, bday));
      saveData();
    });

  }

  @override
  Widget build(BuildContext context) {

    Widget addbutton=  FloatingActionButton(
      onPressed: ()  {
        setState((){
          GoToAddDog(context);
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

    void editDogList(index,name,food,bday){
      setState(() {
        dogsList[index].setName=name;
        dogsList[index].setFavFood=food;
        dogsList[index].setBirthDate=bday;
        saveData();
      });
    }

    void editForm(index) async{
      List<String> edited =await Navigator.push(context,MaterialPageRoute(builder: (context) => AddDog(
        eName: '${dogsList[index].getName}',
        eBday: '${dogsList[index].birthDate}',
        eFood: '${dogsList[index].favFood}',)));
      editDogList(index,edited[0],edited[1],edited[2]);
    }


    Widget dogListBuilder =  Expanded(
        child: Container(
          child: ListView.separated(
            padding: const EdgeInsets.all(8),
            itemCount: dogsList.length,
            itemBuilder: (BuildContext context, int index){
            return Container(
              height: 80,
              //color: Colors.amber[colorCodes[index]],
              child: Row(children: [
                const SizedBox(width: 15),
                CircleAvatar(
                  backgroundColor: Colors.grey[300],
                  backgroundImage: AssetImage('assets/ProfileIcon_Dog.png'),
                  radius: 35,
                  //child: Text('AH'),
                ),
                const SizedBox(width: 30),
                Expanded(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Dog: ${dogsList[index].getName}'),
                          SizedBox(height: 5,),
                          Text('Fav Food: ${dogsList[index].geFavFood}'),
                          SizedBox(height: 5,),
                          Text('Birthday: ${dogsList[index].getBirthDate}'),
                          SizedBox(height: 5,),
                        ])),
                PopupMenuButton<int>(
                  onSelected: (val) { //1: edit, 2: delete
                    setState(() {
                      if (val == 1){
                        editForm(index);
                      }
                      if (val == 2){ //add delete confirmation dialog
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
              ])
          );
            },separatorBuilder: (BuildContext context, int index) => const Divider( height: 20,),
        )
        )
    );


    return Scaffold(
      appBar: AppBar(
        title: Text("DogProfile"),
      ),
      body: Center(
        child: Column(
            children: [
              dogListBuilder,
              AddDogList().run()
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

