import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:xuan_fitness/models/fitness/exercise.dart';
import 'package:xuan_fitness/models/fitness/section_entry.dart';
import 'package:xuan_fitness/pages/fitness/workout_circuit.dart';

class Circuit extends SectionEntry{
  List<Exercise> exercises;
  int sets, setsComplete;
  Circuit(String id, String name, String type):super(id, name, type);
  Circuit.fromJson(Map<String, dynamic>json):super.fromJson(json){
    this.sets = int.parse(json['sets']);
    this.setsComplete = int.parse(json['setComplete']??"0");
    var list = json['exercises'] as List;
    this.exercises = list.map((i) => Exercise.fromJson(i)).toList();
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
            trailing: (this.setsComplete == this.sets)? new Icon(FontAwesome.smile_o,
                color: Color(0xFF6A8D73)) : Text('${this.setsComplete}/${this.sets}'),
            onTap: () {
              setScreen(WorkoutCircuit(this, setScreen));
            }
        ));
  }
}