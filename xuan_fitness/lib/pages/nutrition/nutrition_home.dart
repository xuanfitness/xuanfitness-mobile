import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter/material.dart';
import 'package:timelines/timelines.dart';

class NutritionHome extends StatefulWidget {
  @override
  NutritionHomeState createState() => new NutritionHomeState();
}

class NutritionHomeState extends State<NutritionHome> {
  static String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          decoration: BoxDecoration(
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.white,
                blurRadius: 1,
                //offset: Offset(0, 2),
              ),
            ],
          ),
          //color: Colors.green,
          padding: const EdgeInsets.only(bottom: 8),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Nutrition',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontFamily: 'cabin',
                    fontSize: 40,
                    color: Colors.green,

                    //fontWeight: w600
                  ),
                ),
                Text('$formattedDate'),
              ]),
        ),
        Container(
          decoration: BoxDecoration(
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.green,
                blurRadius: 1,
                offset: Offset(0, 2),
              ),
            ],
          ),
          //color: Colors.green,
          padding: const EdgeInsets.only(bottom: 8),
          child: Image.asset('images/spagetti.jpg'),
        ),
        Container(
          decoration: BoxDecoration(
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.green,
                blurRadius: 1,
                offset: Offset(0, 2),
              ),
            ],
          ),
          padding: const EdgeInsets.only(bottom: 8),
          child: Image.asset('images/waffles.jpg'),
        ),
        Container(
          decoration: BoxDecoration(
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.green,
                blurRadius: 1,
                offset: Offset(0, 2),
              ),
            ],
          ),
          padding: const EdgeInsets.only(bottom: 8),
          child: Image.asset('images/sushi.jpg'),
        ),
      ],
    );
  }
}
