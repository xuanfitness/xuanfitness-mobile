import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter/material.dart';
import 'package:xuan_fitness/pages/nutrition/nutrition_details.dart';

class NutritionHome extends StatefulWidget {
  final ScrollController _scrollController = ScrollController();
  @override
  NutritionHomeState createState() => new NutritionHomeState();
}

class NutritionHomeState extends State<NutritionHome> {
  static String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  var _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
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
            Container(
              margin: EdgeInsets.all(8.0),
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8.0))),
                child: InkWell(
                  onTap: () => print("ciao"),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8.0),
                          topRight: Radius.circular(8.0),
                        ),
                        child: Image.asset('images/spagetti.jpg',
                            // width: 300,
                            height: 300,
                            fit: BoxFit.fill),
                      ),
                      ListTile(
                        title: Text(
                          'Breakfast',
                          style: TextStyle(
                            color: Color(0xFFA2C2A9),
                            fontWeight: FontWeight.bold,
                          ),
                          //subtitle: Text('Location 1'),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(8.0),
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8.0))),
                child: InkWell(
                  onTap: () => print("ciao"),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8.0),
                          topRight: Radius.circular(8.0),
                        ),
                        child: Image.asset('images/waffles.jpg',
                            // width: 300,
                            height: 300,
                            fit: BoxFit.fill),
                      ),
                      ListTile(
                        title: Text(
                          'Lunch',
                          style: TextStyle(
                            color: Color(0xFFA2C2A9),
                            fontWeight: FontWeight.bold,
                          ),
                          //subtitle: Text('Location 1'),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(8.0),
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8.0))),
                child: InkWell(
                  onTap: () => print("ciao"),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8.0),
                          topRight: Radius.circular(8.0),
                        ),
                        child: Image.asset('images/sushi.jpg',
                            // width: 300,
                            height: 300,
                            fit: BoxFit.fill),
                      ),
                      ListTile(
                        title: Text(
                          'Dinner',
                          style: TextStyle(
                            color: Color(0xFFA2C2A9),
                            fontWeight: FontWeight.bold,
                          ),
                          //subtitle: Text('Location 1'),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 16),
                child: TextField(
                  style: TextStyle(color: Color(0xFFA2C2A9)),
                  controller: _controller,
                  decoration: InputDecoration(
                    hintText: "Add more food",
                    hintStyle: TextStyle(color: Color(0xFFA2C2A9)),
                    fillColor: Color(0xFFA2C2A9),
                    suffixIcon: IconButton(
                        icon: Icon(Icons.add, color: Color(0xFFA2C2A9)),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => NutritionDetail(),
                            ),
                          );
                          print(_controller.text);
                        }),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
