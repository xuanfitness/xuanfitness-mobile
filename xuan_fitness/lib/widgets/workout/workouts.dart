import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Workouts extends StatefulWidget {
  @override
  WorkoutsState createState() => new WorkoutsState();
}

class WorkoutsState extends State<Workouts> {
  @override
  Widget build(BuildContext context) {
    return Column(
        // child: Container(
        //   margin: const EdgeInsets.all(1),
        //   color: Colors.amber[600],
        //   width: 1000,
        //   height: 200.0,
        //   child: Text('Video should be here'),
        // ),
        children: [
          Text('Squats',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontFamily: 'cabin',
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              )),
          Container(
            child: YoutubePlayerBuilder(
                player: YoutubePlayer(
                    // controller: _controller,
                    ),
                builder: (context, player) {
                  return player;
                }),
          ),
        ]);
  }
}
