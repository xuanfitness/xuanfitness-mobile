import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:xuan_fitness/models/fitness/section.dart';
import 'package:xuan_fitness/models/fitness/workout.dart';

class WorkoutRepository with ChangeNotifier{
  DocumentReference _db;
  List<Section> _sections;
  DateTime _day;
  String _dateString;
  String _weekString;
  User _user;

  List<Section> get sections => _sections;

  WorkoutRepository.instance(User user, DateTime date, List<dynamic> sectionData){
    this._user = user;
    this._day = date;
    this._dateString = '${date.year}-${date.month}-${date.day}';
    this._db = FirebaseFirestore.instance.doc('users/${_user.uid}/$_weekString/$_dateString');

    DateTime weekStart = DateTime(date.year, date.month, date.day - (date.weekday - 1));
    this._weekString = 'W${weekStart.year}-${weekStart.month}-${weekStart.day}';

    this._sections = [];
    for(dynamic raw in sectionData){
      this._sections.add(new Section(raw["title"],raw["entries"]));
    }
    print("WORKOUT PARSE");
    print(_sections.toString());
  }

  // Future<void> setWorkout(DateTime day) async{
  //   _day = day;
  //   _dateString = '${day.year}-${day.month}-${day.day}';
  //
  //   var temp = await _db.doc(_dateString).get();
  //   _workout = new Workout.fromJson(temp.data());
  //   notifyListeners();
  // }
}