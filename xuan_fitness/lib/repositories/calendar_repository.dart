import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CalendarRepository with ChangeNotifier{
  CollectionReference _db;
  Map<DateTime, List> _events;
  User user;

  CalendarRepository.instance(User user){
    user = user;
    print('test/${user.uid}');
    _db = FirebaseFirestore.instance.collection('users/test/calendar/');

    final today = DateTime.now();
    print('${today.year}-${today.month}');
    initCalendar('${today.year}-${today.month}');
  }

  Map<DateTime, List> get calendar => _events;

  Future<void> initCalendar(String month) async{
    var temp = await _db.doc(month).get();
    print("CALENDAR INIT");
    print(temp.data());
    temp.data().forEach((key, value) => print('${key}'));

  }

  Future<void> addMonth(String month){

  }

  Future<void> refreshCalendar(){

  }
}