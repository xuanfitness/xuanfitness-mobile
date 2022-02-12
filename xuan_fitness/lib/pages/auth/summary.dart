import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

//im using this page to test the array thing

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:xuan_fitness/models/day.dart';
import 'package:xuan_fitness/models/fitness/section.dart';
import 'package:xuan_fitness/models/habit.dart';
import 'package:xuan_fitness/models/meal.dart';
import 'package:xuan_fitness/pages/fitness/timer.dart';
// import 'package:xuan_fitness/pages/fitness/workout_detail.dart';
import 'package:xuan_fitness/pages/fitness/workout_circuit.dart';
import 'package:xuan_fitness/pages/fitness/workout_superset.dart';
import 'package:xuan_fitness/pages/splash.dart';
import 'package:xuan_fitness/widgets/week_view.dart';
// import 'package:xuan_fitness/pages/fitness/WorkoutData.dart';
// import 'package:timelines/timelines.dart';
import 'package:xuan_fitness/repositories/nutrition_repository.dart';
import 'package:xuan_fitness/widgets/nutrition/meal_widget.dart';

class DaySummary extends StatefulWidget {
  Day day;
  User user;
  DaySummary(DateTime date, this.user) {
    day = Day(date);
  }

  @override
  _SummaryState createState() => _SummaryState();
}

class _SummaryState extends State<DaySummary> {
  static String formattedDate;

  static final dateFormatter = DateFormat('MM-dd-yyyy');

  //four categories of workouts
  static String warmup = "Warm Up";
  static String workout = "Work Out";
  static String cooldown = "Cool Down";

  //the types of habits (questions)
  static String water = "How much water did you drink today?";
  static String DJ = "Did you practice DJ today?";
  static String smile = "Did you smile today?";
  static String basketball = "Did you play basketball today?";
  // static String squats = "Squats";
  // static String lunges = "Lunges";
  // static String crunches = "Crunches";
  // static String circuit = "Circuit";
  // static String superSet = "Superset";

  //all elements in lists
  final List<String> entries1 = <String>[
    "6oz", "yes", "yes", "yes"
    // workout,
    // workout,
    // workout,
    // workout,
    // cooldown
  ];
  final List<int> colorCodes = <int>[600, 500, 400, 300, 200, 100];
  final List<String> entriesHabits = <String>[water, DJ, smile, basketball];

  // Widget title() {
  //   return MaterialApp(title: "MyTitle", home: summary());
  // }
  List<Section> _sections;
  List<Habit> _habits;
  List<Meal> _meals;
  @override
  void initState() {
    super.initState();
    formattedDate = DateFormat('EEEE MMM d, y').format(widget.day.date);
    _sections = null;
    _habits = null;
  }

  Widget build(BuildContext context) {
    // return Consumer(
    //     builder: (context, NutritionRepository nutritionRepository, _) {
    return FutureBuilder(
        future: widget.day.initData(widget.user),
        builder: (context, snapshot) {
          if (widget.day.data == null)
            return Splash();
          else {
            if (_sections == null) {
              this._sections = [];
              for (dynamic raw in widget.day.data["fitness"]) {
                this
                    ._sections
                    .add(new Section(raw["title"], raw["entries"], raw["id"]));
              }
            }
            if (_habits == null) {
              this._habits = [];
              for (dynamic raw in widget.day.data["habits"]) {
                this._habits.add(new Habit(raw["question"],
                    raw["response"] ?? "", raw["feedback"] ?? ""));
              }
            }
            if (_meals == null) {
              this._meals = [];
              for (dynamic raw in widget.day.data["nutrition"]) {
                _meals.add(new Meal(raw["name"], raw["url"], raw["description"],
                    raw["feedback"] ?? ""));
              }
            }
            return MaterialApp(
                // final habitRepo = Provider.of<HabitRepository>(context);
                home: Scaffold(
                    backgroundColor: Colors.grey[200],
                    appBar: AppBar(
                      elevation: 0,
                      backgroundColor: Colors.grey[200],
                      title: Padding(
                          padding: EdgeInsets.all(0.0),
                          child: Image(
                              alignment: Alignment.bottomLeft,
                              image: AssetImage('images/xuan_logo.png'),
                              height: 30,
                              width: 30)),
                    ),
                    body: Center(
                        child: new SingleChildScrollView(
                            child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                          // SizedBox(height: 20,)
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            //the titles
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          'Summary',
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
                                      FlatButton(
                                        // color: Colors.white,
                                        child: Text("Back",
                                            style: TextStyle(
                                                color: Color(0xFF6A8D73))),
                                        onPressed: () {
                                          // Navigate back to first route when tapped.
                                          Navigator.pop(context);
                                        },
                                        shape: RoundedRectangleBorder(
                                            side: BorderSide(
                                                color: Color(0xFF6A8D73),
                                                width: 1,
                                                style: BorderStyle.solid),
                                            borderRadius:
                                                BorderRadius.circular(50)),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 5),
                                  Text('$formattedDate',
                                      style: TextStyle(
                                        fontFamily: 'cabin',
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF6A8D73),
                                      )),
                                ]),
                            SizedBox(height: 30),

                            /***************************** WORKOUTS ********************************/
                            Row(children: [
                              Text(
                                "Workouts",
                                style: TextStyle(
                                    fontSize: 35,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'cabin',
                                    color: Color(0xFF6A8D73)),
                              )
                            ]),
                            (_sections.length == 0)
                                ? Container(
                                    padding: EdgeInsets.all(50),
                                    child: Text("No Workout"))
                                : ListView.builder(
                                    padding: EdgeInsets.fromLTRB(10, 0, 8, 10),
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: _sections.length, // your List
                                    itemBuilder: (context, index) {
                                      return _sections[index].buildSummary();
                                    },
                                  ),
                            // Row(children: [
                            //   Text(
                            //     "Workouts",
                            //     style: TextStyle(
                            //         fontSize: 35,
                            //         fontWeight: FontWeight.bold,
                            //         fontFamily: 'cabin',
                            //         color: Color(0xFF6A8D73)),
                            //   )
                            // ]),
                            //
                            // //beginning of the stack for the 'timeline'.
                            // Stack(
                            //   children: <Widget>[
                            //     Positioned(
                            //       child: Container(
                            //         height: 350.0,
                            //         width: 400.0,
                            //         color: Colors.transparent,
                            //         child: Container(
                            //             decoration: BoxDecoration(
                            //                 // color: Colors.white,
                            //                 borderRadius: BorderRadius.all(
                            //                     Radius.circular(10.0))),
                            //             child: new Center(
                            //               child: Column(
                            //                 children: <Widget>[
                            //                   timelineRow("Squats", "Warmup"),
                            //                   timelineRow("Lunges", "Warmup"),
                            //                   timelineRow("Pushups", "Workout"),
                            //                   timelineRow(
                            //                       "Crunches", "Workout"),
                            //                   timelineLastRow(
                            //                       "Stretch", "Cooldown"),
                            //                 ],
                            //               ),
                            //             )),
                            //       ),
                            //     ),
                            //   ],
                            // ),
                            // SizedBox(height: 20),
                            /***************************** HABITS ********************************/
                            Row(children: [
                              Text(
                                "Habits",
                                style: TextStyle(
                                    fontSize: 35,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'cabin',
                                    color: Color(0xFF6A8D73)),
                              )
                            ]),
                            (_habits.length == 0)
                                ? Container(
                                    padding: EdgeInsets.all(50),
                                    child: Text("No Habits"))
                                : ListView.builder(
                                    padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: _habits.length, // your List
                                    itemBuilder: (context, index) {
                                      return Card(
                                          color: Colors.white,
                                          child: ListTile(
                                            title: Text(_habits[index].question,
                                                style: TextStyle(
                                                    color: Color(0xFF6A8D73),
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            subtitle:
                                                Text(_habits[index].response),
                                            // trailing: new Icon(FontAwesome.smile_o,
                                            //     color: Color(0xFF6A8D73)),));
                                          ));
                                    },
                                  ),
                            (_habits.length > 0 && _habits[0]?.feedback != "")
                                ? Container(
                                    padding: EdgeInsets.fromLTRB(8, 0, 8, 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Icon(
                                          Icons.chat_bubble,
                                          size: 15,
                                          color: Color(0xFF6A8D73),
                                        ),
                                        Text(
                                          _habits[0].feedback,
                                          style: TextStyle(
                                            color: Color(0xFF6A8D73),
                                          ),
                                        )
                                      ],
                                    ))
                                : Container(),

                            /***************************** NUTRITION ********************************/
                            Row(children: [
                              Text(
                                "Nutrition",
                                style: TextStyle(
                                    fontSize: 35,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'cabin',
                                    color: Color(0xFF6A8D73)),
                              ),
                            ]),

                            (_meals.length == 0)
                                ? Container(
                                    padding: EdgeInsets.all(50),
                                    child: Text("No meals"))
                                : ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: _meals.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Column(
                                        children: [
                                          MealCard(_meals[index]),
                                          (_meals[index].feedback != "")
                                              ? Container(
                                                  padding: EdgeInsets.fromLTRB(
                                                      10, 0, 10, 10),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Icon(
                                                        Icons.chat_bubble,
                                                        size: 15,
                                                        color:
                                                            Color(0xFF6A8D73),
                                                      ),
                                                      Text(
                                                        _meals[index].feedback,
                                                        style: TextStyle(
                                                          color:
                                                              Color(0xFF6A8D73),
                                                        ),
                                                      )
                                                    ],
                                                  ))
                                              : Container()
                                        ],
                                      );
                                    },
                                  ),
                            Padding(padding: EdgeInsets.all(25))
                            // Container(
                            //   // color: Colors.white,
                            //   decoration: BoxDecoration(
                            //     color: Colors.white,
                            //     border:
                            //         Border.all(width: 10, color: Colors.white),
                            //     borderRadius:
                            //         const BorderRadius.all(Radius.circular(8)),
                            //   ),
                            //   margin: const EdgeInsets.all(4),
                            //   padding: const EdgeInsets.all(4),
                            //   child: Column(
                            //     mainAxisAlignment:
                            //         MainAxisAlignment.spaceEvenly,
                            //     children: [
                            //       Text("Breakfast",
                            //           style: TextStyle(
                            //               fontFamily: "cabin",
                            //               fontSize: 20,
                            //               fontWeight: FontWeight.bold,
                            //               color: Color(0xFF698D72))),
                            //       Image.asset('images/sushi.jpg'),
                            //       Text("Lunch",
                            //           style: TextStyle(
                            //               fontFamily: "cabin",
                            //               fontSize: 20,
                            //               fontWeight: FontWeight.bold,
                            //               color: Color(0xFF698D72))),
                            //       Image.asset('images/waffles.jpg'),
                            //       Text("Dinner",
                            //           style: TextStyle(
                            //               fontFamily: "cabin",
                            //               fontSize: 20,
                            //               fontWeight: FontWeight.bold,
                            //               color: Color(0xFF698D72))),
                            //       Image.asset('images/spagetti.jpg'),
                            //     ],
                            //   ),
                            // )
                          ]),
                    )))));
          }
        });
    // });
  }
}

/**
 * WIDGET FOR THE WORKOUT TIMELINE 
 */
Widget timelineRow(String title, String subTile) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: <Widget>[
      Expanded(
        // flex: 1,
        child: Stack(
          // mainAxisAlignment: MainAxisAlignment.start,
          // mainAxisSize: MainAxisSize.min,
          // crossAxisAlignment: CrossAxisAlignment.center,
          alignment: AlignmentDirectional.center,
          children: <Widget>[
            Container(
              width: 1,
              height: 50,
              decoration: new BoxDecoration(
                color: Colors.green,
                shape: BoxShape.rectangle,
              ),
              child: Text(""),
            ),
            Container(
              width: 18,
              height: 18,
              decoration: new BoxDecoration(
                color: Color(0xFF6A8D73),
                shape: BoxShape.circle,
              ),
              child: Text("",
                  style: TextStyle(
                    fontFamily: 'cabin',
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF6A8D73),
                  )),
            ),
          ],
        ),
      ),
      Expanded(
        flex: 9,
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            //title or the workout
            Text('${title}',
                style: TextStyle(
                    fontFamily: "cabin",
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF698D72))),

            //the subtitle
            Text('${subTile}',
                style: TextStyle(
                    fontFamily: "regular", fontSize: 10, color: Colors.black54))
          ],
        ),
      ),
    ],
  );
}

/**
 * WIDGET FOR THE WORKOUT TIMELINE LAST ROW
 */
Widget timelineLastRow(String title, String subTile) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: <Widget>[
      Expanded(
        flex: 1,
        child: Stack(
          // mainAxisAlignment: MainAxisAlignment.start,
          // mainAxisSize: MainAxisSize.max,
          // crossAxisAlignment: CrossAxisAlignment.center,
          alignment: Alignment.center,
          children: <Widget>[
            Container(
              width: 18,
              height: 18,
              decoration: new BoxDecoration(
                color: Color(0xFF6A8D73),
                shape: BoxShape.circle,
              ),
              child: Text(""),
            ),
            Container(
              width: 1,
              height: 50,
              decoration: new BoxDecoration(
                // color: Colors.transparent,
                color: Colors.green,
                shape: BoxShape.rectangle,
              ),
              child: Text(""),
            ),
          ],
        ),
      ),
      Expanded(
        flex: 9,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('${title}',
                style: TextStyle(
                    fontFamily: "cabin",
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF698D72))),

            //the subtitle
            Text('${subTile}',
                style: TextStyle(
                    fontFamily: "regular", fontSize: 10, color: Colors.black54))
          ],
        ),
      ),
    ],
  );
}
