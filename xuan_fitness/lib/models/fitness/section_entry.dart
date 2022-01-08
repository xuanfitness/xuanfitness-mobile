import 'package:flutter/cupertino.dart';

abstract class SectionEntry{
  String id, name, type;
  SectionEntry(this.id, this.name, this.type);
  SectionEntry.fromJson(Map<String, dynamic>json):
      id = json["id"],
      name = json["name"],
      type = json["type"];
  Widget listBuild(Function setScreen);
}