import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:youmart_mobitech/screens/home_screen.dart';
import 'package:youmart_mobitech/screens/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';

Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MainPage());
}
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         title: 'Email and Password Login',
//         theme: ThemeData(
//           primarySwatch: Colors.blue,
//         ),
//         home: LoginScreen());
//   }
// }

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return HomePage();
          } else {
            return LoginScreen();
          }
        },
      ),
    );
  }
}