import 'package:xuan_fitness/models/fitness/section_entry.dart';

class Exercise extends SectionEntry{
  String comments, cues, url, videoId;
  int setComplete, setCount, setReps, setWeight;
  Exercise(this.comments, this.cues, this.url, this.videoId,
          this.setComplete, this.setCount, this.setReps, this.setWeight, String id, String name, Type type):super(id, name, type);
  Exercise.fromJson(Map<String, dynamic>json):
      comments = json['comments'],
      cues = json['cues'],
      url = json['url'],
      videoId = json['videoId'],
      setComplete = json['setComplete'],
      setCount = json['setCount'],
      setReps = json['setReps'],
      setWeight = json['setWeight'],
      super.fromJson(json);
}