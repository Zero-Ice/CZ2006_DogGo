import 'package:doggo/Routes/AddDog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:doggo/DogProfileComponent.dart';


class DogProfile extends StatefulWidget {
  List<String> txt;
//  String txt;
  DogProfile({this.txt});
  @override
  _DogProfileState createState() => _DogProfileState(txt);
}

class _DogProfileState extends State<DogProfile> {
  int i=0;
  List<String> txt;
//  String txt;
  _DogProfileState(this.txt);

    Future<List<String>> GoToAddDog(BuildContext context) async{
      List<String> result =await Navigator.push(context,MaterialPageRoute(builder: (context) => AddDog()));
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setStringList("key", result);
      List<String> share = preferences.getStringList("key");
      txt= share;

//      print(txt==null?"null":txt);
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
            Text(txt==null?"null":txt[0]),
            Text(txt==null?"null":txt[1]),
            Text(txt==null?"null":txt[2]),

          ],
        )
    );

    Widget userAdded = Expanded(
        child: Container(
            child: ListView.separated(
              padding: const EdgeInsets.all(8),
              itemCount: (txt==null?0:1),
              itemBuilder: (BuildContext context, int index) {
                return Container(
                    height: 80,
                    child: Row(children: [
                      const SizedBox(width: 15),
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        backgroundImage: AssetImage('assets/ProfileIcon_Dog.png'),
                        //child: Text('AH'),
                      ),
                      const SizedBox(width: 30),
                      Expanded(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Dog : '+txt[0]),
                                Text('Birthday: '+txt[2]),
                                Text('Fav Food: '+txt[1])
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