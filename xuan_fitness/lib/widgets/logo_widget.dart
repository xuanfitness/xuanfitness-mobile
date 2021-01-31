import 'package:flutter/material.dart';

class PhotoWidget extends StatelessWidget {
  final String message;

  PhotoWidget({this.message});

  @override
  Widget build(BuildContext context) {
    return Image(
        alignment: Alignment.bottomLeft,
        image: AssetImage('images/xuan_logo.png'),
        height: 300,
        width: 300);
  }
}
