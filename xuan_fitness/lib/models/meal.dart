import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class Meal {
  String title, description, imageURL, feedback;
  CachedNetworkImage img;

  Meal(this.title, this.imageURL, this.description, this.feedback) {
    this.img = CachedNetworkImage(
      imageUrl: imageURL,
      progressIndicatorBuilder: (context, url, downloadProgress) =>
      new CircularProgressIndicator(value: downloadProgress.progress),
      errorWidget: (context, url, error) => new Icon(Icons.error),
    );
  }

  Meal.fromJson(Map<String, dynamic> json)
      : title = json["title"],
        description = json["description"],
        feedback = json["feedback"],
        imageURL = json["imageURL"] {
    // img = Image.network(imageURL, height: 300, fit: BoxFit.fill);
    img = CachedNetworkImage(
      imageUrl: imageURL,
      progressIndicatorBuilder: (context, url, downloadProgress) =>
          new CircularProgressIndicator(value: downloadProgress.progress),
      errorWidget: (context, url, error) => new Icon(Icons.error),
    );
  }

  Map<String, dynamic> toJson() {
    return {"description": description, "name": title, "url": imageURL};
  }
}
