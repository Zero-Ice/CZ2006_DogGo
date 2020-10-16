import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:doggo/DogCreationClass.dart';

class AddDogList {
   static List<DogCreation> sm = List<DogCreation>();

  getSPlist() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> spList = prefs.getStringList("dogData");
    sm = spList.map((index) => DogCreation.fromMap(json.decode(index))).toList();
    print(sm.length);
  }

  Widget dogList = Expanded(
      child: Container(
          child: ListView.separated(
            padding: const EdgeInsets.all(8),
            itemCount: sm.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                  height: 80,
                  //color: Colors.amber[colorCodes[index]],
                  child: Row(children: [
                    const SizedBox(width: 15),
                    CircleAvatar(
                      backgroundColor: Colors.grey[300],
                      backgroundImage: AssetImage('assets/ProfileIcon_Dog.png'),
                      radius: 35,
                    ),
                    const SizedBox(width: 30),
                    Expanded(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Dog: ${sm[index].getName}'),
                              SizedBox(height: 5,),
                              Text('Fav Food: ${sm[index].geFavFood}'),
                              SizedBox(height: 5,),
                              Text('Birthday: ${sm[index].getBirthDate}'),
                            ]))
                  ])
                //child: Center(child: Text('Dog ${entries[index]}')),
              );
            },
            separatorBuilder: (BuildContext context,
                int index) => const Divider(height: 20,),
          )));

   Widget emptyList = Container(
     child: Column(
         children: [
           SizedBox(height: 300,),
           Text("There are no dogs added."),
           SizedBox(height: 300,),
         ]
        )
   );

  Widget run(){
    getSPlist();
    if(sm.length==0){
      return emptyList;
    }else{
      return dogList;
    }
  }
}
