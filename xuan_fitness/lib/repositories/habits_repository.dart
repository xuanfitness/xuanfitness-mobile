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
    _dateString = '${day.year}-${day.month}-${day.day}';

    print('test/${user.uid}');
    _db = FirebaseFirestore.instance.collection('users/test/$_dateString/');
    _habits = [];


    // habitData.forEach((key, value){
    //   //_habits.add(new Habit.fromJson(value));
    // });
    getHabits();

  }

  void getHabits() async{
    var habitData = await _db.doc('habits').get();
    habitData.data().forEach((key, value) {
      _habits.add(new Habit(value["question"],value["response"]));
    });
  }

  void updateHabit(int index, String response){
    _habits[index].response = response;
  }

  Future<void> saveHabits() async{
    _db.doc(_dateString).set({"habits": _habits}, SetOptions(merge: true));
    notifyListeners();
  }
}