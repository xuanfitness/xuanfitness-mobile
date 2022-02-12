class Habit{
  String question, response, feedback;
  Habit(this.question, this.response, this.feedback);
  Habit.fromJson(Map<String, dynamic>json):
        question = json["question"],
        response = json["response"]??"",
        feedback = json["feedback"]??"";
  Map<String, dynamic> toJson(){
    return {
      "question" : question,
      "response" : response,
      "feedback" : feedback,
    };
  }
  // String toJson(){
  //   return this.toObject().toString();
  // }
  void update(String newResponse){
    this.response = newResponse;
  }
}