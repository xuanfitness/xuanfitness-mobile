import 'package:flutter/material.dart';
import 'package:xuan_fitness/widgets/logo_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xuan_fitness/pages/loginhome/home_calendar.dart';

void main() {
  runApp(MaterialApp(
    title: "XUAN FITNESS",
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

  /*String _email = "";
  String _password = "";

  _State() {
    //nameController.addListener();
    //passwordController.addListener();

    void _emailListen() {
      if (nameController.text.isEmpty) {
        _email = "";
      } else {
        _email = nameController.text;
      }
    }

    void _passwordListen() {
      if (passwordController.text.isEmpty) {
        _password = "";
      } else {
        _password = passwordController.text;
      }
    }*/

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
                /*Container(
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                  child: TextField(),
                ),*/
                Container(
                    padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                    decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              width: 1.0,
                              //height: 1.0,
                              color: Colors.lightGreen[900])),
                    ),
                    child: TextField(
                      obscureText: true,
                      controller: passwordController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Username',
                        hintStyle: TextStyle(color: Colors.lightGreen[900]),
                      ),
                    )),
                Container(
                    padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                    decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(color: Colors.lightGreen[900])),
                    ),
                    child: TextField(
                      obscureText: true,
                      controller: passwordController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Password',
                        hintStyle: TextStyle(color: Colors.lightGreen[900]),
                      ),
                    )),
                FlatButton(
                  onPressed: () {
                    //forgot password screen
                  },
                  textColor: Colors.brown[200],
                  child: Text(''),
                ),
                Container(
                    height: 50,
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: ElevatedButton(
                      child: Text('Login'),
                      style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          onPrimary: Colors.lightGreen[900],
                          side: BorderSide(color: Colors.lightGreen[900])),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomeCalendar(),
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
