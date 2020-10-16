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
  }

  Widget dogGo = Expanded(
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
                              Text('Fav Food: ${sm[1].geFavFood}'),
                              SizedBox(height: 5,),
                              Text('Birthday: ${sm[1].getBirthDate}'),
                            ]))
                  ])
                //child: Center(child: Text('Dog ${entries[index]}')),
              );
            },
            separatorBuilder: (BuildContext context,
                int index) => const Divider(height: 20,),
          )));
  Widget run(){
    getSPlist();
    return dogGo;
  }
}
