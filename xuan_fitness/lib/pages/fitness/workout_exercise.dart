import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter/material.dart';
import 'package:xuan_fitness/models/fitness/exercise.dart';
import 'package:xuan_fitness/pages/fitness/set.dart';
import 'package:xuan_fitness/pages/fitness/workout_home.dart';
import 'package:xuan_fitness/pages/fitness/workout_list.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class WorkoutDetail extends StatefulWidget {
  final Exercise exercise;
  Function setScreen;
  WorkoutDetail(this.exercise, this.setScreen);

  @override
  _WorkoutDetailState createState() => _WorkoutDetailState();
}

class _WorkoutDetailState extends State<WorkoutDetail> {
  String formattedDate =
      DateFormat('EEEE, MMMM dd yyyy').format(DateTime.now());
  YoutubePlayerController _controller;

  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(widget.exercise.url),
      flags: const YoutubePlayerFlags(autoPlay: false),
    );
  }

  void changeSet(bool state) {
    if (!state) {
      widget.exercise.setComplete--;
    } else {
      widget.exercise.setComplete++;
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
      return Material(
          child: SingleChildScrollView(
              physics: ScrollPhysics(),
              child: ConstrainedBox(
                  constraints:
                      BoxConstraints(minHeight: viewportConstraints.maxHeight),
                  child: Container(
                      padding: EdgeInsets.fromLTRB(20, 25, 20, 300),
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.white,
                          Colors.grey[300],
                        ],
                      )),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                    color: Colors.white,
                                    blurRadius: 1,
                                  ),
                                ],
                              ),
                              padding: const EdgeInsets.only(bottom: 8, top: 8),
                              child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        widget.exercise.name,
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
                                        widget.setScreen(
                                            WorkoutList(widget.setScreen));
                                      },
                                      shape: RoundedRectangleBorder(
                                          side: BorderSide(
                                              color: Color(0xFF6A8D73),
                                              width: 1,
                                              style: BorderStyle.solid),
                                          borderRadius:
                                              BorderRadius.circular(50)),
                                    ),
                                  ]),
                            ),
                            Center(
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
                            Center(
                              child: Container(
                                width: double.infinity,
                                margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                                padding: EdgeInsets.fromLTRB(15, 30, 15, 30),
                                child: Text(
                                    'Remember to keep your feet shoulder width apart!',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontFamily: 'cabin',
                                        fontSize: 15,
                                        color: Color(0xFF6A8D73)
                                        //fontWeight: FontWeight.bold,
                                        )),
                                decoration: BoxDecoration(
                                  color: Color(0xFFCFE8D5),
                                  // borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            ),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                            SizedBox(
                              height: 90.0,
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: widget.exercise.setCount,
                                  itemBuilder: (ctx, int) {
                                    return SetButton(
                                        changeSet,
                                        int + 1 <= widget.exercise.setComplete,
                                        '${widget.exercise.setWeight} x ${widget.exercise.setReps} reps');
                                  }),
                            ),
                            Container(
                              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
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
                            // Center(
                            //   child: ButtonTheme(
                            //     minWidth: 300,
                            //     height: 40,
                            //     //child: new Container(
                            //     //padding: EdgeInsets.all(0),
                            //     child: RaisedButton(
                            //       color: Color(0xFF6A8D73),
                            //       onPressed: () => {},
                            //       //icon: Icon(Icons.home),
                            //       child: Text('Submit',
                            //           style: TextStyle(color: Colors.white)),
                            //     ),
                            //   ),
                            // ),
                          ])))));
    });
  }
}
