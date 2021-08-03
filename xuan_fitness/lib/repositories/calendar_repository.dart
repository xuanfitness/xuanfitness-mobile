import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CalendarRepository with ChangeNotifier{
  CollectionReference _db;
  Map<DateTime, List> _events;
  List<String> months;
  User user;

  CalendarRepository.instance(User user){
    user = user;
    print('test/${user.uid}');
    _db = FirebaseFirestore.instance.collection('users/test/calendar/');

    final today = DateTime.now();
    initCalendar('${today.year}-${today.month<10?'0'+today.month.toString():today.month}');
  }

  Map<DateTime, List> get calendar => _events;

  Future<void> initCalendar(String month) async{
    var temp = await _db.doc(month).get();
    months = [month];
    _events = {};
    if(temp.data() != null){
      temp.data().forEach((key, value){
        DateTime parsedDate = DateTime.parse(key);
        _events.putIfAbsent(parsedDate, () => value);
      });
      notifyListeners();
    }
  }

  Future<void> addMonth(DateTime monthDate) async{
    String date = '${monthDate.year}-${monthDate.month<10?'0'+monthDate.month.toString():monthDate.month}';
    if(!months.contains(date)){
      print(date);
      months.add(date);
      var temp = await _db.doc(date).get();
      if(temp.data() != null){
        temp.data().forEach((key, value){
          DateTime parsedDate = DateTime.parse(key);
          _events.putIfAbsent(parsedDate, () => value);
        });
        notifyListeners();
      }
    }
  }

  Future<void> addEvent(String event, DateTime day){
    day = DateTime(day.year, day.month, day.day);
    String date = '${day.year}-${day.month<10?'0'+day.month.toString():day.month}-${day.day<10?'0'+day.day.toString():day.day}';
    String month = '${day.year}-${day.month<10?'0'+day.month.toString():day.month}';

    if(_events[day] == null){
      _events.addAll({day:[event]});
      _db.doc(month).set({date: _events[day]}, SetOptions(merge: true));
      notifyListeners();
    }else if(!_events[day].contains(event)){
      _events[day].add(event);
      _db.doc(month).set({date: _events[day]}, SetOptions(merge: true));
      notifyListeners();
    }
    return null;
  }
}