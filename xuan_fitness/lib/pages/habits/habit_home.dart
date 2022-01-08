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
  static String formattedDate = DateFormat('EEEE, MMMM dd yyyy').format(DateTime.now());
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
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
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
                    onPressed: () => {habitRepo.saveHabits()},
                    child:
                        Text('Submit', style: TextStyle(color: Colors.white)),
                  ),
                ),
                // ),
              ]),
        ),
      );
    });
  }
}
