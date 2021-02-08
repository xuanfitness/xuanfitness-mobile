import 'package:flutter/material.dart';
import 'package:xuan_fitness/widgets/calendar_widget_test.dart';

class TaskBar extends StatefulWidget {
  TaskBar({Key key, this.title}) : super(key: key);

  final String title;
  @override
  _TaskBarState createState() => _TaskBarState();
}

class _TaskBarState extends State<TaskBar> {
  int _selectedIndex;
  List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Fitness',
    ),
    Text(
      'Index 1: Habits',
    ),
    Text(
      'Index 2: Nutrition',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _selectedIndex = -1;
  }

  void _onNavBarItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _renderTabBody(){
    if(_selectedIndex == -1)
      return CalendarWidget(title:"test");
    else
      return _widgetOptions.elementAt(_selectedIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _renderTabBody(),
      appBar: AppBar(
        title: Text(this.widget.title),
        actions: <Widget>[
          // action button
          IconButton(
            icon: Icon(Icons.home),
            onPressed: () {
              setState(() {
                _selectedIndex = -1;
              });
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
        onTap: _onNavBarItemTapped,
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

