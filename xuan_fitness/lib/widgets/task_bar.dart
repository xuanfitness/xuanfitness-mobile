import 'package:flutter/material.dart';
import 'package:xuan_fitness/pages/loginhome/home_calendar.dart';
import 'package:xuan_fitness/pages/loginhome/notifications.dart';

class TaskBar extends StatefulWidget {
  TaskBar({Key key, this.title, this.child}) : super(key: key);

  final String title;
  final Widget child;
  @override
  _TaskBarState createState() => _TaskBarState();
}

class _TaskBarState extends State<TaskBar> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: this.widget.child,
      appBar: AppBar(
        title: Text(this.widget.title),
        actions: <Widget>[
          // action button
          IconButton(
              icon: Icon(Icons.add_alert),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      //builder: (context) => Notifications(),
                      ),
                );
              }),
          // action button
          IconButton(
            icon: Icon(Icons.home),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HomeCalendar(),
                ),
              );
            },
          ),
          // overflow menu
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        unselectedItemColor: Colors.black,
        selectedItemColor: Colors.orange,
        backgroundColor: Colors.yellow[100],
        // this will be set when a new tab is tapped
        items: [
          //first icon
          BottomNavigationBarItem(
            icon: new Icon(Icons.home),
            title: new Text('Fitness'),
          ),
          //second icon
          BottomNavigationBarItem(
            icon: new Icon(
              Icons.favorite,
              //color: Colors.black,
            ),
            title: new Text('Habits'),
            //third icon
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
                //color: Colors.black,
              ),
              title: Text('Nutrition'))
        ],
        //changes the colour of the selected item - can change later.
      ),
    );
  }
}
