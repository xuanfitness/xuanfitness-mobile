//this is where you get navigated to after you click "add meal"
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter/material.dart';
import 'package:xuan_fitness/pages/nutrition/nutrition_home.dart';
import 'package:xuan_fitness/widgets/camera.dart';
// import 'package:firebase_database/firebase_database.dart';


//import 'package:image_picker/image_picker.dart';

// final databaseReference = FirebaseDatabase.instance.reference();

class NutritionDetail extends StatefulWidget {
  final ScrollController _scrollController = ScrollController();
  @override
  NutritionDetailState createState() => new NutritionDetailState();
}

class NutritionDetailState extends State<NutritionDetail> {
  static String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  //var _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Color(0xFFFFEB3),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        //backgroundColor: Color(0xFFFFEB3),
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.all(12.0),

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
                        color: Color(0xFFCFE8D5),
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

          Ink(color: Color(0xFFCFE8D5)),

          new Card(
            color: Color(0xFFCFE8D5),
            child: new Container(
              padding: EdgeInsets.all(10.0),
              child: new Column(
                children: <Widget>[
                  new Row(children: <Widget>[
                    new Expanded(
                      child: new Text(
                        "Breakfast, Lunch, Dinner, or Snack?",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            decorationColor: Colors.red,
                            fontFamily: 'Cabin',
                            color: Color(0xFF6A8D73)),
                      ),
                    ),
                    new Expanded(
                      child: new TextField(),
                    ),
                  ]),
                ],
              ),
            ),
          ),
          SizedBox(height: 30),
          new Card(
            color: Color(0xFFCFE8D5),
            child: new Container(
              padding: EdgeInsets.all(10.0),
              child: new Column(
                children: <Widget>[
                  new Row(
                    children: <Widget>[
                      new Expanded(
                          child: new Text(
                        "Description:",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            decorationColor: Colors.red,
                            fontFamily: 'Cabin',
                            color: Color(0xFF6A8D73)),
                      )),
                      new Expanded(
                        child: new TextField(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 30),

          new Card(
            color: Colors.white,
            child: new Row(
                //child: new Container(
                //padding: EdgeInsets.all(0),
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox.fromSize(
                    size: Size(30, 30), // button width and height
                    child: ClipOval(
                      child: Material(
                        color: Color(0xFF6A8D73), // button color
                        child: InkWell(
                          splashColor: Color(0xFF6A8D73), // splash color
                          onTap: () {
                            //Navigator.of(context).pop();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Camera(title: "test"),
                              ),
                            );
                            // show the camera
                          }, // button pressed
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(Icons.camera_alt_outlined,
                                  color: Colors.white), // icon
                              //Text("Call"), // text
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  RaisedButton(
                    padding: EdgeInsets.all(10.0),
                    color: Color(0xFF6A8D73),
                    onPressed: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NutritionHome(),
                        ),
                      ),
                    },
                    child:
                        Text('Submit', style: TextStyle(color: Colors.white)),
                  ),
                ]),
          ),
          // ),
        ]),
      ),
    );
  }

  // void createHabits(){
  //     databaseReference.child("0").set({
  //   'description': 'test-description',
  //   'meal': 'breakfast'
  //   'photoID' 'testID'
  // });
  // databaseReference.child("1").set({
  //   'title': 'Flutter in Action',
  //   'description': 'Complete Programming Guide to learn Flutter'
  // });
  // }
}
