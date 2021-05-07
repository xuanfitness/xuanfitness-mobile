import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:xuan_fitness/repositories/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:xuan_fitness/widgets/logo_widget.dart';


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}
class _LoginPageState extends State<LoginPage>{
  TextEditingController _email;
  TextEditingController _password;
  final _formKey = GlobalKey<FormState>();
  final _key = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _email = TextEditingController(text: "");
    _password = TextEditingController(text: "");
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserRepository>(context);
    return Scaffold(
        key: _key,
        body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(40, 150, 40, 0),
          child: Form(
            key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                      Container(
                        alignment: Alignment.bottomLeft,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0,0,0,5),
                              child: Image(
                                image: AssetImage('images/xuan_logo.png'),
                                width: 200,
                              ),
                            ),
                            Text(
                              "FITNESS",
                              style: GoogleFonts.cabin(
                                textStyle: TextStyle(color: Theme.of(context).primaryColor),
                                fontWeight: FontWeight.bold,
                                fontSize: 30
                              ),
                              textAlign: TextAlign.left,
                            )
                          ],
                        )
                    ),
                    Container(
                        padding: EdgeInsets.fromLTRB(5, 10, 0, 0),
                        child: TextFormField(
                          controller: _email,
                          validator: (value) => (value.isEmpty) ? "Please Enter Email" : null,
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.lightGreen[900]),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.lightGreen[900]),
                            ),
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.lightGreen[900]),
                            ),
                            hintText: 'Email',
                            hintStyle: TextStyle(color: Colors.lightGreen[900]),
                          ),
                        )
                    ),
                    Container(
                        padding: EdgeInsets.fromLTRB(5, 10, 0, 20),
                        child: TextFormField(
                          obscureText: true,
                          controller: _password,
                          validator: (value) => (value.isEmpty) ? "Please Enter Password" : null,
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.lightGreen[900]),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.lightGreen[900]),
                            ),
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.lightGreen[900]),
                            ),
                            hintText: 'Password',
                            hintStyle: TextStyle(color: Colors.lightGreen[900]),
                          ),
                        )
                    ),
                    user.status == Status.Authenticating
                      ?Container(
                        padding: EdgeInsets.all(20),
                        child: CircularProgressIndicator()
                        )
                      :Column(
                        children: <Widget>[
                          Container(
                              height: 50,
                              width: 500,
                              child: ElevatedButton(
                                child: Text('Log In'),
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.white,
                                    onPrimary: Colors.lightGreen[900],
                                    side: BorderSide(color: Colors.lightGreen[900])),
                                onPressed: () async {
                                  if(_formKey.currentState.validate()){
                                    if(!await user.signIn(_email.text, _password.text)){
                                      _key.currentState.showSnackBar(SnackBar(content: Text("Something went wrong.")));
                                    }
                                  }
                                },
                              )
                          ),
                          FlatButton(
                            onPressed: () async{
                              //forgot password screen
                              if(_email.text.isNotEmpty){
                                if(!await user.resetPassword(_email.text)){
                                  _key.currentState.showSnackBar(SnackBar(content: Text("Something went wrong resetting your password.")));
                                }else{
                                  _key.currentState.showSnackBar(SnackBar(content: Text("Password reset sent to your email.")));
                                }
                              }
                            },
                            textColor: Colors.brown[200],
                            child: Text('Reset Password',),
                          ),
                        ],)
                  ],
                )),
        ),
        );
  }
}