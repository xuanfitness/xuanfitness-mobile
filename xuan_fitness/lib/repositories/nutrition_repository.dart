import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:xuan_fitness/models/meal.dart';
import 'package:intl/intl.dart';

class NutritionRepository with ChangeNotifier{
  static DateFormat _dateFormat = new DateFormat('yyyy-MM-dd');
  DocumentReference _db;
  List<Meal> _meals;
  DateTime _day;
  String _dateString, _weekString;
  User _user;

  Function addEvent;
  bool savable, completed;

  List<Meal> get meals => _meals;
  DateTime get day => _day;

  NutritionRepository.instance(User user, DateTime date, List<dynamic> nutritionData){
    this.savable = false;
    this.completed = true;
    this.addEvent = null;

    _user = user;
    _day = date;
    this._dateString = _dateFormat.format(date);
    DateTime weekStart = DateTime(date.year, date.month, date.day - (date.weekday - 1));
    this._weekString = 'W${_dateFormat.format(weekStart)}';
    this._db = FirebaseFirestore.instance.doc('users/${_user.uid}/$_weekString/$_dateString');

    _meals = [];
    if(nutritionData != null){
      for(dynamic raw in nutritionData){
        _meals.add(new Meal(raw["name"],raw["url"],raw["description"]));
      }
    }
  }

  NutritionRepository update(Function addEvent, List<dynamic> events){
    this.addEvent = addEvent;
    print(events?.toString());
    print((events!= null && events.contains("Nutrition")));
    this.completed = (events!= null && events.contains("Nutrition"));
    return this;
  }

  void markComplete(){
    if(this.addEvent != null){
      this.addEvent("Nutrition", _day);
      this.completed = true;
      notifyListeners();
    }
  }

  Future<void> addMeal(String name, String description, String imagePath) async{
    final file = File(imagePath);
    TaskSnapshot snapshot = await FirebaseStorage
        .instance.ref("8-2021/test")
        .child(new DateTime.now().millisecondsSinceEpoch.toString())
        .putFile(file);

    if(snapshot.state == TaskState.success){
      final String downloadUrl = await snapshot.ref.getDownloadURL();
      _meals.add(new Meal(name, downloadUrl, description));
      // _db.doc("nutrition").set({"data": _meals.map((h)=> h.toJson()).toList()}, SetOptions(merge: true));
      // notifyListeners();
    }else{
      print("Error");
    }
  }
}