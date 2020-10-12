
import 'package:doggo/Routes/vetRoutes/addVet.dart';
import 'package:doggo/Routes/vetRoutes/deleteVet.dart';
import 'package:doggo/Routes/vetRoutes/editVet.dart';

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
              Container(
                child: RaisedButton(
                    onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => AddVet()));},
                    child: Text('Add a vet appointment', style: TextStyle(fontSize: 20)),
                  )),
              const SizedBox(height: 20),
            Container(
              child: RaisedButton(
                onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => EditVet()));},
                child: Text('Edit an existing vet appointment', style: TextStyle(fontSize: 20)),
            )),
              const SizedBox(height: 20),
              Container(
                  child: RaisedButton(
                    onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => DeleteVet()));},
                    child: Text('Delete an existing vet appointment', style: TextStyle(fontSize: 20)),
                  )),
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

}
