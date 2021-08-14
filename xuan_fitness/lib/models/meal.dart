import 'package:flutter/material.dart';

class Meal {
  String title, description, imageURL;
  Image img;

  Meal(this.title, this.imageURL, this.description) {
    this.img = Image.network(imageURL);
  }

  Meal.fromJson(Map<String, dynamic> json)
      : title = json["title"],
        description = json["description"],
        imageURL = json["imageURL"] {
    img = Image.network(imageURL, height: 300, fit: BoxFit.fill);
  }

  Map<String, dynamic> toJson() {
    return {"description": description, "name": title, "url": imageURL};
  }
}
