import 'package:youmart_mobitech/screens/home_screen.dart';
import 'package:youmart_mobitech/screens/login_screen.dart';
import 'package:youmart_mobitech/screens/registration_screen.dart';
import 'package:youmart_mobitech/main.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isLogin = true;

  @override
  Widget build(BuildContext context) => isLogin
      ? LoginScreen(onClickedSignUp: toggle)
      : RegistrationScreen(onClickedSignIn: toggle);

  void toggle() => setState(() => isLogin = !isLogin);
}