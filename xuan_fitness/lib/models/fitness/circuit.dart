import 'package:xuan_fitness/models/fitness/exercise.dart';
import 'package:xuan_fitness/models/fitness/section_entry.dart';

class Circuit extends SectionEntry{
  List<Exercise> exercises;
  Circuit(String id, String name, Type type):super(id, name, type);
  Circuit.fromJson(Map<String, dynamic>json):super.fromJson(json){
    var list = json['exercises'] as List;
    this.exercises = list.map((i) => Exercise.fromJson(i)).toList();
  }
}