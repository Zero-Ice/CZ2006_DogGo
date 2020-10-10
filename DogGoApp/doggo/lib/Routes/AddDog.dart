import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AddDog extends StatefulWidget {
  @override
  _AddDogState createState() => _AddDogState();
}

class _AddDogState extends State<AddDog> {
  @override
  Widget build(BuildContext context) {
    int i=0;
    int j=0;
    /*
    Widget DOB = Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget> [
        Text(
        Text(
          'Date of Birth',
          style: TextStyle(fontSize: 20),
        ),
        SizedBox(width: 10,),
        Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: "Type in favourite food",
              ),
            )),
            ],
    );
     */
    var dogNameCon = TextEditingController();
    var dogFoodCon = TextEditingController();
    var dogName = "dog name";
    var dogFood ="dog food";

    Widget dogParticulars = Container(
      color: Colors.yellow,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget> [
            Row(
              children: [
            Text(
              'Dog Name        ',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(width: 10,),
            Expanded(child: TextField(
              controller: dogNameCon,
              decoration: InputDecoration(
                hintText: "Type in Dog name",
              ),)),
            ],),
            /////////////////////////////////
            Row(
              children: [
              Text(
                'Favourite Food',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(width: 10,),
              Expanded(
                  child: TextField(
                    controller: dogFoodCon,
                    decoration: InputDecoration(
                      hintText: "Type in favourite food",
                    ),
                  )),
              ],
            ),
            //////////////////////////////////////


          ],
        ),
    );

    Widget dogImage = Container(

    );

    Widget saveButton = FlatButton(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15)
      ),
      color: Colors.blue,
      textColor: Colors.white,
      child: Text( "Save",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold)),
      onPressed: (){
        setState(() {
          i+=1;
          dogName=dogNameCon.text;
          dogFood=dogFoodCon.text;
        });
      },
    );

    Widget saveButtonContainer =Container(
      alignment: Alignment.bottomRight,
      margin: const EdgeInsets.only(right: 10.0),

      child: SizedBox(
        height: 45,
        width: 100,
        child: saveButton
    ),);




    return Scaffold(
      appBar: AppBar(
        title: Text("Add a Dog"),
      ),

      body: Padding(
        padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
        child: Container(
          color: Colors.orange,
          child: Column(
            children: [
              dogParticulars,
              SizedBox(height: 20,),
              saveButtonContainer,
              SizedBox(height: 20,),
              Text("Test: $i"),
              SizedBox(height: 20,),
              Text("Mybut: $dogName")

          ],
          ),

        ),

      ),

    );
  }
}
