import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:xuan_fitness/models/fitness/section_entry.dart';
import 'package:xuan_fitness/pages/fitness/workout_exercise.dart';
import 'package:xuan_fitness/pages/fitness/workout_exercise_summary.dart';

class Exercise extends SectionEntry {
  String comments,
      cues,
      url,
      videoId,
      setWeight,
      repUnits,
      exerciseKey,
      filmURL;
  int setComplete, setCount, setReps;
  bool film;
  PickedFile pickedFile;
  Exercise(
      this.comments,
      this.cues,
      this.url,
      this.videoId,
      this.setComplete,
      this.setCount,
      this.setReps,
      this.setWeight,
      String id,
      String name,
      String type,
      String feedback)
      : super(id, name, type, feedback);
  Exercise.fromJson(Map<String, dynamic> json)
      : comments = json['comments'] ?? "",
        cues = json['cues'] ?? "",
        url = json['url'],
        setComplete = int.parse(json['setComplete'] ?? "0"),
        setCount = int.parse(json['sets']),
        setReps = int.parse(json['reps']),
        setWeight = json['weight'] ?? "",
        repUnits = json['repUnits'] ?? "reps",
        exerciseKey = json['exerciseKey'] ?? "0",
        film = json['film'] ?? false,
        filmURL = json['filmURL'] ?? "",
        super.fromJson(json);

  Map<String, dynamic> toJson() {
    return {
      "comments": comments,
      "cues": cues,
      "url": url,
      "setComplete": setComplete.toString(),
      "sets": setCount.toString(),
      "reps": setReps.toString(),
      "weight": setWeight,
      "repUnits": repUnits,
      "id": id,
      "name": name,
      "type": type,
      "exerciseKey": exerciseKey,
      "film": film,
      "filmURL": filmURL,
      "feedback": feedback,
    };
  }

  @override
  Widget listBuild(Function setScreen, Function setSavable) {
    return Card(
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
            trailing: (this.setCount == this.setComplete)
                ? new Icon(FontAwesome.smile_o, color: Color(0xFF6A8D73))
                : Text('${this.setComplete}/${this.setCount}'),
            onTap: () {
              setScreen(WorkoutDetail(this, setScreen, setSavable));
            }));
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
                          color: Color(0xFF6A8D73),
                          fontWeight: FontWeight.bold)),
                  subtitle: Text(type),
                  trailing: (this.setCount == this.setComplete)
                      ? new Icon(FontAwesome.smile_o, color: Color(0xFF6A8D73))
                      : Text('${this.setComplete}/${this.setCount}'),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Scaffold(
                                  appBar: AppBar(
                                    automaticallyImplyLeading: false,
                                    elevation: 0,
                                    backgroundColor: Colors.white,
                                    title: Padding(
                                        padding: EdgeInsets.all(0.0),
                                        child: Image(
                                            alignment: Alignment.bottomLeft,
                                            image: AssetImage(
                                                'images/xuan_logo.png'),
                                            height: 30,
                                            width: 30)),
                                  ),
                                  body: WorkoutDetailSummary(this),
                                )));
                  })),
          (feedback == "")
              ? Container()
              : Container(
                  padding: EdgeInsets.fromLTRB(8, 0, 8, 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.chat_bubble, size: 15, color: Color(0xFF6A8D73),),
                      Text(feedback,style: TextStyle(color: Color(0xFF6A8D73),),)
                    ],
                  ))
        ],
      ),
    );
  }

  Future<void> saveFilm(String storagePath) async {
    if (pickedFile == null) return;

    final file = File(pickedFile.path);
    TaskSnapshot snapshot = await FirebaseStorage.instance
        .ref('$storagePath')
        .child('$id')
        .putFile(file);
    if (snapshot.state == TaskState.success) {
      final String downloadUrl = await snapshot.ref.getDownloadURL();
      filmURL = downloadUrl;
      print("FILMED SET SAVED");
      print(downloadUrl);
      pickedFile = null;
    } else {
      print("Error saving filmed set");
    }
  }
}
