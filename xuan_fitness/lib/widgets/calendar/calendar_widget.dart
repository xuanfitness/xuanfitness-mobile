import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:xuan_fitness/repositories/calendar_repository.dart';
import 'package:xuan_fitness/widgets/calendar/calendar_card.dart';

class CalendarWidget extends StatefulWidget {
  CalendarWidget({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _CalendarWidgetState createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget>
    with TickerProviderStateMixin {
  List _selectedEvents;
  AnimationController _animationController;
  CalendarController _calendarController;

  @override
  void initState() {
    super.initState();

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
    setState(() {
      _selectedEvents = events;
    });
  }

  void _onCalendarCreated(
      DateTime first, DateTime last, CalendarFormat format) {
    print('CALLBACK: _onCalendarCreated');
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
        builder: (context, CalendarRepository calendarRepository, _) {
      final calendarRepo = Provider.of<CalendarRepository>(context);
      if (_selectedEvents == null && calendarRepo.calendar != null) {
        DateTime now = DateTime.now();
        DateTime nowParsed = DateTime(now.year, now.month, now.day);
        _selectedEvents = calendarRepo.calendar[nowParsed] ?? [];
      }

      return Container(
        color: Theme.of(context).primaryColorDark,
        child: SlidingUpPanel(
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
                      Expanded(child: _buildCards())
                    ])),
          ),
          maxHeight: 300,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          collapsed: Container(
              width: double.infinity,
              padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                border: Border.all(
                    color: Theme.of(context).primaryColor, // Set border color
                    width: 3.0),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
              ),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Today",
                        style: GoogleFonts.cabin(
                          textStyle: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 24),
                        )),
                    Text("If not now, when?",
                        style: GoogleFonts.cabin(
                          textStyle:
                              TextStyle(color: Colors.white, fontSize: 16),
                        )),
                  ])),
          body: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(
                  child: _buildTableCalendarWithBuilders(calendarRepo),
                  // _buildTableCalendar(calendarRepo.calendar)
                  color: Theme.of(context).primaryColorDark,
                ),
              ),

            ],
          ),
        ),
      );
    });
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
  Widget _buildTableCalendarWithBuilders(
      CalendarRepository calendarRepository) {
    return TableCalendar(
      calendarController: _calendarController,
      events: calendarRepository.calendar,
      initialCalendarFormat: CalendarFormat.month,
      formatAnimation: FormatAnimation.slide,
      startingDayOfWeek: StartingDayOfWeek.sunday,
      availableGestures: AvailableGestures.all,
      availableCalendarFormats: const {CalendarFormat.month: ''},
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
            children.add(
                Positioned(bottom: 1, child: _buildEventsMarker(date, events)));
          }
          return children;
        },
      ),
      onDaySelected: (date, events, holidays) {
        _onDaySelected(date, events, holidays);
        _animationController.forward(from: 0.0);
      },
      onVisibleDaysChanged: (first, last, format) {
        DateTime monthDate = last.subtract(Duration(days: 14));
        calendarRepository.addMonth(monthDate);
        print('CALLBACK: _onVisibleDaysChanged');
      },
      onCalendarCreated: _onCalendarCreated,
    );
  }

  Widget _buildEventsMarker(DateTime date, List events) {
    List<Widget> icons = [];
    if (events.contains("Comment")) {
      icons.add(FaIcon(
        FontAwesomeIcons.comments,
        color: Colors.white,
        size: 12,
      ));
    }

    if (events.contains("Fitness") &&
        events.contains("Habits") &&
        events.contains("Nutrition")) {
      icons.add(FaIcon(
        FontAwesomeIcons.solidSmile,
        color: Colors.white,
        size: 12,
      ));
    } else if (events.contains("Fitness") ||
        events.contains("Habits") ||
        events.contains("Nutrition")) {
      icons.add(FaIcon(
        FontAwesomeIcons.smile,
        color: Colors.white,
        size: 12,
      ));
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: icons,
    );
  }

  Widget _buildCards() {
    if (_selectedEvents == null) return Container();

    List<Widget> cards = [];
    cards.add(CalendarCard("Fitness", _selectedEvents.contains("Fitness"),
        FontAwesomeIcons.dumbbell));
    cards.add(CalendarCard("Habits", _selectedEvents.contains("Habits"),
        FontAwesomeIcons.solidHeart));
    cards.add(CalendarCard("Nutrition", _selectedEvents.contains("Nutrition"),
        FontAwesomeIcons.utensils));
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround, children: cards);
  }
}
