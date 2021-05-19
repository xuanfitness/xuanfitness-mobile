class Habit{
  String question, response;
  Habit(this.question, this.response);
  Habit.fromJson(Map<String, dynamic>json):
        question = json["question"],
        response = json["response"]??"";
}