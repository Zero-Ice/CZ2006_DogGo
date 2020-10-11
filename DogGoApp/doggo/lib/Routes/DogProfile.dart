import 'package:doggo/Routes/AddDog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


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

    GoToAddDog(BuildContext context) async{
    final result =await Navigator.push(context,MaterialPageRoute<List<String>>(builder: (context) => AddDog()));
    txt=result;
    print(result);
    print(txt);
  }


  @override
  Widget build(BuildContext context) {

    Widget addbutton=  FloatingActionButton(
      onPressed: ()  {
        GoToAddDog(context);
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
        child:Column(
          children: [
            Text(txt==null?"null":txt[0]),
            Text(txt==null?"null":txt[1]),
            Text(txt==null?"null":txt[2]),

          ],
        )
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
    );
  }
}