import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xuan_fitness/pages/auth/login.dart';
import 'package:xuan_fitness/pages/splash.dart';
import 'package:xuan_fitness/repositories/user_repository.dart';
import 'package:xuan_fitness/navigation/task_bar.dart';

void main(){
  WidgetsFlutterBinding.ensureInitialized();
  runApp(App());
}

class App extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
          theme: ThemeData(
            primaryColor: Color(0xFF6A8D73),
            primaryColorDark: Color(0xFF475E4D),
            accentColor: Color(0xffCFE8D5),
            primaryColorLight: Colors.white
          ),
          home: FutureBuilder(
            future: _initialization,
            builder: (context, snapshot){
              if (snapshot.hasError) {
                print(snapshot.error);
                return null;
              }
              if (snapshot.connectionState == ConnectionState.done) {
                return HomePage();
              }
              return Splash();
            },
          )
    );
  }
}
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => UserRepository.instance(),
        child: Consumer(
          builder: (context, UserRepository user, _){
            switch(user.status){
              case Status.Uninitialized:
                return Splash();
              case Status.Unauthenticated:
              case Status.Authenticating:
                return LoginPage();
              case Status.Authenticated:
                return TaskBar();
              default:
                return null;
            }
          },
        ),
    );
  }
}

// class Splash extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       child: Center(
//         child: Text("Splash Screen"),
//       ),
//     );
//   }
// }
