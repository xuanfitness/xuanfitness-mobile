import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SetButton extends StatefulWidget {
  Function changeSet;
  bool complete;
  String text;
  SetButton(this.changeSet, this.complete, this.text);
  @override
  State<StatefulWidget> createState() => _SetState(complete);
}

class _SetState extends State<SetButton> {
  bool complete;
  _SetState(this.complete);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: RaisedButton(
        child: Text(widget.text, textAlign: TextAlign.center,),
        onPressed: () {
          widget.changeSet(!this.complete);
          setState(() {
            this.complete = !this.complete;
          });
        },
        textColor: complete ? Color(0xFF6A8D73) : Colors.black,
        color: complete ? Color(0xFFCFE8D5) : Colors.white,
      ),
    );
  }
}
