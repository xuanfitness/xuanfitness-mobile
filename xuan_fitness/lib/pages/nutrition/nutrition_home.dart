import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xuan_fitness/pages/nutrition/nutrition_details.dart';
import 'package:xuan_fitness/repositories/nutrition_repository.dart';
import 'package:xuan_fitness/widgets/nutrition/meal_widget.dart';

class NutritionHome extends StatefulWidget {
  final ScrollController _scrollController = ScrollController();
  @override
  NutritionHomeState createState() => new NutritionHomeState();
}

class NutritionHomeState extends State<NutritionHome> {
  static String formattedDate = DateFormat('EEEE, MMMM dd yyyy').format(DateTime.now());
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, NutritionRepository nutritionRepository, _) {
      return Scaffold(
        //backgroundColor: Color(0xFFFFEB3),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          //backgroundColor: Color(0xFFFFEB3),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                margin: EdgeInsets.all(8.0),

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
                //child: Scrollbar(isAlwaysShown:true, controller:_scrollController,)
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Nutrition',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontFamily: 'cabin',
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF6A8D73),

                            //fontWeight: w600
                          ),
                        ),
                      ),
                      SizedBox(height: 30),
                      Text('Today',
                          style: TextStyle(
                            fontFamily: 'cabin',
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFA2C2A9),
                          )),
                      Text('$formattedDate',
                          style: TextStyle(
                            fontFamily: 'cabin',
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF6A8D73),
                          )),
                    ]),
              ),
              // SizedBox(height: 50),
              ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: nutritionRepository.meals.length,
                  itemBuilder: (BuildContext context, int index) {
                    return new MealCard(nutritionRepository.meals[index]);
                  },
              ),
              ButtonTheme(
                minWidth: 200.0,
                // color: Colors.white,
                //child: new Container(
                //padding: EdgeInsets.all(0),
                child: RaisedButton(
                  color: Color(0xFF6A8D73),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NutritionDetail(nutritionRepository),
                      ),
                    );
                  },
                  child:
                  Text('Add new meal', style: TextStyle(color: Colors.white)),
                ),
              ),
              //)
            ],
          ),
        ),
      );
      }
    );
  }
}
