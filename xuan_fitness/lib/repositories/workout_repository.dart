import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:xuan_fitness/models/fitness/section.dart';
import 'package:intl/intl.dart';

class WorkoutRepository with ChangeNotifier{
  static DateFormat _dateFormat = new DateFormat('yyyy-MM-dd');
  DocumentReference _db;
  List<Section> _sections;
  DateTime _day;
  String _dateString;
  String _weekString;
  User _user;
  bool savable, completed;
  Function addEvent;

  List<Section> get sections => _sections;

  WorkoutRepository.instance(User user, DateTime date, List<dynamic> sectionData){
    this.savable = false;
    this.completed = true;
    this.addEvent = null;

    this._user = user;
    this._day = date;
    this._dateString = _dateFormat.format(date);

    DateTime weekStart = DateTime(date.year, date.month, date.day - (date.weekday - 1));
    this._weekString = 'W${_dateFormat.format(weekStart)}';

    this._db = FirebaseFirestore.instance.doc('users/${_user.uid}/$_weekString/$_dateString');
    this._sections = [];
    for(dynamic raw in sectionData){
      this._sections.add(new Section(raw["title"],raw["entries"], raw["id"]));
    }
    print("WORKOUT PARSE");
    print(_sections.toString());
  }

  void makeSavable(){
    if(!this.savable){
      this.savable = true;
      notifyListeners();
    }
  }

  void markComplete(){
    if(this.addEvent != null){
      this.addEvent("Fitness", _day);
      this.completed = true;
      notifyListeners();
    }
  }

  WorkoutRepository update(Function addEvent, List<dynamic> events){
    this.addEvent = addEvent;
    print(events?.toString());
    print((events!= null && events.contains("Fitness")));
    this.completed = (events!= null && events.contains("Fitness"));
    return this;
  }

  Future<void> saveWorkout() async{
    _db.set({"fitness": _sections.map((h)=> h.toJson()).toList()}, SetOptions(merge: true));
    this.savable = false;
    notifyListeners();
  }


}