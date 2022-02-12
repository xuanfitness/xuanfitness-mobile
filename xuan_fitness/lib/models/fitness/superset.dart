import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:xuan_fitness/models/fitness/exercise.dart';
import 'package:xuan_fitness/models/fitness/section_entry.dart';
import 'package:xuan_fitness/pages/fitness/workout_superset.dart';
import 'package:xuan_fitness/pages/fitness/workout_superset_summary.dart';

class Superset extends SectionEntry{
  List<Exercise> exercises;
  bool film;
  String comments;
  Superset(String id, String name, String type, String feedback):super(id, name, type, feedback);
  Superset.fromJson(Map<String, dynamic>json):super.fromJson(json){
    var list = json['exercises'] as List;
    this.exercises = list.map((i) => Exercise.fromJson(i)).toList();
    this.film = json['film'] ?? false;
    this.comments = json['comments'] ?? "";
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "exercises": exercises.map((h) => h.toJson()).toList(),
      "id": id,
      "name": name,
      "type": type,
      "film": film,
      "comments": comments,
      "feedback": feedback,
    };
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
  Widget listBuild(Function setScreen, Function setSavable) {
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
            setScreen(WorkoutSuperset(this, setScreen, setSavable));
          }
        ));
  }

  Widget listBuildSummary(BuildContext context){
    return Container(
      child: Column(
        children: [
          Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
                side: BorderSide(
                  color: Colors.grey.withOpacity(0.2),
                  width: 1,
                ),
              ),
              color: Colors.white,
              child: ListTile(
                  title: Text(name,
                      style: TextStyle(
                          color: Color(0xFF6A8D73), fontWeight: FontWeight.bold)),
                  subtitle: Text(type),
                  trailing: (countComplete() == this.exercises.length)? new Icon(FontAwesome.smile_o,
                      color: Color(0xFF6A8D73)) : Text('${countComplete()}/${this.exercises.length}'),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> Scaffold(
                      appBar: AppBar(
                        automaticallyImplyLeading: false,
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
                      body: WorkoutSupersetSummary(this),
                    )));
                  }))
        ],
      ),
    );
  }

  Future<void> saveFilm(String storagePath) async{
    for(Exercise e in exercises){
      await e.saveFilm(storagePath);
    }
  }
}