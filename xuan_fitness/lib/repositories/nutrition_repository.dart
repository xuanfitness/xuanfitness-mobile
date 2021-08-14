import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:xuan_fitness/models/meal.dart';

class NutritionRepository with ChangeNotifier{
  CollectionReference _db;
  List<Meal> _meals;
  DateTime _day;
  String _dateString;
  User _user;

  List<Meal> get meals => _meals;
  DateTime get day => _day;

  NutritionRepository.instance(User user, DateTime day, Map<String, dynamic> nutritionData){
    _user = user;
    print('test/${_user.uid}');
    _db = FirebaseFirestore.instance.collection('users/test/2021-06-21/');

    _day = day;
    _dateString = '${day.year}-${day.month}-${day.day}';

    _meals = [];
    for(Map<String, dynamic> raw in nutritionData["data"]){
      _meals.add(new Meal(raw["name"],raw["url"],raw["description"]));
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
      _db.doc("nutrition").set({"data": _meals.map((h)=> h.toJson()).toList()}, SetOptions(merge: true));
      notifyListeners();
    }else{
      print("Error");
    }
  }
}