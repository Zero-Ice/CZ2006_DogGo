

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AddVet extends StatelessWidget {
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add an appointment"),
      ),
      body: Container(
          child: Column(
            children: [
              const SizedBox(height: 20),
              Container(
                  child: Column(
                    children: [
                      addVet,
                      SizedBox(height: 20,),


                    ],
                  ),

              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: RaisedButton(
                  onPressed: () {
                    // Navigate back to first screen when tapped.
                    Navigator.pop(context);
                  },
                  child: Text('Go back!'),
                ),
              )
            ],
          )),
    );
  }

  Widget addVet = Container(
    color: Colors.blue,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget> [
        Row(
          children: [
            Text(
              'Dog:',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(width: 10,),
            Expanded(child: TextField(
              controller: TextEditingController(),
              decoration: InputDecoration(
                hintText: "Which dog to bring",
              ),)),
          ],),

        Row(
          children: [
            Text(
              'Appointment date:',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(width: 10,),
            Expanded(child: TextField(
              controller: TextEditingController(),
              decoration: InputDecoration(
                hintText: "DD/MM/YYYY",
              ),)),
          ],),
        /////////////////////////////////
        Row(
          children: [
            Text(
              'Appointment time:',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(width: 10,),
            Expanded(
                child: TextField(
                  controller: TextEditingController(),
                  decoration: InputDecoration(
                    hintText: "HH:MM",
                  ),
                )),
          ],
        ),
        //////////////////////////////////////
        RaisedButton(
          onPressed: () {
            // Navigate back to first screen when tapped.
          },
          child: Text('Save'),
        ),

      ],
    ),
  );
}