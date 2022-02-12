import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:xuan_fitness/models/day.dart';
import 'package:xuan_fitness/models/fitness/workout.dart';
import 'package:xuan_fitness/pages/fitness/workout_home.dart';
import 'package:xuan_fitness/pages/fitness/workout_list.dart';
import 'package:xuan_fitness/pages/splash.dart';
import 'package:xuan_fitness/repositories/calendar_repository.dart';
import 'package:xuan_fitness/repositories/habits_repository.dart';
import 'package:xuan_fitness/repositories/nutrition_repository.dart';
import 'package:xuan_fitness/repositories/user_repository.dart';
import 'package:xuan_fitness/repositories/workout_repository.dart';
import 'package:xuan_fitness/widgets/calendar/calendar_widget.dart';
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
  int _selectedIndex;

  DateTime _date;
  String _dateString;

  Day _dayData;
  Future<void> _dayFuture;

  @override
  void initState() {
    super.initState();

    //initialize widget state
    _widgetOptions = [WorkoutHome(), HabitsHome(), NutritionHome()];
    _colorList = [
      _unSelectedColor,
      _unSelectedColor,
      _unSelectedColor,
      _selectedColor
    ];
    _selectedIndex = 3;

    //init date
    _date = DateTime.now();
    _dateString = '${_date.year}-${_date.month}-${_date.day}';
    _dayData = Day(_date);
    // initData = _dayData.initData();
    reload = false;
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
  bool reload;
  void refreshData(){
    Navigator.popAndPushNamed(context, '/');
    // setState(() {
    //   reload = true;
    // });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserRepository>(context);
    // print("_dayFuture before");
    // print(_dayFuture);
    // _dayFuture = _dayData.initData(user.user);
    // print("_dayFuture");
    // print(_dayFuture);
    _dayFuture = (reload)? _dayData.refreshData(user.user): _dayData.initData(user.user);
    reload = false;
    return FutureBuilder(
      future: _dayFuture,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot){
        print("BUILD TASK BAR");
        if(_dayData.data == null){
          return Splash();
        } else{
          return MultiProvider(
              providers: [
                ChangeNotifierProvider(
                  create: (_) => CalendarRepository.instance(user.user,refreshData),
                ),
                ChangeNotifierProxyProvider <CalendarRepository, WorkoutRepository>(
                  create: (context) => WorkoutRepository.instance(user.user, _date,  _dayData.data['fitness']),
                  update: (_, calendarRepo, workoutRepo) => workoutRepo.update(calendarRepo.addEvent, calendarRepo.getDay(_date)),
                ),
                ChangeNotifierProxyProvider<CalendarRepository, HabitRepository>(
                  create: (_) => HabitRepository.instance(user.user, _date,  _dayData.data['habits']),
                  update: (_, calendarRepo, habitRepo) => habitRepo.update(calendarRepo.addEvent, calendarRepo.getDay(_date)),
                ),
                ChangeNotifierProxyProvider<CalendarRepository, NutritionRepository>(
                  create: (_) => NutritionRepository.instance(user.user, _date,  _dayData.data['nutrition']),
                  update: (_, calendarRepo, nutritionRepo) => nutritionRepo.update(calendarRepo.addEvent, calendarRepo.getDay(_date)),
                ),
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
                      padding: EdgeInsets.all(0.0),
                      child: Image(
                          alignment: Alignment.bottomLeft,
                          image: AssetImage((_selectedIndex == 3)
                              ? 'images/xuan_logo_white.png'
                              : 'images/xuan_logo.png'),
                          height: 30,
                          width: 30)),
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
                        title: new Text('Fitness',
                            style: TextStyle(color: _colorList[0]))),
                    BottomNavigationBarItem(
                      icon: new Icon(Icons.favorite, color: _colorList[1]),
                      title:
                      new Text('Habits', style: TextStyle(color: _colorList[1])),
                    ),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.local_dining, color: _colorList[2]),
                        title:
                        Text('Nutrition', style: TextStyle(color: _colorList[2])))
                  ],
                  onTap: _onNavBarItemTapped,
                ),
              ));
        }
      }
    );
  }
}
