import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:xuan_fitness/pages/fitness/workout_detail.dart';
import 'package:xuan_fitness/pages/fitness/workout_circuit.dart';
import 'package:xuan_fitness/widgets/week_view.dart';

class WorkoutList extends StatefulWidget {
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
  static String circuit = "Cicuit";
  static String cooldown = "Cool Down";

  //the types of workouts
  static String mountainClimbers = "Mountain Climbers";
  static String jumpingJacks = "Jumping Jacks";
  static String stretch = "Strech";
  static String jog = "Jog in Place";
  static String squats = "squats";
  static String lunges = "Lunges";
  static String crunches = "Crunches";

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
  final List<String> entries1 = <String>[warmup, workout, circuit, cooldown];
  final List<int> colorCodes = <int>[600, 500, 400, 300, 200, 100];
  final List<String> entriesWorkout = <String>[
    mountainClimbers,
    jumpingJacks,
    stretch,
    jog,
    squats,
    lunges,
    crunches
  ];

  Widget build(BuildContext context) {
    return Scaffold(
        //backgroundColor: Color(0xFFFFEB3),
        backgroundColor: Colors.white,
        body: SlidingUpPanel(
          panel: Center(
            child: Text("This is the sliding Widget"),
          ),
          body: SingleChildScrollView(
              //backgroundColor: Color(0xFFFFEB3),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
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
                            '$workout',
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

                /**
                 * Where the lists of cards starts
                 */
                Card(
                    color: Color(0xFFCFE8D5),
                    child: ListTile(
                        title: Text('$jumpingJacks',
                            style: TextStyle(
                                color: Color(0xFF6A8D73),
                                fontWeight: FontWeight.bold)),
                        //primarySwatch: Color(0xFFA2C2A9),
                        subtitle: Text('$warmup'),
                        trailing: new Icon(FontAwesome.smile_o,
                            color: Color(0xFF6A8D73)),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => WorkoutCircuit()),
                          );
                        })),
                Card(
                    color: Color(0xFFCFE8D5),
                    child: ListTile(
                        title: Text('$mountainClimbers',
                            style: TextStyle(
                                color: Color(0xFF6A8D73),
                                fontWeight: FontWeight.bold)),
                        subtitle: Text('$warmup'),
                        trailing: new Icon(FontAwesome.smile_o,
                            color: Color(0xFF6A8D73)),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => WorkoutDetail()),
                          );
                        })),
                Card(
                    color: Color(0xFFCFE8D5),
                    child: ListTile(
                        title: Text('$crunches',
                            style: TextStyle(
                                color: Color(0xFF6A8D73),
                                fontWeight: FontWeight.bold)),
                        subtitle: Text('$workout'),
                        trailing: new Icon(FontAwesome.smile_o,
                            color: Color(0xFF6A8D73)),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => WorkoutDetail()),
                          );
                        })),
                Card(
                    color: Color(0xFFCFE8D5),
                    child: ListTile(
                        title: Text('$squats',
                            style: TextStyle(
                              color: Color(0xFF6A8D73),
                              fontWeight: FontWeight.bold,
                            )),
                        subtitle: Text('$workout'),
                        trailing: new Icon(FontAwesome.smile_o,
                            color: Color(0xFF6A8D73)),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => WorkoutDetail()),
                          );
                        })),
                Card(
                    color: Colors.white,
                    child: ListTile(
                        title: Text('$lunges',
                            style: TextStyle(
                                color: Color(0xFF6A8D73),
                                fontWeight: FontWeight.bold)),
                        subtitle: Text(
                          '$workout',
                        ),
                        trailing: new Icon(FontAwesome.smile_o,
                            color: Color(0xFF6A8D73)),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => WorkoutDetail()),
                          );
                        })),
                Card(
                    color: Colors.white,
                    child: ListTile(
                        title: Text('$jog',
                            style: TextStyle(
                                color: Color(0xFF6A8D73),
                                fontWeight: FontWeight.bold)),
                        subtitle: Text('$cooldown'),
                        trailing: new Icon(FontAwesome.smile_o,
                            color: Color(0xFF6A8D73)),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => WorkoutDetail()),
                          );
                        })),
                Card(
                    color: Colors.white,
                    child: ListTile(
                        title: Text('$stretch',
                            style: TextStyle(
                                color: Color(0xFF6A8D73),
                                fontWeight: FontWeight.bold)),
                        subtitle: Text('$cooldown'),
                        trailing: new Icon(FontAwesome.smile_o,
                            color: Color(0xFF6A8D73)),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => WorkoutDetail()),
                          );
                        })),
                Card(
                    color: Colors.white,
                    child: ListTile(
                        title: Text('$stretch',
                            style: TextStyle(
                                color: Color(0xFF6A8D73),
                                fontWeight: FontWeight.bold)),
                        subtitle: Text('$cooldown'),
                        trailing: new Icon(FontAwesome.smile_o,
                            color: Color(0xFF6A8D73)),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => WorkoutDetail()),
                          );
                        })),
              ])),
        ));
  }
}
