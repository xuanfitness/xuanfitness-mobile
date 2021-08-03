class Habit{
  String question, response;
  Habit(this.question, this.response);
  Habit.fromJson(Map<String, dynamic>json):
        question = json["question"],
        response = json["response"]??"";
  Map<String, dynamic> toJson(){
    return {
      "question" : question,
      "response" : response
    };
  }
  // String toJson(){
  //   return this.toObject().toString();
  // }
  void update(String newResponse){
    this.response = newResponse;
  }
}