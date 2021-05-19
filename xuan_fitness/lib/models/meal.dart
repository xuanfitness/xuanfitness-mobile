import 'package:flutter/material.dart';

class Meal {
  String title, imageId;
  Image img;

  Meal(this.title, this.imageId) {
    this.img = Image.network(imageId);
  }

  Meal.fromJson(Map<String, dynamic>json):
        title = json["title"],
        imageId = json["imageId"];
}