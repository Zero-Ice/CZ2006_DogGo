import 'package:doggo/Routes/AddDog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


class DogProfile extends StatefulWidget {
  @override
  _DogProfileState createState() => _DogProfileState();
}

class _DogProfileState extends State<DogProfile> {
  int i=0;

  @override
  Widget build(BuildContext context) {

    Widget addbutton=  FloatingActionButton(
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => AddDog()));
        setState((){
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
        child: Text("test2 5")
    );



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
            ]
        ),
      ),



      floatingActionButton: Container(
        height: 65.0,
        width: 65.0,
        child: FittedBox(
            child:addbutton),
      ),

      /*child:Align(
          alignment: Alignment.bottomRight,
          child:Padding(
              padding: const EdgeInsets.all(8.0),
              child: floatingActionButton
          ),)*/


    );
  }
}