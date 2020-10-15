import 'package:doggo/Routes/AddDog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:doggo/DogProfileComponent.dart';


class DogProfile extends StatefulWidget {
  List<String> data;
//  String txt;
  DogProfile({this.data});
  @override
  _DogProfileState createState() => _DogProfileState(data);
}

class _DogProfileState extends State<DogProfile> {
  int i=0;
  List<String> data;
  String dogName;
  String dogFavFood;
  String dogBirthdate;
  List l =List();
//  String txt;
  _DogProfileState(this.data);

    Future<List<String>> GoToAddDog(BuildContext context) async{
      List<String> result =await Navigator.push(context,MaterialPageRoute(builder: (context) => AddDog()));
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setStringList("key", result);
      List<String> share = prefs.getStringList("key");
      setState(() {
        data= share;
        dogName= data[0];
        dogFavFood=data[1];
        dogBirthdate=data[2];
        l.add(dogName);
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


    Widget dog1 = Container(
        child: Text('$i')
    );

    Widget dog2 = Container(
        child:Column(
          children: [
            Text(data==null?"null":data[0]),
            Text(data==null?"null":data[1]),
            Text(data==null?"null":data[2]),


          ],
        )
    );

    Widget userAdded = Expanded(
        child: Container(
            child: ListView.separated(
              padding: const EdgeInsets.all(8),
              itemCount: (data==null?0:1),
              itemBuilder: (BuildContext context, int index) {
                return Container(
                    height: 80,
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
                                Text('Dog : '+ data[0]),
                                SizedBox(height: 5,),
                                Text('Birthday: ' + data[2]),
                                SizedBox(height: 5,),
                                Text('Fav Food: '+ data[1])
                              ]))
                    ])
                  //child: Center(child: Text('Dog ${entries[index]}')),
                );
              },
              separatorBuilder: (BuildContext context, int index) => const Divider(),
            )));




    return Scaffold(
      appBar: AppBar(
        title: Text("DogProfile"),
      ),
      body: Center(
        child: Column(
            children: [
              const SizedBox(height: 20),
              dog1,
              const SizedBox(height: 20),
              dog2,
              const SizedBox(height: 20),
              dogProfileComponent,
              const SizedBox(height: 20),
              userAdded,
              ListView(shrinkWrap: true,children: l.map((e) => Text(dogName)).toList())



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