import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:xuan_fitness/repositories/calendar_repository.dart';
import 'package:xuan_fitness/widgets/calendar_card.dart';

class CalendarWidget extends StatefulWidget {
  CalendarWidget({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _CalendarWidgetState createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> with TickerProviderStateMixin {
  Map<DateTime, List> _events;
  List _selectedEvents;
  AnimationController _animationController;
  CalendarController _calendarController;

  @override
  void initState() {
    super.initState();
    final _selectedDay = DateTime.now();
    _events = {
      _selectedDay : [
        'Habits',
      ],
      _selectedDay.add(Duration(days: 5)): [
        'Comment',
        'Habits',
        'Fitness',
        'Nutrition'
      ],
      _selectedDay.add(Duration(days: 10)): [
        'Fitness',
      ],
      _selectedDay.add(Duration(days: 12)): [
        'Habits',
      ],
    };

    _selectedEvents = _events[_selectedDay] ?? [];
    _calendarController = CalendarController();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _calendarController.dispose();
    super.dispose();
  }

  void _onDaySelected(DateTime day, List events, List holidays) {
    print('CALLBACK: _onDaySelected');
    print(day);
    setState(() {
      _selectedEvents = events;
    });
  }

  void _onVisibleDaysChanged(DateTime first, DateTime last, CalendarFormat format) {
    print(first);
    print(last);
    DateTime monthDate = last.subtract(Duration(days:14));
    print("${monthDate.year}-${monthDate.month}");
    print('CALLBACK: _onVisibleDaysChanged');
  }

  void _onCalendarCreated(
      DateTime first, DateTime last, CalendarFormat format) {
    print('CALLBACK: _onCalendarCreated');
  }

  @override
  Widget build(BuildContext context) {
    final calendarRepo = Provider.of<CalendarRepository>(context);
    print(calendarRepo);
    return Container(
      color: Theme.of(context).primaryColorDark,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Container(
            // padding: EdgeInsets.fromLTRB(5, 0, 5, 15),
            child: _buildTableCalendarWithBuilders(_events), // _buildTableCalendar(calendarRepo.calendar)
            color: Theme.of(context).primaryColorDark,
          ),
          // SizedBox(height: 10,),
          Expanded(
              child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    border: Border.all(
                        color:
                            Theme.of(context).primaryColor, // Set border color
                        width: 3.0),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                        child: Text("Today",
                            style: GoogleFonts.cabin(
                              textStyle: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 24),
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                        child: Text("If not now, when?",
                            style: GoogleFonts.cabin(
                              textStyle:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            )),
                      ),
                      Expanded(
                        child: _buildCards()
                      )
                    ],
                  ))),
          // Expanded(child: _buildEventList()),
        ],
      ),
    );
  }

  TextStyle daysOfWeekStyle = GoogleFonts.cabin(
    fontWeight: FontWeight.w700,
    textStyle: TextStyle(color: Colors.white),
  );
  TextStyle daysStyle = GoogleFonts.cabin(
    // fontWeight: FontWeight.w700,
    textStyle: TextStyle(color: Colors.white),
  );
  TextStyle outsideDaysStyle = GoogleFonts.cabin(
    // fontWeight: FontWeight.w700,
    textStyle: TextStyle(color: Color(0x55FFFFFF)),
  );

  // More advanced TableCalendar configuration (using Builders & Styles)
  Widget _buildTableCalendarWithBuilders( Map<DateTime, List> _events) {
    return TableCalendar(
      calendarController: _calendarController,
      events: _events,
      initialCalendarFormat: CalendarFormat.month,
      formatAnimation: FormatAnimation.slide,
      startingDayOfWeek: StartingDayOfWeek.sunday,
      availableGestures: AvailableGestures.all,
      availableCalendarFormats: const {
        CalendarFormat.month: ''
      },
      calendarStyle: CalendarStyle(
          todayColor: Color(0x33CFE8D5),
          selectedColor: Color(0x77CFE8D5),
          outsideDaysVisible: true,
          weekendStyle: daysStyle,
          weekdayStyle: daysStyle,
          eventDayStyle: daysStyle,
          selectedStyle: daysStyle,
          todayStyle: daysStyle,
          outsideStyle: outsideDaysStyle,
          outsideWeekendStyle: outsideDaysStyle),
      daysOfWeekStyle: DaysOfWeekStyle(
        weekdayStyle: daysOfWeekStyle,
        weekendStyle: daysOfWeekStyle,
      ),
      headerStyle: HeaderStyle(
        centerHeaderTitle: true,
        formatButtonVisible: false,
        titleTextStyle: GoogleFonts.cabin(
          textStyle: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w700, fontSize: 24),
        ),
        leftChevronIcon: new Icon(
          Icons.arrow_left_outlined,
          color: Colors.white,
          size: 45,
        ),
        rightChevronIcon: new Icon(
          Icons.arrow_right_outlined,
          color: Colors.white,
          size: 45,
        ),
      ),
      builders: CalendarBuilders(
        markersBuilder: (context, date, events, holidays) {
          final children = <Widget>[];
          if (events.isNotEmpty) {
            children.add(Positioned(
                bottom: 1,
                child: _buildEventsMarker(date, events)
            )

            );
          }
          return children;
        },
      ),
      onDaySelected: (date, events, holidays) {
        _onDaySelected(date, events, holidays);
        _animationController.forward(from: 0.0);
      },
      onVisibleDaysChanged: _onVisibleDaysChanged,
      onCalendarCreated: _onCalendarCreated,
    );
  }
  Widget _buildEventsMarker(DateTime date, List events) {
    List<Widget> icons=[];
    if(events.contains("Comment")){
      icons.add(FaIcon(FontAwesomeIcons.comments,
        color: Colors.white,
        size: 12,
      ));
    }

    if(events.contains("Fitness") && events.contains("Habits") && events.contains("Nutrition")){
      icons.add(FaIcon(FontAwesomeIcons.solidSmile,
            color: Colors.white,
            size: 12,));
    }else if(events.contains("Fitness") || events.contains("Habits") || events.contains("Nutrition")){
      icons.add(FaIcon(FontAwesomeIcons.smile,
        color: Colors.white,
        size: 12,));
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: icons,
    );
  }
  Widget _buildCards(){
    List<Widget> cards=[];
    cards.add(CalendarCard("Fitness", _selectedEvents.contains("Fitness"), FontAwesomeIcons.dumbbell));
    cards.add(CalendarCard("Habits", _selectedEvents.contains("Habits"), FontAwesomeIcons.solidHeart));
    cards.add(CalendarCard("Nutrition", _selectedEvents.contains("Nutrition"), FontAwesomeIcons.utensils));
    return Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: cards);
  }
}
