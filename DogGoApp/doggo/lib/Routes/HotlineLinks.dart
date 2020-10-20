import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HotlineLinks extends StatefulWidget {
  @override
  _HotlineLinksState createState() => _HotlineLinksState();
}

class _HotlineLinksState extends State<HotlineLinks> {

  Future<String> _showForm(BuildContext context) async{
    TextEditingController nameCon = TextEditingController();
    TextEditingController hotlineCon = TextEditingController();
    return showDialog(context: context, builder: (context){
      return AlertDialog(
          title: Text("Add HotLine"),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextFormField (
                controller: nameCon,
                decoration: InputDecoration(
                    labelText: "Name of Hotline"
                ),
            ),
            SizedBox(height: 15,),
            TextFormField (
              controller: hotlineCon,
              decoration: InputDecoration(
                  labelText: "Hotline Link"
              ),
            ),
          ]
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
              setState(() {
              });
              Navigator.of(context).pop();
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
          _showForm(context);
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

    return Scaffold(
      appBar: AppBar(
        title: Text("HotlineLinks"),
      ),
      body: Center(
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