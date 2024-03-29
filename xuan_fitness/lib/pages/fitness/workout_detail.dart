import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:xuan_fitness/widgets/workout/workouts.dart';

import 'WorkoutData.dart';

//import 'package:youtube_player_flutter/youtube_player_flutter.dart';

//import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class WorkoutDetail extends StatefulWidget {
  //require the page to accept a WorkoutData object;
  // final WorkoutData workoutData;
  String text;

  String getText() {
    return text;
  }

  WorkoutDetail({Key key, this.text}) : super(key: key);

  final String title = "Workouts";

  @override
  _WorkoutDetailState createState() => _WorkoutDetailState();
}

//class
class _WorkoutDetailState extends State<WorkoutDetail> {
  bool _hasBeenPressed = false;
  bool _hasBeenPressed1 = false;
  bool _hasBeenPressed2 = false;

  final List<String> entries = <String>['insert videos here'];
  final List<String> subentries = <String>['idk honestly'];
  final List<int> colorCodes = <int>[700];

  String formattedDate = DateFormat('MM-dd-yyyy').format(DateTime.now());
  YoutubePlayerController _controller;

  WorkoutDetail workoutDetail = new WorkoutDetail();
  // String text = WorkoutDetail.getText();

  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: 'uZbig5yMlN8',
      flags: const YoutubePlayerFlags(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
      return Material(
          child: SingleChildScrollView(
              child: ConstrainedBox(
                  constraints:
                      BoxConstraints(minHeight: viewportConstraints.maxHeight),
                  child: Container(
                      padding: EdgeInsets.fromLTRB(5, 25, 5, 0),
                      color: Colors.white,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                        'Workout',
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

                                    //button to navigate back to the previous page
                                    FlatButton(
                                      color: Colors.white,
                                      child: Text("Back",
                                          style: TextStyle(
                                              color: Color(0xFF6A8D73))),
                                      onPressed: () {
                                        // Navigate back to first route when tapped.
                                        Navigator.pop(context);
                                      },
                                      shape: RoundedRectangleBorder(
                                          side: BorderSide(
                                              color: Color(0xFF6A8D73),
                                              width: 1,
                                              style: BorderStyle.solid),
                                          borderRadius:
                                              BorderRadius.circular(50)),
                                    ),

                                    //Ask what we want to put here
                                    Text('Leg Day',
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
                                    SizedBox(height: 20),

                                    //should say the name of the workout
                                    Text('Mountain Climbers',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          fontFamily: 'cabin',
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        )),
                                  ]),
                            ),
                            Center(
                              // child: Container(
                              //   margin: const EdgeInsets.all(1),
                              //   color: Colors.amber[600],
                              //   width: 1000,
                              //   height: 200.0,
                              //   child: Text('Video should be here'),
                              // ),
                              child: Container(
                                child: YoutubePlayerBuilder(
                                    player: YoutubePlayer(
                                      controller: _controller,
                                    ),
                                    builder: (context, player) {
                                      return player;
                                    }),
                              ),
                            ),
                            Container(
                              width: 1000,
                              height: 100,
                              child: Text(
                                  'Remember to keep your feet shoulder width apart!',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: 'cabin',
                                      fontSize: 15,
                                      height: 4,
                                      color: Color(0xFF6A8D73)
                                      //fontWeight: FontWeight.bold,
                                      )),
                              decoration: BoxDecoration(
                                color: Color(0xFFCFE8D5),
                                borderRadius: BorderRadius.circular(20),
                                /*boxShadow: [
                        BoxShadow(
                          color: Colors.red,
                          blurRadius: 4,
                          offset: Offset(4, 8), // Shadow position
                        ),
                      ],*/
                              ),
                            ),
                            Row(
                                //mainAxisAlignment:
                                // MainAxisAlignment.spaceEvenly,

                                children: <Widget>[
                                  Text('Sets',
                                      textAlign: TextAlign.left,
                                      //textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontFamily: 'cabin',
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      )),
                                  SizedBox(width: 250),
                                  ButtonTheme(
                                    minWidth: 20,
                                    height: 40,
                                    //child: new Container(
                                    //padding: EdgeInsets.all(0),
                                    child: RaisedButton.icon(
                                      color: Color(0xFF6A8D73),
                                      onPressed: () => {},
                                      icon: Icon(Icons.video_call_rounded,
                                          color: Colors.white),
                                      label: Text('Film Set',
                                          style:
                                              TextStyle(color: Colors.white)),
                                    ),
                                  ),
                                ]),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                ButtonTheme(
                                  minWidth: 50,
                                  height: 100.0,
                                  child: RaisedButton(
                                      child: new Text('12 reps'),
                                      textColor: Color(0xFF6A8D73),
                                      // 2
                                      color: _hasBeenPressed
                                          ? Color(0xFFCFE8D5)
                                          : Colors.white,
                                      // 3
                                      onPressed: () => {
                                            setState(() {
                                              _hasBeenPressed =
                                                  !_hasBeenPressed;
                                            })
                                          }),
                                ),
                                ButtonTheme(
                                  minWidth: 50,
                                  height: 100.0,
                                  child: RaisedButton(
                                      child: new Text('12 reps'),
                                      textColor: Color(0xFF6A8D73),
                                      // 2
                                      color: _hasBeenPressed1
                                          ? Color(0xFFCFE8D5)
                                          : Colors.white,
                                      // 3
                                      onPressed: () => {
                                            setState(() {
                                              _hasBeenPressed1 =
                                                  !_hasBeenPressed1;
                                            })
                                          }),
                                ),
                                ButtonTheme(
                                  minWidth: 50,
                                  height: 100.0,
                                  child: RaisedButton(
                                      child: new Text('12 reps'),
                                      textColor: Color(0xFF6A8D73),
                                      // 2
                                      color: _hasBeenPressed2
                                          ? Color(0xFFCFE8D5)
                                          : Colors.white,
                                      // 3
                                      onPressed: () => {
                                            setState(() {
                                              _hasBeenPressed2 =
                                                  !_hasBeenPressed2;
                                            })
                                          }),
                                ),

                                //not sure why but all the buttons are changing colors at the same time
                              ],
                            ),
                            Container(
                              // padding: EdgeInsets.all(2.0),
                              child: new Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    new Row(children: <Widget>[
                                      new Expanded(
                                          child: new Text(
                                        "Comments:",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            decorationColor: Colors.red,
                                            fontFamily: 'Cabin',
                                            color: Color(0xFF6A8D73)),
                                      )),
                                    ]),
                                    new TextField(
                                        style: TextStyle(
                                            color: Color(0xFF6A8D73))),
                                  ]),
                            ),
                            ButtonTheme(
                              minWidth: 300,
                              height: 40,
                              //child: new Container(
                              //padding: EdgeInsets.all(0),
                              child: RaisedButton(
                                color: Color(0xFF6A8D73),
                                onPressed: () => {},
                                //icon: Icon(Icons.home),
                                child: Text('Submit',
                                    style: TextStyle(color: Colors.white)),
                              ),
                            ),
                          ])))));
    });
    // backgroundColor: Color(0xFFFFEB3),
    // child: Container(
    //   color: Colors.white,
    //   child: Column(
    //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //       children: [
    //         Text("hello"),
    //     Container(
    //       margin: EdgeInsets.all(8.0),
    //
    //       decoration: BoxDecoration(
    //         boxShadow: <BoxShadow>[
    //           BoxShadow(
    //             color: Colors.white,
    //             blurRadius: 1,
    //             //offset: Offset(0, 2),
    //           ),
    //         ],
    //       ),
    //       //color: Colors.green,
    //       padding: const EdgeInsets.only(bottom: 8),
    //       //child: Scrollbar(isAlwaysShown:true, controller:_scrollController,)
    //       child: Column(
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: <Widget>[
    //             Align(
    //               alignment: Alignment.centerLeft,
    //               child: Text(
    //                 'Workouts',
    //                 textAlign: TextAlign.left,
    //                 style: TextStyle(
    //                   fontFamily: 'cabin',
    //                   fontSize: 40,
    //                   fontWeight: FontWeight.bold,
    //                   color: Color(0xFF6A8D73),
    //
    //                   //fontWeight: w600
    //                 ),
    //               ),
    //             ),
    //             SizedBox(height: 30),
    //             Text('Today',
    //                 style: TextStyle(
    //                   fontFamily: 'cabin',
    //                   fontSize: 20,
    //                   fontWeight: FontWeight.bold,
    //                   color: Color(0xFFA2C2A9),
    //                 )),
    //             Text('$formattedDate',
    //                 style: TextStyle(
    //                   fontFamily: 'cabin',
    //                   fontSize: 20,
    //                   fontWeight: FontWeight.bold,
    //                   color: Color(0xFF6A8D73),
    //                 )),
    //           ]),
    //     ),
    //     new ListView.builder(
    //       padding: const EdgeInsets.all(20),
    //       itemCount: entries.length,
    //       itemBuilder: (BuildContext context, int index) {
    //         return Card(
    //           elevation: 5,
    //           child: Padding(
    //             padding: const EdgeInsets.all(100),
    //             child: ListTile(
    //               title: Text('${entries[index]}'),
    //               subtitle: Text('${subentries[index]}'),
    //             ),
    //           ),
    //           color: Colors.green[colorCodes[index]],
    //         );
    //       },
    //     ),
    //   ]),
    // ));
  }
}
