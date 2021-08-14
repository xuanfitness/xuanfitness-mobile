import 'package:flutter/material.dart';
import 'package:xuan_fitness/models/habit.dart';

class HabitCard extends StatelessWidget {
  HabitCard(this.habit, this.index);
  final Habit habit;
  final int index;

  @override
  Widget build(BuildContext context) {
    return new Card(
      color: Color(0xFFCFE8D5),
      child: new Container(
        padding: EdgeInsets.all(10.0),
        child: new Column(
          children: <Widget>[
            new Row(
              children: <Widget>[
                new Expanded(
                    child: new Text(
                  habit.question,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      decorationColor: Colors.red,
                      fontFamily: 'Cabin',
                      color: Color(0xFF6A8D73)),
                )),
                new Expanded(
                    //(habit.response == null)?new TextField():Text(habit.response),
                    child: TextFormField(
                  initialValue: habit.response == null ? "" : habit.response,
                  onChanged: (response) => {habit.update(response)},
                )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
