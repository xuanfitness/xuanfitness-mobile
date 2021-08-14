import 'package:flutter/material.dart';

class Meal {
  String description, meal, photoID;
  Image img;

  Meal(this.description, this.photoID, this.meal) {
    //constructor
    this.img = Image.network(photoID);
    this.meal = meal;
    this.description = description;
  }
  /**
   * (JSON) is a standard text-based format for representing structured data based on JavaScript object syntax. 
   * It is commonly used for transmitting data in web applications 
   **/

  Meal.fromJson(Map<String, dynamic> json)
      : description = json["description"],
        photoID = json["photoID"];
  // meal = json["meal"];
}
