import 'package:flutter/material.dart';

class PhotoWidget extends StatelessWidget {
  final String message;

  PhotoWidget({this.message});

  @override
  Widget build(BuildContext context) {
    return Image(
        image: AssetImage('images/xuan_logo.png'), height: 150, width: 150);
  }
}
