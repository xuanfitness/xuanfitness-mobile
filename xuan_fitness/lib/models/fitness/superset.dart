import 'package:xuan_fitness/models/fitness/exercise.dart';
import 'package:xuan_fitness/models/fitness/section_entry.dart';

class Superset extends SectionEntry{
  List<Exercise> exercises;
  Superset(String id, String name, Type type):super(id, name, type);
  Superset.fromJson(Map<String, dynamic>json):super.fromJson(json){
    var list = json['exercises'] as List;
    this.exercises = list.map((i) => Exercise.fromJson(i)).toList();
  }
}