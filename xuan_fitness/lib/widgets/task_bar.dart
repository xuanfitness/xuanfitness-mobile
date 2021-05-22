import 'package:flutter/material.dart';
import 'package:xuan_fitness/pages/fitness/workout_list.dart';
import 'package:xuan_fitness/widgets/calendar/calendar_widget.dart';
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
  Color _selectedColor= Colors.amber;
  Color _unSelectedColor = Colors.black;
  List<Widget> _widgetOptions = <Widget>[
    WorkoutList(),
    HabitsHome(),
    NutritionHome(),
  ];
  List<Color> _colorList = <Color>[
    Colors.black,
    Colors.black,
    Colors.black,
    Colors.amber,
  ];
  @override
  void initState() {
    super.initState();
    _selectedIndex = 3;
  }

  void _onNavBarItemTapped(int index) {
    setState(() {
      _colorList[_selectedIndex] = _unSelectedColor;
      _colorList[index] = _selectedColor;
      _selectedIndex = index;
    });
  }

  Widget _renderTabBody() {
    if (_selectedIndex == 3)
      return CalendarWidget(title: "test");
    else
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
            icon: Icon(
                Icons.home,
                color:_colorList[3]
            ),
            onPressed: () {_onNavBarItemTapped(3);},
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
            icon: new Icon(
                Icons.home,
                color: _colorList[0]
            ),
            title: new Text('Fitness', style: TextStyle(color: _colorList[0]))
          ),
          BottomNavigationBarItem(
            icon: new Icon(
              Icons.favorite,
              color: _colorList[1]
            ),
            title: new Text('Habits', style: TextStyle(color: _colorList[1])),
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
                color: _colorList[2]
              ),
              title: Text('Nutrition', style: TextStyle(color: _colorList[2]))
          )
        ],
        onTap: _onNavBarItemTapped,
      ),
    );
  }
}
