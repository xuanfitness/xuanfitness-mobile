import 'package:xuan_fitness/models/fitness/section.dart';

class Workout {
  String title;
  List<Section> sections;
  int stopwatchMicroseconds;
  String comment,
      reps,
      workoutTitle,
      workoutVideo; //what data type is workoutVideo tho

  // Section(this.title, List<SectionEntry> entries) {
  //   this.entries = entries;
  // }

  Workout.fromJson(Map<String, dynamic> json) {
    this.title = json['title'];
    this.stopwatchMicroseconds = json['stopwatchMicroseconds'];
    // this.sections = [];
    this.comment =
        json["comment"]; //the comment from which xuan will provide advice
    this.reps = json["reps"];
    this.workoutTitle = json["title"];
    this.workoutVideo = json["video"];
  }
}
