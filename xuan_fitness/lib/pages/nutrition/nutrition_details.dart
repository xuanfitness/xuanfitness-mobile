//this is where you get navigated to after you click "add meal"
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter/material.dart';
import 'package:xuan_fitness/pages/nutrition/nutrition_home.dart';
import 'package:xuan_fitness/repositories/nutrition_repository.dart';
import 'package:xuan_fitness/widgets/camera.dart';
//import 'package:image_picker/image_picker.dart';

class NutritionDetail extends StatefulWidget {
  final NutritionRepository nutritionRepository;
  NutritionDetail(this.nutritionRepository);

  @override
  NutritionDetailState createState() => new NutritionDetailState();
}

class NutritionDetailState extends State<NutritionDetail> {
  static String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  String mealName, mealDetails;
  PickedFile _imageFile;

  Widget _previewImage() {
    if (_imageFile != null) {
      if (kIsWeb) {
        // Why network?
        // See https://pub.dev/packages/image_picker#getting-ready-for-the-web-platform
        return Image.network(_imageFile.path);
      } else {
        return Semantics(
            child: Image.file(File(_imageFile.path)),
            label: 'image_picker_example_picked_image');
      }
    } else {
      return const Text(
        'You have not yet picked an image.',
        textAlign: TextAlign.center,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme
            .of(context)
            .primaryColorLight,
        iconTheme: IconThemeData(
          color: Theme
              .of(context)
              .primaryColor,
        ),
      ),
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
                        "Meal Name:",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            decorationColor: Colors.red,
                            fontFamily: 'Cabin',
                            color: Color(0xFF6A8D73)),
                      ),
                    ),
                    new Expanded(
                      child: new TextField(
                        onChanged: (text)=> mealName = text,
                      ),
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
                        child: new TextField(
                          onChanged: (text)=> mealDetails = text,
                        ),
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
                          onTap: () async{
                            //Navigator.of(context).pop();
                            var navigationResult = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Camera(title: mealName??"Image for New Meal"),
                              ),
                            );
                            if(navigationResult != null){
                              setState(() {
                                _imageFile = navigationResult;
                              });
                            }
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
                    onPressed: () {
                      if(_imageFile != null){
                        widget.nutritionRepository.addMeal(mealName, mealDetails, _imageFile.path);
                        Navigator.of(context).pop(null);
                      }
                    },
                    child:
                        Text('Submit', style: TextStyle(color: Colors.white)),
                  ),
                ]),
          ),
              _previewImage()
          // ),
        ]),
      ),
    );
  }
}
