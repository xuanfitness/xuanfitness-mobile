import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter/material.dart';
import 'package:timelines/timelines.dart';
//import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class WorkoutDetail extends StatefulWidget {
  WorkoutDetail({Key key}) : super(key: key);

  final String title = "Workouts";

  @override
  _WorkoutDetailState createState() => _WorkoutDetailState();
}

class _WorkoutDetailState extends State<WorkoutDetail> {
  final List<String> entries = <String>['Abs', 'Squats', 'Jumprope'];
  final List<String> subentries = <String>[
    'Exercise (5 min)',
    'Exercise (5 min)',
    'Exercise (15 min)'
  ];
  final List<int> colorCodes = <int>[700, 400, 100];
  @override
  static String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (BuildContext context, BoxConstraints viewportConstraints){
      return Material(
        child: SingleChildScrollView(
            child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: viewportConstraints.maxHeight),
            child: Container(
              padding: EdgeInsets.fromLTRB(5, 25, 5, 0),
              color: Colors.white,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                    ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.all(20),
                        itemCount: entries.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                            elevation: 5,
                            child: Padding(
                              padding: const EdgeInsets.all(100),
                              child: ListTile(
                                title: Text('${entries[index]}'),
                                subtitle: Text('${subentries[index]}'),
                              ),
                            ),
                            color: Colors.green[colorCodes[index]],
                          );
                        },
                      ),
                  ]),
            ),
        )),
      );
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

  Widget cryptoNameSymbol() {
    return Align(
      alignment: Alignment.centerLeft,
      child: RichText(
        text: TextSpan(
          //text: ‘fun’,
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20),
          children: <TextSpan>[
            TextSpan(
                //text: ‘\nBTC’,
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                    fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
