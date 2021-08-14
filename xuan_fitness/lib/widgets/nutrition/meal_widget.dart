import 'package:flutter/material.dart';
import 'package:xuan_fitness/models/meal.dart';

class MealCard extends StatelessWidget {
  MealCard(this.meal);
  final Meal meal;

  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: EdgeInsets.all(8.0),
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0))),
        child: InkWell(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8.0),
                  topRight: Radius.circular(8.0),
                ),
                child: meal.img,
              ),
              ListTile(
                title: Text(
                  meal.title,
                  style: TextStyle(
                    color: Color(0xFFA2C2A9),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(meal.description),
              )
            ],
          ),
        ),
      ),
    );
  }
}
