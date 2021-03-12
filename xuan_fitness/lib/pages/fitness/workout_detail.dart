import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter/material.dart';
import 'package:timelines/timelines.dart';

class WorkoutDetail extends StatefulWidget {
  WorkoutDetail({Key key}) : super(key: key);

  final String title = "Workouts";

  @override
  _WorkoutDetailState createState() => _WorkoutDetailState();
}

class _WorkoutDetailState extends State<WorkoutDetail> {
  final List<String> entries = <String>['Abs', 'Squats', 'Jumprope'];
  final List<int> colorCodes = <int>[700, 400, 100];
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: const Color(0xFF0099a9),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: entries.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(100),
              child: ListTile(
                title: Text('${entries[index]}'),
              ),
            ),
            color: Colors.green[colorCodes[index]],
          );
        },
      ),
    );
  }
}
