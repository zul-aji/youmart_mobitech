import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AdminBody extends StatelessWidget {
  const AdminBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Text(
            "Manage Items",
            style: TextStyle(
              fontSize: 35,
              color: Colors.cyan.shade800,
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        SizedBox(height: 18),
      ],
    );
  }
}
