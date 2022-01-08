import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:xuan_fitness/pages/fitness/timer.dart';
import 'package:xuan_fitness/pages/fitness/workout_list.dart';


class WorkoutHome extends StatefulWidget {
  @override
  _WorkoutState createState() => _WorkoutState();
}

class _WorkoutState extends State<WorkoutHome> {
  Widget _body;
  void setBody(Widget body){
    setState((){
      this._body = body;
    });
  }

  @override
  void initState() {
    super.initState();
    _body = WorkoutList(setBody);
  }

  @override
  Widget build(BuildContext context) {
          return Scaffold(
              backgroundColor: Colors.white,
              body: SlidingUpPanel(
                minHeight: 45,
                collapsed: Center(
                  child: Text(
                    'Timer',
                    style: TextStyle(
                      fontFamily: 'cabin',
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                panel: Center(
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        border: Border.all(
                            color: Theme.of(context).primaryColor, // Set border color
                            width: 3.0),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                      ),
                      child: TimerWidget(),
                    )),
                body: this._body
              )
    );
  }
}


