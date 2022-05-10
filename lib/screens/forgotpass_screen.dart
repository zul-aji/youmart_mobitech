import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../utils.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: 'Poppins'),
        home: Scaffold(
          backgroundColor: const Color(0xFFF6E8EA),
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Text(
              'Reset Password',
              style: TextStyle(
                fontSize: 24,
                color: Colors.cyan.shade800,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
              ),
            ),
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.cyan.shade800),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Receive an email to\nreset your password.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.grey.shade600,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: emailController,
                    cursorColor: Colors.white,
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 3, color: Colors.cyan.shade800),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 3, color: Colors.cyan.shade800),
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (email) =>
                        email != null && !EmailValidator.validate(email)
                            ? 'Enter a valid email'
                            : null,
                  ),
                  const SizedBox(height: 20),
                  Material(
                    elevation: 5,
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.cyan.shade800,
                    child: MaterialButton(
                      padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                      minWidth: MediaQuery.of(context).size.width,
                      onPressed: verifyEmail,
                      child: Text(
                        "Reset Password",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.cyan.shade50,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );

  Future verifyEmail() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text.trim());

      Utils.showSnackBar('Password Reset Email Sent');
      Navigator.of(context).popUntil((route) => route.isFirst);
    } on FirebaseAuthException catch (e) {
      print(e);

      Utils.showSnackBar(e.message);
      Navigator.of(context).pop();
    }
  }
}
