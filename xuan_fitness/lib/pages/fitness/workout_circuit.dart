import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter/material.dart';
import 'package:xuan_fitness/models/fitness/circuit.dart';
import 'package:xuan_fitness/pages/fitness/set.dart';
import 'package:xuan_fitness/pages/fitness/workout_list.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:xuan_fitness/widgets/workout/workouts.dart';

class WorkoutCircuit extends StatefulWidget {
  final Circuit circuit;
  Function setScreen;
  WorkoutCircuit(this.circuit, this.setScreen);

  @override
  _WorkoutCircuitState createState() => _WorkoutCircuitState();
}

class _WorkoutCircuitState extends State<WorkoutCircuit> {
  String formattedDate =
      DateFormat('EEEE, MMMM dd yyyy').format(DateTime.now());
  List<YoutubePlayerController> _controllers;

  void initState() {
    super.initState();
    _controllers = widget.circuit.exercises
        .map((exercise) => YoutubePlayerController(
              initialVideoId: YoutubePlayer.convertUrlToId(exercise.url),
              flags: const YoutubePlayerFlags(autoPlay: false),
            ))
        .toList();
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
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                        'Superset',
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
                                child: Column(
                                    children: widget.circuit.exercises
                                        .asMap()
                                        .entries
                                        .map((entry) => Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                    "${entry.key + 1}. ${entry.value.name}",
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                      fontFamily: 'cabin',
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black,
                                                    )),
                                                Container(
                                                  child: YoutubePlayerBuilder(
                                                      player: YoutubePlayer(
                                                        controller:
                                                            _controllers[
                                                                entry.key],
                                                      ),
                                                      builder:
                                                          (context, player) {
                                                        return player;
                                                      }),
                                                ),
                                                Container(
                                                  width: double.infinity,
                                                  margin: EdgeInsets.fromLTRB(
                                                      0, 10, 0, 10),
                                                  padding: EdgeInsets.fromLTRB(
                                                      15, 30, 15, 30),
                                                  child: Text(
                                                      'Remember to keep your feet shoulder width apart!',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          fontFamily: 'cabin',
                                                          fontSize: 15,
                                                          color:
                                                              Color(0xFF6A8D73)
                                                          //fontWeight: FontWeight.bold,
                                                          )),
                                                  decoration: BoxDecoration(
                                                    color: Color(0xFFCFE8D5),
                                                    // borderRadius: BorderRadius.circular(20),
                                                  ),
                                                )
                                              ],
                                            ))
                                        .toList())),
                            Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text('Rounds',
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
                                  itemCount: widget.circuit.sets,
                                  itemBuilder: (ctx, int) {
                                    return SetButton(
                                        (bool state) {
                                          if(!state) {
                                            widget.circuit.setsComplete--;
                                          }else{
                                            widget.circuit.setsComplete++;
                                          }
                                        },
                                        int + 1 < widget.circuit.setsComplete,
                                      '${int + 1}'
                                    );
                                  }),
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
