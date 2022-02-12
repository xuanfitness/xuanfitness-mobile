import 'package:flutter/cupertino.dart';

abstract class SectionEntry{
  String id, name, type, feedback;
  SectionEntry(this.id, this.name, this.type, this.feedback);
  SectionEntry.fromJson(Map<String, dynamic>json):
      id = json["id"],
      name = json["name"],
      type = json["type"],
      feedback = json["feedback"] ?? "";
  Map<String, dynamic> toJson();
  Widget listBuild(Function setScreen, Function setSavable);
  Widget listBuildSummary(BuildContext context);
  Future<void> saveFilm(String storagePath);
}