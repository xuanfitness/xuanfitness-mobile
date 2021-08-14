import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:xuan_fitness/models/meal.dart';

class NutritionRepository with ChangeNotifier {
  CollectionReference _db;
  List<Meal> _meals;
  DateTime _day;
  String _dateString;
  String description;
  User _user;

  List<Meal> get meals => _meals;
  DateTime get day => _day;

  NutritionRepository.instance(
      User user, DateTime day, Map<String, dynamic> nutritionData) {
    user = _user;
    print('test/${user.uid}');
    _db = FirebaseFirestore.instance.collection('users/test/calendar/');

    _day = day;
    _dateString = '${day.year}-${day.month}-${day.day}';

    _meals = [];
    nutritionData.forEach((key, value) {
      _meals.add(new Meal.fromJson(value));
    });
  }

  Future<void> addMeal(
      String description, String imagePath, String meal) async {
    final file = File(imagePath);

    TaskSnapshot snapshot =
        await FirebaseStorage.instance.ref("test").putFile(file);

    if (snapshot.state == TaskState.success) {
      final String downloadUrl = await snapshot.ref.getDownloadURL();
      _db
          .doc(_dateString)
          .set({description: downloadUrl}, SetOptions(merge: true));

      _meals.add(new Meal(description, imagePath, meal));
      notifyListeners();
    } else {
      print("Error");
    }
  }
}
