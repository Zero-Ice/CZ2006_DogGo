import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:doggo/HotlineCreationClass.dart';

class fetchHotlineList {
  static List<HotlineCreation> sm = List<HotlineCreation>();

  getSPlist() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> spList = prefs.getStringList("hotlineData");
    sm = spList.map((index) => HotlineCreation.fromMap(json.decode(index))).toList();
    print(sm.length);
  }

  Widget hotlineList = Expanded(
      child: Container(
          child: ListView.separated(
            padding: const EdgeInsets.all(8),
            itemCount: sm.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                  //color: Colors.amber[colorCodes[index]],
                  child: Row(children: [
                    const SizedBox(width: 30),
                    Expanded(
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${sm[index].getName}',
                                style: TextStyle(fontSize: 15),
                              ),
                              Text('${sm[index].getHotline}',
                                style: TextStyle(fontSize: 10 ),
                              ),

                            ]))
                  ])
                //child: Center(child: Text('Dog ${entries[index]}')),
              );
            },
            separatorBuilder: (BuildContext context,
                int index) => const Divider(height: 5,),
          )));

  Widget emptyList = Container(
      child: Column(
          children: [
            SizedBox(height: 5,),
            Text("There are no Hotline added."),
          ]
      )
  );

  Widget run(){
    getSPlist();
    if(sm.length==0){
      return emptyList;
    }else{
      return hotlineList;
    }
  }
}
