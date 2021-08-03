import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:xuan_fitness/models/habit.dart';

class HabitRepository with ChangeNotifier{
  CollectionReference _db;
  List<Habit> _habits;
  DateTime _day;
  String _dateString;
  User _user;

  List<Habit> get habits => _habits;
  DateTime get day => _day;

  HabitRepository.instance(User user, DateTime day, Map<String, dynamic> habitData){
    _user = user;
    _day = day;
    // _dateString = '${day.year}-${day.month}-${day.day}';
    _dateString = "2021-06-21";
    _db = FirebaseFirestore.instance.collection('users/test/$_dateString');

    _habits = [];
    for(Map<String, dynamic> raw in habitData["data"]){
      _habits.add(new Habit(raw["question"],raw["response"]));
    }
  }

  void updateHabit(int index, String response){
    _habits[index].response = response;
  }

  Future<void> saveHabits() async{
    await _db.doc("habits").update({"data": _habits.map((h)=> h.toJson()).toList()});
    notifyListeners();
  }
}