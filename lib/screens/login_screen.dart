import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:youmart_mobitech/constants.dart';

import '../main.dart';
import '../model/user_model.dart';
import '../utils.dart';
import 'forgotpass_screen.dart';

class LoginScreen extends StatefulWidget {
  final VoidCallback onClickedSignUp;

  const LoginScreen({
    Key? key,
    required this.onClickedSignUp,
  }) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // form key
  final _formKey = GlobalKey<FormState>();

  // editting controller
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

  // string for displaying the error Message
  String? errorMessage;

  @override
  Widget build(BuildContext context) {
    //email field
    final emailField = TextFormField(
      autofocus: false,
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Please Enter Your Email");
        }
        // reg expression for email validation
        if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)) {
          return ("Please Enter a valid email");
        }
        return null;
      },
      onSaved: (value) {
        emailController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          hintText: "Email",
          prefixIcon: const Icon(Icons.mail),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          border: OutlineInputBorder(
            borderSide: const BorderSide(width: 3, color: colorPrimaryDark),
            borderRadius: BorderRadius.circular(15),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 3, color: colorPrimaryDark),
            borderRadius: BorderRadius.circular(15),
          )),
    );

    //password field
    final passwordField = TextFormField(
      autofocus: false,
      controller: passwordController,
      obscureText: true,
      validator: (value) {
        RegExp regex = new RegExp(r'^.{6,}$');
        if (value!.isEmpty) {
          return ("Password is required for login");
        }
        if (!regex.hasMatch(value)) {
          return ("Enter Valid Password(Min. 6 Character)");
        }
      },
      onSaved: (value) {
        passwordController.text = value!;
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        hintText: "Password",
        prefixIcon: const Icon(Icons.lock),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        border: OutlineInputBorder(
          borderSide: const BorderSide(width: 3, color: colorPrimaryDark),
          borderRadius: BorderRadius.circular(15),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 3, color: colorPrimaryDark),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );

    //login button
    final loginButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: colorPrimaryDark,
      child: MaterialButton(
        padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: signIn,
        child: const Text(
          "Login",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            color: colorBase,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );

    //guest login button
    final guestLoginButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: colorBase,
      child: MaterialButton(
        padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: guestSignIn,
        child: const Text(
          "Login as Guest",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            color: colorPrimaryDark,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Poppins'),
      home: Scaffold(
        backgroundColor: const Color(0xFFFFFFFF),
        body: Center(
            child: SingleChildScrollView(
          child: Container(
              color: const Color(0xFFFFFFFF),
              child: Padding(
                padding: const EdgeInsets.all(36.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      const SizedBox(height: 20),
                      SizedBox(
                          height: 110,
                          child: Image.asset(
                            "images/Logo.png",
                            fit: BoxFit.contain,
                          )),
                      const SizedBox(height: 30),
                      emailField,
                      const SizedBox(height: 20),
                      passwordField,
                      const SizedBox(height: 30),
                      loginButton,
                      const SizedBox(height: 15),
                      guestLoginButton,
                      const SizedBox(height: 25),
                      GestureDetector(
                        child: const Text(
                          'Forgot Password?',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: colorAccent,
                            fontSize: 20,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        onTap: () =>
                            Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const ForgotPasswordPage(),
                        )),
                      ),
                      RichText(
                        text: TextSpan(
                          style: const TextStyle(
                            color: colorPrimary,
                            fontSize: 20,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                          ),
                          text: 'No account yet?  ',
                          children: [
                            TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = widget.onClickedSignUp,
                              text: 'Sign Up',
                              style: const TextStyle(
                                decoration: TextDecoration.underline,
                                color: colorAccent,
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )),
        )),
      ),
    );
  }

  Future signIn() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text.trim(),
          )
          .then((uid) => {Fluttertoast.showToast(msg: "Login Successful")});
    } on FirebaseAuthException catch (error) {
      switch (error.code) {
        case "invalid-email":
          errorMessage = "Wrong email format";
          break;
        case "wrong-password":
          errorMessage = "Password is wrong.";
          break;
        case "user-not-found":
          errorMessage = "User with this email doesn't exist.";
          break;
        case "user-disabled":
          errorMessage = "User with this email has been disabled.";
          break;
        case "too-many-requests":
          errorMessage = "Too many requests";
          break;
        case "operation-not-allowed":
          errorMessage = "Signing in with Email and Password is not enabled.";
          break;
        default:
          errorMessage = "An undefined Error happened.";
      }
      Utils.showSnackBar(errorMessage);
      print(error.code);
    }

    // Navigator.of(context) not working!
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }

  int randomEmail = Random().nextInt(10000);
  int randomPass = Random().nextInt(10000);

  postDetailsToFirestore() async {
    // calling our firestore
    // calling our user model
    // sedning these values

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = FirebaseAuth.instance.currentUser;

    UserModel userModel = UserModel();

    // writing all the values
    userModel.email = 'guest$randomEmail@youmail.com';
    userModel.uid = user?.uid;
    userModel.firstName = 'Guest';
    userModel.secondName = 'Account$randomEmail';
    userModel.role = 'Guest';

    await firebaseFirestore
        .collection("users")
        .doc(user?.uid)
        .set(userModel.toMap());
  }

  Future guestSignIn() async {
    try {
      await FirebaseAuth.instance
          .signInAnonymously()
          .then((value) => {postDetailsToFirestore()});
    } on FirebaseAuthException catch (error) {
      Utils.showSnackBar(errorMessage);
      print(error.code);

      navigatorKey.currentState!.popUntil((route) => route.isFirst);
    }
  }
}
