import 'package:flutter/material.dart';
import 'package:xuan_fitness/widgets/logo_widget.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MaterialApp(
    home: LoginPage(),
  ));
}

const users = const {'emilybunny100': '12345'};

class LoginPage extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<LoginPage> {
  Duration get loginTime => Duration(milliseconds: 2250);

  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: EdgeInsets.all(20),
            child: ListView(
              children: <Widget>[
                Container(
                  alignment: Alignment.bottomLeft,
                  child: PhotoWidget(),
                  //constraints: BoxConstraints.tightForFinite(width: 20),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Username',
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextField(
                    obscureText: true,
                    controller: passwordController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                    ),
                    style: TextStyle(color: Colors.green[800]),
                  ),
                ),
                Container(
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: OutlineButton(
                      textColor: Colors.green[800],
                      color: Colors.green[800],
                      child: Text('Login'),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              //builder: (context) => Tabs(),
                              ),
                        );
                        print(nameController.text);
                        print(passwordController.text);
                      },
                    )),
              ],
            )));
  }
}
