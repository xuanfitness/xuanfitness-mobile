import 'package:xuan_fitness/models/fitness/section_entry.dart';

class Section {
  String title;
  List<SectionEntry> entries;

  // Section(this.title, List<SectionEntry> entries) {
  //   this.entries = entries;
  // }

  Section.fromJson(Map<String, dynamic>json){
    this.title = json['title'];
    this.entries = [];
  }
}