//im using this page to test the array thing

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:xuan_fitness/pages/fitness/timer.dart';
import 'package:xuan_fitness/pages/fitness/workout_detail.dart';
import 'package:xuan_fitness/pages/fitness/workout_circuit.dart';
import 'package:xuan_fitness/pages/fitness/workout_superset.dart';
import 'package:xuan_fitness/widgets/week_view.dart';

import 'WorkoutData.dart';

class WorkoutList extends StatefulWidget {
  //require the page to accept a WorkoutData object;
  WorkoutList({Key key}) : super(key: key);

  final String title = "Workouts";

  @override
  _WorkoutListState createState() => _WorkoutListState();
}

class _WorkoutListState extends State<WorkoutList> {
  @override
  static String formattedDate = DateFormat('MM-dd-yyyy').format(DateTime.now());

  static final dateFormatter = DateFormat('MM-dd-yyyy');

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

  //four categories of workouts
  static String warmup = "Warm Up";
  static String workout = "Work Out";
  static String cooldown = "Cool Down";

  //the types of workouts
  static String mountainClimbers = "Mountain Climbers";
  static String jumpingJacks = "Jumping Jacks";
  static String stretch = "Strech";
  static String jog = "Jog in Place";
  static String squats = "Squats";
  static String lunges = "Lunges";
  static String crunches = "Crunches";
  static String circuit = "Circuit";
  static String superSet = "Superset";

  //list of dates for a week
  final List<String> entries = <String>[
    today,
    today1,
    today2,
    today3,
    today4,
    today5,
    today6
  ];

  //all elements in lists
  final List<String> entries1 = <String>[
    warmup,
    warmup,
    warmup,
    workout,
    workout,
    workout,
    workout,
    workout,
    cooldown
  ];
  final List<int> colorCodes = <int>[600, 500, 400, 300, 200, 100];
  final List<String> entriesWorkout = <String>[
    mountainClimbers,
    jumpingJacks,
    jog,
    circuit,
    superSet,
    squats,
    lunges,
    crunches,
    stretch
  ];

  Widget build(BuildContext context) {
    return Scaffold(
        //backgroundColor: Color(0xFFFFEB3),
        backgroundColor: Colors.white,
        body: SlidingUpPanel(
          minHeight: 60,
          collapsed: Center(
            child: Text(
              'Timer',
              style: TextStyle(
                fontFamily: 'cabin',
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,

                //fontWeight: w600
              ),
            ),
          ),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          panel: Center(
              child: Container(
            width: double.infinity,
            padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              border: Border.all(
                  color: Theme.of(context).primaryColor, // Set border color
                  width: 3.0),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            ),
            child: TimerWidget(),
          )),
          body: SingleChildScrollView(
              physics: ScrollPhysics(),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: Colors.white,
                            blurRadius: 1,
                            //offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      //color: Colors.green,
                      padding: const EdgeInsets.only(bottom: 8),
                      //child: Scrollbar(isAlwaysShown:true, controller:_scrollController,)
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Workouts',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontFamily: 'cabin',
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF6A8D73),

                                  //fontWeight: w600
                                ),
                              ),
                            ),
                            SizedBox(height: 30),
                            Text('Today',
                                style: TextStyle(
                                  fontFamily: 'cabin',
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFFA2C2A9),
                                )),
                            Text('$formattedDate',
                                style: TextStyle(
                                  fontFamily: 'cabin',
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF6A8D73),
                                )),
                          ]),
                    ),

                    //the listview of the workouts
                    Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.grey[100],
                          Colors.grey[300],
                        ],
                      )),
                      child: ListView.builder(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 275),
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: entriesWorkout.length, // your List
                        itemBuilder: (context, index) {
                          return Card(
                              color: Colors.white,
                              child: ListTile(
                                  title: Text(entriesWorkout[index],
                                      style: TextStyle(
                                          color: Color(0xFF6A8D73),
                                          fontWeight: FontWeight.bold)),
                                  subtitle: Text(entries1[index]),
                                  // trailing: new Icon(FontAwesome.smile_o,
                                  //     color: Color(0xFF6A8D73)),
                                  onTap: () {
                                    if (entriesWorkout[index] == superSet) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                WorkoutSuperset()),
                                      );
                                    } else if (entriesWorkout[index] ==
                                        circuit) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                WorkoutCircuit()),
                                      );
                                    } else {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                WorkoutDetail()),
                                      );
                                    }
                                  }));
                        },
                      ),
                    ),
                  ])),
        ));
  }
}
