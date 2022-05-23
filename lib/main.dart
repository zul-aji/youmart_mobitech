import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

import 'model/user_model.dart';
import 'model/product_model.dart';
import 'pages/auth_page.dart';
import 'screens/home/home_screen.dart';
import 'utils.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MainPage());
  // runApp(MultiProvider(
  //     providers: [
  //         create: (context) => ProductNotifier(),
  //       ),
  //     ],
  //     child: MainPage()
  // ));
}

UserModel loggedInUser = UserModel();

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      scaffoldMessengerKey: Utils.messengerKey,
      navigatorKey: navigatorKey,
      theme: ThemeData(fontFamily: 'Poppins'),
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Something went wrong!'));
          } else if (snapshot.hasData) {
            return const HomeScreen();
          } else {
            return AuthPage();
          }
        },
      ),
    );
  }
}
