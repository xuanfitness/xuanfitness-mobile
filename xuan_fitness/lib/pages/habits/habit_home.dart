import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class HabitsHome extends StatefulWidget {
  @override
  HabitsHomeState createState() => new HabitsHomeState();
}

class HabitsHomeState extends State<HabitsHome> {
  TextEditingController q1 = TextEditingController();
  TextEditingController q2 = TextEditingController();
  TextEditingController q3 = TextEditingController();
  TextEditingController q4 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(20),
          child: ListView(children: <Widget>[
            Container(
                padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                          width: 1.0,
                          //height: 1.0,
                          color: Colors.lightGreen[900])),
                ),
                child: TextField(
                  obscureText: true,
                  controller: q1,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'How much water did you drink today?',
                    hintStyle: TextStyle(color: Colors.lightGreen[900]),
                  ),
                )),
            Container(
                padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                          width: 1.0,
                          //height: 1.0,
                          color: Colors.lightGreen[900])),
                ),
                child: TextField(
                  obscureText: true,
                  controller: q2,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Did you practice basketball today?',
                    hintStyle: TextStyle(color: Colors.lightGreen[900]),
                  ),
                )),
            Container(
                padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                          width: 1.0,
                          //height: 1.0,
                          color: Colors.lightGreen[900])),
                ),
                child: TextField(
                  obscureText: true,
                  controller: q3,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'What made you smile today?',
                    hintStyle: TextStyle(color: Colors.lightGreen[900]),
                  ),
                )),
            Container(
                padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                          width: 1.0,
                          //height: 1.0,
                          color: Colors.lightGreen[900])),
                ),
                child: TextField(
                  obscureText: true,
                  controller: q4,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Did you practice piano today?',
                    hintStyle: TextStyle(color: Colors.lightGreen[900]),
                  ),
                )),
          ]),
        ),
      ),
    );
  }
}
