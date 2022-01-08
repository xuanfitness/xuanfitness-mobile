import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class Day{
  static DateFormat _dateFormat = new DateFormat('yyyy-MM-dd');
  Map<String, dynamic> _data;
  DateTime _date;
  String _dateString;
  String _weekString;
  User _user;

  Map<String, dynamic> get data => _data;

  Day(DateTime date){
    this._date = date;
    this._dateString = _dateFormat.format(date);
    DateTime weekStart = DateTime(date.year, date.month, date.day - (date.weekday - 1));
    this._weekString = 'W${_dateFormat.format(weekStart)}';
    this._data = null;
  }

  Future initData(User user) async{
    print("GET DATA");
    this._user = user;
    if(this._data == {} || this._data == null){
      print("FIREBASE CALL");
      var rawData = await FirebaseFirestore.instance.doc('users/${_user.uid}/$_weekString/$_dateString').get();
      print('users/${_user.uid}/$_weekString/$_dateString');
      this._data = {};
      if(rawData.exists){
        this._data = rawData.data();
      }
      print(rawData.data());
    }
  }
}