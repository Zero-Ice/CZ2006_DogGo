

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DogProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    Widget addbutton=  FloatingActionButton(
      onPressed: () {},
      child:
      Text('+',
        style: TextStyle(
            fontSize: 28.0,
            shadows: <Shadow>[Shadow(
                offset: Offset(1.0, 2.0),
                blurRadius: 3.0,
                color: Colors.black45)]),
      ),
    );


    Widget dog1 = Container(
        child: Text("Test Pull req")
    );

    Widget dog2 = Container(
        child: Text("hi")
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