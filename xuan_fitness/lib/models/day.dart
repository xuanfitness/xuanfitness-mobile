import 'package:cloud_firestore/cloud_firestore.dart';

class Day{
  // Map<String, dynamic> _fitness, _habits, _nutrition;
  Map<String, dynamic> _data;
  DateTime _date;
  String _dateString;

  Map<String, dynamic> get data => _data;

  Day(DateTime date){
    // this._dateString = _dateString = '${date.year}-${date.month}-${date.day}';
    this._dateString = '2021-06-21';
    this._data = null;
  }

  Future initData() async{
    print("GET DATA");
    var rawData = await FirebaseFirestore.instance.collection('users/test/$_dateString').get();
    this._data = {};
    if(rawData.docs.isNotEmpty) {
      for (QueryDocumentSnapshot q in rawData.docs) {
        this._data[q.id] = q.data();
      }
      print(this._data);
    }
  }
}