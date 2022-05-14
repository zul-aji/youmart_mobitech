import 'package:flutter/material.dart';

import '../screens/login/login_screen.dart';
import '../screens/login/registration_screen.dart';

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
