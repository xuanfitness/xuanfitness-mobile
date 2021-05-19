import 'package:xuan_fitness/models/fitness/section.dart';

class Workout {
  String title;
  List<Section> sections;
  int stopwatchMicroseconds;

  // Section(this.title, List<SectionEntry> entries) {
  //   this.entries = entries;
  // }

  Workout.fromJson(Map<String, dynamic>json){
    this.title = json['title'];
    this.stopwatchMicroseconds = json['stopwatchMicroseconds'];
    this.sections = [];

  }
}