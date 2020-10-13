import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// Widget Dog Profiles
// Have to reuse this in dog profile page.
final List<String> entries = <String>['A', 'B', 'C'];
final List<int> colorCodes = <int>[600, 500, 100];

Widget dogProfileComponent = Expanded(
    child: Container(
        child: ListView.separated(
  padding: const EdgeInsets.all(8),
  itemCount: entries.length,
  itemBuilder: (BuildContext context, int index) {
    return Container(
        height: 80,
        color: Colors.amber[colorCodes[index]],
        child: Row(children: [
          const SizedBox(width: 15),
          CircleAvatar(
            backgroundColor: Colors.white,
            backgroundImage: AssetImage('assets/ProfileIcon_Dog.png'),
            //child: Text('AH'),
          ),
          const SizedBox(width: 30),
          Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Text('Dog ${entries[index]}'),
                Text('Birthday: '),
                Text('Fav Food: ')
              ]))
        ])
        //child: Center(child: Text('Dog ${entries[index]}')),
        );
  },
  separatorBuilder: (BuildContext context, int index) => const Divider(),
)));
