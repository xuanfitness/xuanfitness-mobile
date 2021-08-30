import 'package:flutter/material.dart';

//im using this page to test the array thing

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:xuan_fitness/pages/fitness/timer.dart';
import 'package:xuan_fitness/pages/fitness/workout_detail.dart';
import 'package:xuan_fitness/pages/fitness/workout_circuit.dart';
import 'package:xuan_fitness/pages/fitness/workout_superset.dart';
import 'package:xuan_fitness/widgets/week_view.dart';
import 'package:xuan_fitness/pages/fitness/WorkoutData.dart';
import 'package:timelines/timelines.dart';
import 'package:xuan_fitness/repositories/nutrition_repository.dart';
import 'package:xuan_fitness/widgets/nutrition/meal_widget.dart';

class summary extends StatefulWidget {
  //require the page to accept a WorkoutData object;
  summary({Key key}) : super(key: key);

  final String title = "Summary";

  @override
  _summaryState createState() => _summaryState();
}

class _summaryState extends State<summary> {
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

  Widget build(BuildContext context) {
    // return Consumer(
    //     builder: (context, NutritionRepository nutritionRepository, _) {
    return MaterialApp(
        // final habitRepo = Provider.of<HabitRepository>(context);
        home: Scaffold(
            backgroundColor: Colors.grey[200],
            body: Center(
                child: new SingleChildScrollView(
                    child: Column(
                        // SizedBox(height: 20,)
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                  //the titles
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
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
                        SizedBox(height: 30),
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

                  //beginning of the stack for the 'timeline'.
                  Stack(
                    children: <Widget>[
                      Positioned(
                        child: Container(
                          height: 350.0,
                          width: 400.0,
                          color: Colors.transparent,
                          child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0))),
                              child: new Center(
                                child: Column(
                                  children: <Widget>[
                                    timelineRow("Squats", "Warmup"),
                                    timelineRow("Lunges", "Warmup"),
                                    timelineRow("Pushups", "Workout"),
                                    timelineRow("Crunches", "Workout"),
                                    timelineLastRow("Stretch", "Cooldown"),
                                  ],
                                ),
                              )),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
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

                  ListView.builder(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 250),
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: entriesHabits.length, // your List
                    itemBuilder: (context, index) {
                      return Card(
                          color: Colors.white,
                          child: ListTile(
                            title: Text(entriesHabits[index],
                                style: TextStyle(
                                    color: Color(0xFF6A8D73),
                                    fontWeight: FontWeight.bold)),
                            subtitle: Text(entries1[index]),
                            // trailing: new Icon(FontAwesome.smile_o,
                            //     color: Color(0xFF6A8D73)),));
                          ));
                    },
                  ),
                  // SizedBox(height: 20),

                  /***************************** NUTRITION ********************************/
                  Row(children: [
                    Text(
                      "Nutrition",
                      style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'cabin',
                          color: Color(0xFF6A8D73)),
                    )
                  ]),

                  //YOU CAN INSERT YOUR DATABASE STUFF HERE -- WONT WORK FOR ME
                  // ListView.builder(
                  //   physics: NeverScrollableScrollPhysics(),
                  //   shrinkWrap: true,
                  //   itemCount: 3,
                  //   itemBuilder: (BuildContext context, int index) {
                  //     return new MealCard(nutritionRepository.meals[index]);
                  //   },
                  // ),
                  Container(
                    // color: Colors.white,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(width: 10, color: Colors.white),
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                    ),
                    margin: const EdgeInsets.all(4),
                    padding: const EdgeInsets.all(4),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text("Breakfast",
                            style: TextStyle(
                                fontFamily: "cabin",
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF698D72))),
                        Image.asset('images/sushi.jpg'),
                        Text("Lunch",
                            style: TextStyle(
                                fontFamily: "cabin",
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF698D72))),
                        Image.asset('images/waffles.jpg'),
                        Text("Dinner",
                            style: TextStyle(
                                fontFamily: "cabin",
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF698D72))),
                        Image.asset('images/spagetti.jpg'),
                      ],
                    ),
                  )
                ])))));
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
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
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
            Container(
              width: 1,
              height: 50,
              decoration: new BoxDecoration(
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
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
              width: 3,
              height: 20,
              decoration: new BoxDecoration(
                color: Colors.transparent,
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
