//im using this page to test the array thing

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:xuan_fitness/repositories/workout_repository.dart';

class WorkoutList extends StatelessWidget {
  static String formattedDate =
      DateFormat('EEEE, MMMM dd yyyy').format(DateTime.now());
  Function setBody;
  WorkoutList(this.setBody);

  Widget build(BuildContext context) {
    return Consumer(builder: (context, WorkoutRepository workoutRepository, _) {
      final fitnessRepo = Provider.of<WorkoutRepository>(context);
      return SingleChildScrollView(
          physics: ScrollPhysics(),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.all(10.0),
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
                            'Workouts',
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

                //the listview of the workouts
                Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.white,
                      Colors.grey[300],
                    ],
                  )),
                  child: ListView.builder(
                    padding: EdgeInsets.fromLTRB(10, 0, 8, 375),
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: fitnessRepo.sections.length + 1, // your List
                    itemBuilder: (context, index) {
                      if (index == fitnessRepo.sections.length) {
                        return FractionallySizedBox(
                            widthFactor: 1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                ElevatedButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                        MaterialStateProperty.all(
                                            Color(0xFF6A8D73))),
                                    onPressed: (workoutRepository.savable)
                                        ? () {
                                            print("save");
                                            workoutRepository.saveWorkout();
                                          }
                                        : null,
                                    child: const Text("Save")),
                                OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                    primary: Color(0xFF6A8D73),
                                  ),
                                  onPressed: (workoutRepository.completed)
                                      ? null
                                      : () {
                                          print("Mark Complete");
                                          workoutRepository.markComplete();
                                        },
                                  child: const Text('Mark Complete'),
                                ),
                              ],
                            ));
                      } else {
                        return fitnessRepo.sections[index]
                            .build(this.setBody, workoutRepository.makeSavable);
                      }
                    },
                  ),
                ),
              ]));
    });
  }
}
