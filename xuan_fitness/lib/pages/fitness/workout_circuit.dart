import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter/material.dart';
import 'package:xuan_fitness/models/fitness/circuit.dart';
import 'package:xuan_fitness/pages/fitness/set.dart';
import 'package:xuan_fitness/pages/fitness/workout_list.dart';
import 'package:xuan_fitness/widgets/camera.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class WorkoutCircuit extends StatefulWidget {
  final Circuit circuit;
  Function setScreen, setSavable;
  WorkoutCircuit(this.circuit, this.setScreen, this.setSavable);

  @override
  _WorkoutCircuitState createState() => _WorkoutCircuitState();
}

class _WorkoutCircuitState extends State<WorkoutCircuit> {
  String formattedDate =
      DateFormat('EEEE, MMMM dd yyyy').format(DateTime.now());
  List<YoutubePlayerController> _controllers;
  String filmUrl;
  PickedFile _pickedFile;

  void initState() {
    super.initState();
    filmUrl = widget.circuit.filmURL;
    _pickedFile = widget.circuit.pickedFile;

    _controllers = widget.circuit.exercises
        .map((exercise) => YoutubePlayerController(
              initialVideoId:
                  YoutubePlayerController.convertUrlToId(exercise.url),
              params: const YoutubePlayerParams(autoPlay: false),
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
                                        'Circuit',
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
                                                    "${entry.key + 1}. ${entry.value.name} (${entry.value.setReps} ${entry.value.repUnits} @ ${entry.value.setWeight})",
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                      fontFamily: 'cabin',
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black,
                                                    )),
                                                Container(
                                                  padding: EdgeInsets.only(top: 5),
                                                  child: YoutubePlayerIFrame(
                                                    controller:
                                                        _controllers[entry.key],
                                                  ),
                                                ),
                                                (entry.value.cues == "")
                                                    ? Padding(
                                                        padding:
                                                            EdgeInsets.all(10))
                                                    : Container(
                                                        width: double.infinity,
                                                        margin:
                                                            EdgeInsets.fromLTRB(
                                                                0, 10, 0, 10),
                                                        padding:
                                                            EdgeInsets.fromLTRB(
                                                                15, 30, 15, 30),
                                                        child: Text(
                                                            '${entry.value.cues}',
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    'cabin',
                                                                fontSize: 15,
                                                                color: Color(
                                                                    0xFF6A8D73)
                                                                //fontWeight: FontWeight.bold,
                                                                )),
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              Color(0xFFCFE8D5),
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
                                  (widget.circuit.film)
                                      ? (_pickedFile == null && filmUrl == "")
                                          ? ButtonTheme(
                                              minWidth: 20,
                                              height: 30,
                                              child: RaisedButton.icon(
                                                color: Color(0xFF6A8D73),
                                                onPressed: () async {
                                                  //Navigator.of(context).pop();
                                                  var navigationResult =
                                                      await Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          Camera(
                                                        title: "Film",
                                                        image: false,
                                                        video: true,
                                                      ),
                                                    ),
                                                  );
                                                  if (navigationResult !=
                                                      null) {
                                                    setState(() {
                                                      _pickedFile =
                                                          navigationResult;
                                                      widget.circuit
                                                              .pickedFile =
                                                          navigationResult;
                                                    });
                                                    widget.setSavable();
                                                  }
                                                  // show the camera
                                                },
                                                icon: Icon(
                                                    Icons.video_call_rounded,
                                                    color: Colors.white),
                                                label: Text('Film Set',
                                                    style: TextStyle(
                                                        color: Colors.white)),
                                              ),
                                            )
                                          : TextButton.icon(
                                              icon: Icon(
                                                Icons.check,
                                                color: Colors.grey,
                                              ),
                                              label: Text(
                                                'Film Set',
                                                style: TextStyle(
                                                    color: Colors.grey),
                                              ),
                                              onPressed: () {},
                                            )
                                      : Padding(padding: EdgeInsets.all(0)),
                                ]),
                            SizedBox(
                              height: 90.0,
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: widget.circuit.sets,
                                  itemBuilder: (ctx, int) {
                                    return SetButton((bool state) {
                                      if (!state) {
                                        widget.circuit.setsComplete--;
                                      } else {
                                        widget.circuit.setsComplete++;
                                      }
                                      widget.setSavable();
                                    }, int + 1 <= widget.circuit.setsComplete,
                                        '${int + 1}');
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
                                    TextFormField(
                                      initialValue: widget.circuit.comments == null ? "" : widget.circuit.comments,
                                      onChanged: (comment) {
                                        widget.circuit.comments = comment;
                                        widget.setSavable();
                                      },),
                                  ]),
                            ),
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  FlatButton(
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
                                  )
                                ]),
                          ])))));
    });
  }
}
