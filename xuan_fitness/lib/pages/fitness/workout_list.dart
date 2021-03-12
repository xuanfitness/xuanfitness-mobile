import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter/material.dart';
import 'package:xuan_fitness/pages/fitness/workout_detail.dart';

class WorkoutList extends StatefulWidget {
  WorkoutList({Key key}) : super(key: key);

  final String title = "Workouts";

  @override
  _WorkoutListState createState() => _WorkoutListState();
}

class _WorkoutListState extends State<WorkoutList> {
  @override
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
  final List<int> colorCodes = <int>[600, 500, 400, 300, 200, 100];

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.green.shade400,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Divider(color: Colors.brown),
            ListTile(
                title: Text('$formattedDate'),
                subtitle: Text('Rest Day'),
                trailing: new Icon(FontAwesome.smile_o, color: Colors.green),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => WorkoutDetail()),
                  );
                }),
            const Divider(color: Colors.brown),
            ListTile(
                title: Text('$today'),
                subtitle: Text('Leg Day'),
                trailing: new Icon(FontAwesome.smile_o, color: Colors.green),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => WorkoutDetail()),
                  );
                }),
            const Divider(color: Colors.brown),
            ListTile(
                title: Text('$today1'),
                subtitle: Text('Arm Day'),
                trailing: new Icon(FontAwesome.smile_o, color: Colors.green),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => WorkoutDetail()),
                  );
                }),
            const Divider(color: Colors.brown),
            ListTile(
                title: Text('$today2'),
                subtitle: Text('Arm Day'),
                trailing: new Icon(FontAwesome.smile_o, color: Colors.green),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => WorkoutDetail()),
                  );
                }),
            const Divider(color: Colors.brown),
            ListTile(
                title: Text('$today3'),
                subtitle: Text('Arm Day'),
                trailing: new Icon(FontAwesome.smile_o, color: Colors.green),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => WorkoutDetail()),
                  );
                }),
            const Divider(color: Colors.brown),
            ListTile(
                title: Text('$today4'),
                subtitle: Text('Arm Day'),
                trailing: new Icon(FontAwesome.smile_o, color: Colors.green),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => WorkoutDetail()),
                  );
                }),
            const Divider(color: Colors.brown),
            ListTile(
                title: Text('$today5'),
                subtitle: Text('Arm Day'),
                trailing: new Icon(FontAwesome.smile_o, color: Colors.green),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => WorkoutDetail()),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
