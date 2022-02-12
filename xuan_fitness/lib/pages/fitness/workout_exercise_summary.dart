import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter/material.dart';
import 'package:xuan_fitness/models/fitness/exercise.dart';
import 'package:xuan_fitness/pages/fitness/set.dart';
import 'package:xuan_fitness/pages/fitness/workout_list.dart';
import 'package:xuan_fitness/widgets/camera.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class WorkoutDetailSummary extends StatefulWidget {
  final Exercise exercise;
  WorkoutDetailSummary(this.exercise);

  @override
  _WorkoutDetailState createState() => _WorkoutDetailState();
}

class _WorkoutDetailState extends State<WorkoutDetailSummary> {
  String formattedDate =
      DateFormat('EEEE, MMMM dd yyyy').format(DateTime.now());
  YoutubePlayerController _controller;

  void initState() {
    super.initState();

    _controller = YoutubePlayerController(
      initialVideoId:
          YoutubePlayerController.convertUrlToId(widget.exercise.url),
      params: const YoutubePlayerParams(autoPlay: false),
    );
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
                                  ]),
                            ),
                            Center(
                              child: Container(
                                child: YoutubePlayerIFrame(
                                  controller: _controller,
                                ),
                              ),
                            ),
                            (widget.exercise.cues == "")
                                ? Padding(padding: EdgeInsets.all(10))
                                : Center(
                                    child: Container(
                                      width: double.infinity,
                                      margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                                      padding:
                                          EdgeInsets.fromLTRB(15, 30, 15, 30),
                                      child: Text('${widget.exercise.cues}',
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
                                  (widget.exercise.film)
                                      ? (widget.exercise.filmURL == "")
                                          ? ButtonTheme(
                                              minWidth: 20,
                                              height: 30,
                                              child: RaisedButton.icon(
                                                color: Color(0xFF6A8D73),
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
                                  itemCount: widget.exercise.setCount,
                                  itemBuilder: (ctx, int) {
                                    return SetButton(
                                        null,
                                        int + 1 <= widget.exercise.setComplete,
                                        '${widget.exercise.setReps} ${widget.exercise.repUnits} @ ${widget.exercise.setWeight}');
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
                                    TextFormField(
                                      readOnly: true,
                                      initialValue: widget.exercise.comments == null ? "" : widget.exercise.comments,
                                    ),
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
                                      Navigator.pop(context);
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
