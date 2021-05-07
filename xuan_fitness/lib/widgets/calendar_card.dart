import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class CalendarCard extends StatelessWidget{
  CalendarCard(this.title, this.complete, this.icon);
  final String title;
  final bool complete;
  final IconData icon;

  Color backgroundColor;
  Color iconColor;
  @override
  Widget build(BuildContext context) {
    backgroundColor = (complete)?Theme.of(context).primaryColorDark: Theme.of(context).primaryColorLight;
    iconColor = (complete)?Theme.of(context).primaryColorLight: Theme.of(context).primaryColorDark;

    return Container(
      width: 80,
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border.all(
            color: backgroundColor, // Set border color
            width: 3.0),
        borderRadius:
        BorderRadius.all(Radius.circular(10)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FaIcon((complete)?FontAwesomeIcons.check:icon,
              color: iconColor,),
            SizedBox(height: 8),
            Text(title,
                style: GoogleFonts.cabin(
                  textStyle: TextStyle(
                      color: iconColor,
                      fontSize: 14),
                ))
          ],
        ),
      ),
    );
  }

}