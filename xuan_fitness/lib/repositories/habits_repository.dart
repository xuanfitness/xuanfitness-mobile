import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:xuan_fitness/models/habit.dart';
import 'package:intl/intl.dart';

class HabitRepository with ChangeNotifier{
  static DateFormat _dateFormat = new DateFormat('yyyy-MM-dd');
  DocumentReference _db;
  List<Habit> _habits;
  DateTime _day;
  String _dateString;
  String _weekString;
  User _user;

  Function addEvent;
  bool savable, completed;

  List<Habit> get habits => _habits;
  DateTime get day => _day;

  HabitRepository.instance(User user, DateTime date, List<dynamic> habitData){
    this.savable = false;
    this.completed = true;
    this.addEvent = null;

    this._user = user;
    this._day = date;
    this._dateString = _dateFormat.format(date);
    DateTime weekStart = DateTime(date.year, date.month, date.day - (date.weekday - 1));
    this._weekString = 'W${_dateFormat.format(weekStart)}';
    this._db = FirebaseFirestore.instance.doc('users/${_user.uid}/$_weekString/$_dateString');

    this._habits = [];
    for(dynamic raw in habitData){
      this._habits.add(new Habit(raw["question"],raw["response"]??"", raw["feedback"]?? ""));
    }
  }

  HabitRepository update(Function addEvent, List<dynamic> events){
    this.addEvent = addEvent;
    print(events?.toString());
    print((events!= null && events.contains("Habits")));
    this.completed = (events!= null && events.contains("Habits"));
    return this;
  }

  void makeSavable(){
    if(!this.savable){
      this.savable = true;
      notifyListeners();
    }
  }

  void markComplete(){
    if(this.addEvent != null){
      this.addEvent("Habits", _day);
      this.completed = true;
      notifyListeners();
    }
  }

  void updateHabit(int index, String response){
    this._habits[index].response = response;
    makeSavable();
  }

  Future<void> saveHabits() async{
    // await _db.doc("habits").update({"data": _habits.map((h)=> h.toJson()).toList()});
    await _db.update({"habits": _habits.map((h)=> h.toJson()).toList()});
    this.savable = false;
    notifyListeners();
  }
}