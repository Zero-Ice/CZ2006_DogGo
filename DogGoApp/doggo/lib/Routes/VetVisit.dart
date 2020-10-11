

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class VetVisit extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Vet Visit"),
      ),
      body: Container(
          child: Column(
            children: [
              const SizedBox(height: 20),
              addVisit,
              const SizedBox(height: 20),
              editVisit,
              const SizedBox(height: 20),
              delVisit,
              const SizedBox(height: 20),
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
  Widget addVisit = Container(
      child: RaisedButton(
        onPressed: () {},
        child: Text('Add a timing for vet appointment', style: TextStyle(fontSize: 20)),
      ));
  Widget editVisit = Container(
      child: RaisedButton(
        onPressed: () {},
        child: Text('Edit an existing vet appointment', style: TextStyle(fontSize: 20)),
      ));
  Widget delVisit = Container(
      child: RaisedButton(
        onPressed: () {},
        child: Text('Delete an existing vet appointment', style: TextStyle(fontSize: 20)),
      ));
}
