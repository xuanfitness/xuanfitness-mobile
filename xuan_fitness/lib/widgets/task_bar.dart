import 'package:flutter/material.dart';
import 'package:xuan_fitness/pages/fitness/workout_list.dart';
import 'package:xuan_fitness/widgets/calendar_widget_test.dart';
import 'package:xuan_fitness/pages/nutrition/nutrition_home.dart';
import 'package:xuan_fitness/pages/habits/habit_home.dart';

class TaskBar extends StatefulWidget {
  TaskBar({Key key, this.title}) : super(key: key);

  final String title;
  @override
  _TaskBarState createState() => _TaskBarState();
}

class _TaskBarState extends State<TaskBar> {
  int _selectedIndex;
  List<Widget> _widgetOptions = <Widget>[
    WorkoutList(),
    HabitsHome(),
    NutritionHome(),
  ];

  @override
  void initState() {
    super.initState();
    _selectedIndex = 0;
  }

  void _onNavBarItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _renderTabBody() {
    /*if (_selectedIndex == -1)
      return CalendarWidget(title: "test");
    else*/
    return _widgetOptions.elementAt(_selectedIndex);
  }

  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _renderTabBody(),
      appBar: AppBar(
        title: Text(this.widget.title),
        backgroundColor: Colors.white,
        actions: <Widget>[
          // action button
          IconButton(
            icon: Icon(Icons.home),
            onPressed: () {
              setState(() {
                //_selectedIndex = -1;
              });
            },
          ),
          // overflow menu
        ],
      ),
      //https://stackoverflow.com/questions/45235570/how-to-use-bottomnavigationbar-with-navigator
      bottomNavigationBar: BottomNavigationBar(
        /*onTap: (int index) {
          setState(() {
            this.index = index;
          });
        },*/
        backgroundColor: Colors.white,
        // this will be set when a new tab is tapped
        items: <BottomNavigationBarItem>[
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
        unselectedItemColor: Colors.black,
        selectedItemColor: Colors.orange,
        onTap: _onNavBarItemTapped,
        currentIndex: _selectedIndex,
        //changes the colour of the selected item - can change later.
      ),
    );
  }
}
