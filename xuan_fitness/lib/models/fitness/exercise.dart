import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:xuan_fitness/models/fitness/section_entry.dart';
import 'package:xuan_fitness/pages/fitness/workout_exercise.dart';

class Exercise extends SectionEntry{
  String comments, cues, url, videoId;
  int setComplete, setCount, setReps, setWeight;
  Exercise(this.comments, this.cues, this.url, this.videoId,
          this.setComplete, this.setCount, this.setReps, this.setWeight, String id, String name, String type):super(id, name, type);
  Exercise.fromJson(Map<String, dynamic>json):
      comments = json['comments']??"",
      cues = json['cues']??"",
      url = json['url'],
      setComplete = int.parse(json['setComplete']??"0"),
      setCount = int.parse(json['sets']),
      setReps = int.parse(json['reps']),
      setWeight = int.parse(json['weight']),
      super.fromJson(json);

  @override
  Widget listBuild(Function setScreen) {
    return Card(
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
                  color: Color(0xFF6A8D73),
                  fontWeight: FontWeight.bold)),
          subtitle: Text(type),
          trailing: (this.setCount == this.setComplete)? new Icon(FontAwesome.smile_o,
              color: Color(0xFF6A8D73)) : Text('${this.setComplete}/${this.setCount}'),
          onTap: () {
              setScreen(WorkoutDetail(this, setScreen));
          }
        ));
  }
}