import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:xuan_fitness/pages/fitness/workout_list.dart';
import 'package:xuan_fitness/repositories/calendar_repository.dart';
import 'package:xuan_fitness/repositories/user_repository.dart';
import 'package:xuan_fitness/widgets/calendar_widget_test.dart';
import 'package:xuan_fitness/pages/nutrition/nutrition_home.dart';
import 'package:xuan_fitness/pages/habits/habit_home.dart';

class TaskBar extends StatefulWidget {
  TaskBar({Key key}) : super(key: key);

  @override
  _TaskBarState createState() => _TaskBarState();
}

class _TaskBarState extends State<TaskBar> {
  Color _selectedColor = Color(0xFF475D4D);
  Color _unSelectedColor = Colors.blueGrey.shade100;

  List<Widget> _widgetOptions;
  List<Color> _colorList;
  List<String> _titleList;
  int _selectedIndex;

  @override
  void initState() {
    super.initState();

    _widgetOptions = [WorkoutList(), HabitsHome(), NutritionHome()];
    _titleList = ["Workouts", "Habits", "Nutrition", "Home"];
    _colorList = [
      _unSelectedColor,
      _unSelectedColor,
      _unSelectedColor,
      _selectedColor
    ];
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
      return CalendarWidget();
    else
      return _widgetOptions.elementAt(_selectedIndex);
  }

  int index = 0;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserRepository>(context);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=>CalendarRepository.instance(user.user),)
      ],
      child: Scaffold(
              body: _renderTabBody(),
              appBar: AppBar(
                elevation: 0,
                backgroundColor: (_selectedIndex == 3)
                    ? Theme
                    .of(context)
                    .primaryColorDark
                    : Theme
                    .of(context)
                    .primaryColorLight,
                title: Padding(
                  padding: EdgeInsets.only(left: 16.0),
                  child: Text(_titleList[_selectedIndex]),
                ),
                textTheme: TextTheme(
                    headline6: GoogleFonts.cabin(
                      textStyle: TextStyle(
                          color: (_selectedIndex == 3)
                              ? Theme
                              .of(context)
                              .primaryColorLight
                              : Theme
                              .of(context)
                              .primaryColor,
                          fontWeight: FontWeight.w700,
                          fontSize: 24),
                    )),
                actions: <Widget>[
                  // action button
                  IconButton(
                    icon: Icon(Icons.home, color: _colorList[3]),
                    onPressed: () {
                      _onNavBarItemTapped(3);
                    },
                  ),
                  // overflow menu
                ],
              ),
              //https://stackoverflow.com/questions/45235570/how-to-use-bottomnavigationbar-with-navigator
              bottomNavigationBar: BottomNavigationBar(
                backgroundColor: Colors.white,
                // this will be set when a new tab is tapped
                items: <BottomNavigationBarItem>[
                  //first icon
                  BottomNavigationBarItem(
                      icon: FaIcon(
                          FontAwesomeIcons.dumbbell, color: _colorList[0]),
                      title:
                      new Text(
                          'Fitness', style: TextStyle(color: _colorList[0]))),
                  BottomNavigationBarItem(
                    icon: new Icon(Icons.favorite, color: _colorList[1]),
                    title: new Text(
                        'Habits', style: TextStyle(color: _colorList[1])),
                  ),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.local_dining, color: _colorList[2]),
                      title: Text(
                          'Nutrition', style: TextStyle(color: _colorList[2])))
                ],
                onTap: _onNavBarItemTapped,
              ),
            )
      );
  }
}
