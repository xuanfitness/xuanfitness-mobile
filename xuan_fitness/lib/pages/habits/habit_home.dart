import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:xuan_fitness/widgets/habit/habit_widget.dart';
import 'package:xuan_fitness/repositories/habits_repository.dart';

class HabitsHome extends StatefulWidget {
  @override
  HabitsHomeState createState() => new HabitsHomeState();
}

class HabitsHomeState extends State<HabitsHome> {
  static String formattedDate =
      DateFormat('EEEE, MMMM dd yyyy').format(DateTime.now());
  static final dateFormatter = DateFormat('EEEE, MMMM dd yyyy');

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, HabitRepository habitRepository, _) {
      final habitRepo = Provider.of<HabitRepository>(context);
      return Scaffold(
        //backgroundColor: Color(0xFFFFEB3),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          physics: ScrollPhysics(),
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
                Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.white,
                      Colors.grey[300],
                    ],
                  )),
                  child: ListView.builder(
                    padding: EdgeInsets.fromLTRB(10, 0, 8, 375),
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: habitRepo.habits.length + 1,
                    itemBuilder: (BuildContext context, int index) {
                      if (index == habitRepo.habits.length) {
                        return FractionallySizedBox(
                            widthFactor: 1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                ElevatedButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                        MaterialStateProperty.all(
                                            Color(0xFF6A8D73))),
                                    onPressed: (habitRepository.savable)
                                        ? () {
                                            print("save");
                                            habitRepository.saveHabits();
                                          }
                                        : null,
                                    child: const Text("Save")),
                                OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                    primary: Color(0xFF6A8D73),
                                  ),
                                  onPressed: (habitRepository.completed)
                                      ? null
                                      : () {
                                          print("Mark Complete");
                                          habitRepository.markComplete();
                                        },
                                  child: const Text('Mark Complete'),
                                ),
                              ],
                            ));
                      } else {
                        return new HabitCard(habitRepo.habits[index], index, habitRepo.makeSavable);
                      }
                    },
                  ),
                ),

                // new Card(
                //   color: Colors.white,
                //   //child: new Container(
                //   //padding: EdgeInsets.all(0),
                //   child: RaisedButton(
                //     color: Color(0xFF6A8D73),
                //     onPressed: () => {habitRepo.saveHabits()},
                //     child:
                //         Text('Submit', style: TextStyle(color: Colors.white)),
                //   ),
                // ),
                // ),
              ]),
        ),
      );
    });
  }
}
