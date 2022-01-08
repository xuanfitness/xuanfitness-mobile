import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xuan_fitness/models/fitness/circuit.dart';
import 'package:xuan_fitness/models/fitness/exercise.dart';
import 'package:xuan_fitness/models/fitness/section_entry.dart';
import 'package:xuan_fitness/models/fitness/superset.dart';

class Section {
  String _title;
  List<SectionEntry> _entries;

  Section(this._title, dynamic entryData) {
    this._entries = [];
    for(dynamic raw in entryData){
      if(raw["type"] == "exercise"){
        this._entries.add(new Exercise.fromJson(raw));
      }else if(raw["type"] == "circuit"){
        this._entries.add(new Circuit.fromJson(raw));
      }else if(raw["type"] == "superset"){
        this._entries.add(new Superset.fromJson(raw));
      }
    }
  }
  Widget build(Function setScreen){
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('$_title',
              style: TextStyle(
                fontFamily: 'cabin',
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              )),
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: _entries.length,
            itemBuilder: (context, index){
                return _entries[index].listBuild(setScreen);
            }
          )
        ],
      ),
    );
  }
}