import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:xuan_fitness/models/fitness/workout.dart';

class WorkoutRepository with ChangeNotifier{
  CollectionReference _db;
  Workout _workout;
  DateTime _day;
  String _dateString;
  User user;

  Workout get workout => _workout;

  WorkoutRepository.instance(User user){
    user = user;
    print('test/${user.uid}');
    _db = FirebaseFirestore.instance.collection('users/test/calendar/');
  }

  Future<void> setWorkout(DateTime day) async{
    _day = day;
    _dateString = '${day.year}-${day.month}-${day.day}';

    var temp = await _db.doc(_dateString).get();
    _workout = new Workout.fromJson(temp.data());
    notifyListeners();
  }
}