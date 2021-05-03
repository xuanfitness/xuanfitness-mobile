import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HabitsHome extends StatefulWidget {
  @override
  HabitsHomeState createState() => new HabitsHomeState();
}

class HabitsHomeState extends State<HabitsHome> {
  TextEditingController q1 = TextEditingController();
  TextEditingController q2 = TextEditingController();
  TextEditingController q3 = TextEditingController();
  TextEditingController q4 = TextEditingController();

  static String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

  static final dateFormatter = DateFormat('yyyy-MM-dd');

  static DateTime today_7 = DateTime.now().subtract(new Duration(days: 7));
  static DateTime today_6 = DateTime.now().subtract(new Duration(days: 6));
  static DateTime today_5 = DateTime.now().subtract(new Duration(days: 5));
  static DateTime today_4 = DateTime.now().subtract(new Duration(days: 4));
  static DateTime today_3 = DateTime.now().subtract(new Duration(days: 3));
  static DateTime today_2 = DateTime.now().subtract(new Duration(days: 2));
  static DateTime today_1 = DateTime.now().subtract(new Duration(days: 1));
  static String today = dateFormatter.format(today_1);
  static String today1 = dateFormatter.format(today_2);
  static String today2 = dateFormatter.format(today_3);
  static String today3 = dateFormatter.format(today_4);
  static String today4 = dateFormatter.format(today_5);
  static String today5 = dateFormatter.format(today_6);
  static String today6 = dateFormatter.format(today_7);

  final List<String> entries = <String>[
    today,
    today1,
    today2,
    today3,
    today4,
    today5,
    today6
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(20.0),
          child: ListView(children: <Widget>[
            Ink(color: Colors.green[200]),
            new Card(
              color: Colors.green[200],
              child: new Container(
                padding: EdgeInsets.all(10.0),
                child: new Column(
                  children: <Widget>[
                    new Row(
                      children: <Widget>[
                        new Expanded(
                            child: new Text(
                          "How much water did you drink today?",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              decorationColor: Colors.red,
                              fontFamily: 'Cabin',
                              color: Colors.green[800]),
                        )),
                        new Expanded(
                          child: new TextField(),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            new Card(
              color: Colors.green[200],
              child: new Container(
                padding: EdgeInsets.all(10.0),
                child: new Column(
                  children: <Widget>[
                    new Row(
                      children: <Widget>[
                        new Expanded(
                            child: new Text(
                          "How long did you practice DJ for today?",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              decorationColor: Colors.red,
                              fontFamily: 'Cabin',
                              color: Colors.green[800]),
                        )),
                        new Expanded(
                          child: new TextField(),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            new Card(
              color: Colors.green[200],
              child: new Container(
                padding: EdgeInsets.all(10.0),
                child: new Column(
                  children: <Widget>[
                    new Row(
                      children: <Widget>[
                        new Expanded(
                            child: new Text(
                          "How long did you do yoga for today?",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              decorationColor: Colors.red,
                              fontFamily: 'Cabin',
                              color: Colors.green[800]),
                        )),
                        new Expanded(
                          child: new TextField(),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            new Card(
              color: Colors.green[200],
              child: new Container(
                padding: EdgeInsets.all(10.0),
                child: new Column(
                  children: <Widget>[
                    new Row(
                      children: <Widget>[
                        new Expanded(
                            child: new Text(
                          "How happy are you today?",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              decorationColor: Colors.red,
                              fontFamily: 'Cabin',
                              color: Colors.green[800]),
                        )),
                        new Expanded(
                          child: new TextField(),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            new Card(
              color: Colors.green[200],
              child: new Container(
                padding: EdgeInsets.all(10.0),
                child: new Column(
                  children: <Widget>[
                    new Row(
                      children: <Widget>[
                        new Expanded(
                            child: new Text(
                          "How much did you sleep today?",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              decorationColor: Colors.red,
                              fontFamily: 'Cabin',
                              color: Colors.green[800]),
                        )),
                        new Expanded(
                          child: new TextField(),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            new Card(
              color: Colors.white,
              //child: new Container(
              //padding: EdgeInsets.all(0),
              child: RaisedButton(
                onPressed: () => {},
                child: Text('Submit'),
              ),
            ),
            // ),
          ]),
        ),
      ),
    );
  }
}
