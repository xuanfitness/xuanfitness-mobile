import 'package:flutter/material.dart';

class Meal {
  String id, title, imageId;
  Image img;

  Meal(this.id, this.title, this.imageId) {
    this.img = Image.network(imageId);
  }

  Meal.fromJson(Map<String, dynamic>json):
        id = json["id"],
        title = json["title"],
        imageId = json["imageId"];
}