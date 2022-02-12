import 'package:flutter/material.dart';
import 'package:xuan_fitness/models/habit.dart';

class HabitCard extends StatelessWidget {
  HabitCard(this.habit, this.index, this.makeSavable);
  final Habit habit;
  final int index;
  final Function makeSavable;

  @override
  Widget build(BuildContext context) {
    return new Card(
      // color: Color(0xFFCFE8D5),
      child: new Container(
        padding: EdgeInsets.all(10.0),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Text(
              habit.question,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Cabin',
                  color: Color(0xFF6A8D73)),
            ),
            TextFormField(
              initialValue: habit.response == null ? "" : habit.response,
              onChanged: (response) {
                habit.update(response);
                makeSavable();
              },
            ),
          ],
        ),
      ),
    );
  }
}
