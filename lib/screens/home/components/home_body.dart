import 'package:flutter/material.dart';

import 'package:youmart_mobitech/screens/home/components/categories_home.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            "Shop Items",
            style: TextStyle(
              fontSize: 35,
              color: Color(0xFF00838F),
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        SizedBox(height: 18),
        Categories(),
      ],
    );
  }
}
