import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:xuan_fitness/models/fitness/exercise.dart';
import 'package:xuan_fitness/models/fitness/section_entry.dart';
import 'package:xuan_fitness/pages/fitness/workout_superset.dart';

class Superset extends SectionEntry{
  List<Exercise> exercises;
  Superset(String id, String name, String type):super(id, name, type);
  Superset.fromJson(Map<String, dynamic>json):super.fromJson(json){
    var list = json['exercises'] as List;
    this.exercises = list.map((i) => Exercise.fromJson(i)).toList();
  }

  int countComplete(){
    int count = 0;
    this.exercises.forEach((exercise) {
      if(exercise.setComplete == exercise.setCount)
        count++;
    });
    return count;
  }

  @override
  Widget listBuild(Function setScreen) {
    return Card(
        color: Colors.white,
        child: ListTile(
          title: Text(name,
              style: TextStyle(
                  color: Color(0xFF6A8D73),
                  fontWeight: FontWeight.bold)),
          subtitle: Text(type),
          trailing: (countComplete() == this.exercises.length)? new Icon(FontAwesome.smile_o,
                color: Color(0xFF6A8D73)) : Text('${countComplete()}/${this.exercises.length}'),
          onTap: () {
            setScreen(WorkoutSuperset(this, setScreen));
          }
        ));
  }
}