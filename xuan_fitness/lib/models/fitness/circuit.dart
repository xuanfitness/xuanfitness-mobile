import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:xuan_fitness/models/fitness/exercise.dart';
import 'package:xuan_fitness/models/fitness/section_entry.dart';
import 'package:xuan_fitness/pages/fitness/workout_circuit.dart';
import 'package:xuan_fitness/pages/fitness/workout_circuit_summary.dart';

class Circuit extends SectionEntry{
  List<Exercise> exercises;
  int sets, setsComplete;
  bool film;
  PickedFile pickedFile;
  String filmURL, comments;

  Circuit(String id, String name, String type, String feedback):super(id, name, type, feedback);
  Circuit.fromJson(Map<String, dynamic>json):super.fromJson(json){
    this.sets = int.parse(json['sets']);
    this.setsComplete = int.parse(json['setComplete']??"0");
    var list = json['exercises'] as List;
    this.exercises = list.map((i) => Exercise.fromJson(i)).toList();
    this.film = json['film'] ?? false;
    this.filmURL = json['filmURL'] ?? "";
    this.comments = json['comments'] ?? "";
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "sets": sets.toString(),
      "setComplete": setsComplete.toString(),
      "exercises": exercises.map((h) => h.toJson()).toList(),
      "id": id,
      "name": name,
      "type": type,
      "film":film,
      "filmURL": filmURL,
      "comments": comments,
      "feedback": feedback,
    };
  }

  @override
  Widget listBuild(Function setScreen, Function setSavable) {
    return Card(
        color: Colors.white,
        child: ListTile(
            title: Text(name,
                style: TextStyle(
                    color: Color(0xFF6A8D73),
                    fontWeight: FontWeight.bold)),
            subtitle: Text(type),
            trailing: (this.setsComplete == this.sets)? new Icon(FontAwesome.smile_o,
                color: Color(0xFF6A8D73)) : Text('${this.setsComplete}/${this.sets}'),
            onTap: () {
              setScreen(WorkoutCircuit(this, setScreen, setSavable));
            }
        ));
  }

  @override
  Widget listBuildSummary(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
                side: BorderSide(
                  color: Colors.grey.withOpacity(0.2),
                  width: 1,
                ),
              ),
              color: Colors.white,
              child: ListTile(
                  title: Text(name,
                      style: TextStyle(
                          color: Color(0xFF6A8D73), fontWeight: FontWeight.bold)),
                  subtitle: Text(type),
                  trailing: (this.setsComplete == this.sets)? new Icon(FontAwesome.smile_o,
                      color: Color(0xFF6A8D73)) : Text('${this.setsComplete}/${this.sets}'),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> Scaffold(
                      appBar: AppBar(
                        automaticallyImplyLeading: false,
                        elevation: 0,
                        backgroundColor: Colors.grey[200],
                        title: Padding(
                            padding: EdgeInsets.all(0.0),
                            child: Image(
                                alignment: Alignment.bottomLeft,
                                image: AssetImage('images/xuan_logo.png'),
                                height: 30,
                                width: 30)),
                      ),
                      body: WorkoutCircuitSummary(this),
                    )));
                  }))
        ],
      ),
    );
  }

  Future<void> saveFilm(String storagePath) async{
    if(pickedFile == null)
      return;

    final file = File(pickedFile.path);
    TaskSnapshot snapshot = await FirebaseStorage
        .instance.ref('$storagePath')
        .child('$id')
        .putFile(file);
    if(snapshot.state == TaskState.success){
      final String downloadUrl = await snapshot.ref.getDownloadURL();
      filmURL = downloadUrl;
      print("FILMED SET SAVED");
      print(downloadUrl);
      pickedFile = null;
    }else{
      print("Error saving filmed set");
    }
  }
}