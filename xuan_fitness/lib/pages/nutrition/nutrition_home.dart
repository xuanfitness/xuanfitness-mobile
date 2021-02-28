import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class NutritionHome extends StatefulWidget {
  @override
  NutritionHomeState createState() => new NutritionHomeState();
}

class NutritionHomeState extends State<NutritionHome> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Image.asset('images/spagetti.jpg'),
        Image.asset('images/waffles.jpg'),
        Image.asset('images/sushi.jpg'),
      ],
    );
  }
}
