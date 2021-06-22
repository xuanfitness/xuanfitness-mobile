import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:xuan_fitness/pages/habits/habit_widget.dart';
import 'package:xuan_fitness/repositories/habits_repository.dart';

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
    return Consumer(
        builder: (context, HabitRepository habitRepository, _) {
          final habitRepo = Provider.of<HabitRepository>(context);
          return Scaffold(
            //backgroundColor: Color(0xFFFFEB3),
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
              //backgroundColor: Color(0xFFFFEB3),
              child:
              Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
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
                            'Habits',
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
                              color: Color(0xFFCFE8D5),
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

                Ink(color: Color(0xFFCFE8D5)),
                ListView.builder(
                  itemCount: habitRepo.habits.length,
                  itemBuilder: (BuildContext context, int index) {
                    return new HabitCard(habitRepo.habits[index], index);
                  },

                ),

                new Card(
                  color: Colors.white,
                  //child: new Container(
                  //padding: EdgeInsets.all(0),
                  child: RaisedButton(
                    color: Color(0xFF6A8D73),
                    onPressed: () => {},
                    child: Text('Submit', style: TextStyle(color: Colors.white)),
                  ),
                ),
                // ),
              ]),
            ),
          ),
          );
        }
    );
  }
}
