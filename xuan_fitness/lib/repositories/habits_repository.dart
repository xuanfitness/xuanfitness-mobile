import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:xuan_fitness/models/habit.dart';

class HabitRepository with ChangeNotifier{
  DocumentReference _db;
  List<Habit> _habits;
  DateTime _day;
  String _dateString;
  String _weekString;
  User _user;

  List<Habit> get habits => _habits;
  DateTime get day => _day;

  HabitRepository.instance(User user, DateTime date, List<dynamic> habitData){
    this._user = user;
    this._day = date;
    this._dateString = '${date.year}-${date.month}-${date.day}';
    // this._dateString = "2021-06-21";
    DateTime weekStart = DateTime(date.year, date.month, date.day - (date.weekday - 1));
    this._weekString = 'W${weekStart.year}-${weekStart.month}-${weekStart.day}';
    // _db = FirebaseFirestore.instance.collection('users/test/$_dateString');
    this._db = FirebaseFirestore.instance.doc('users/${_user.uid}/$_weekString/$_dateString');

    this._habits = [];
    for(dynamic raw in habitData){
      this._habits.add(new Habit(raw["question"],raw["response"]??""));
    }
  }

  void updateHabit(int index, String response){
    this._habits[index].response = response;
  }

  Future<void> saveHabits() async{
    // await _db.doc("habits").update({"data": _habits.map((h)=> h.toJson()).toList()});
    await _db.update({"habits": _habits.map((h)=> h.toJson()).toList()});
    notifyListeners();
  }
}