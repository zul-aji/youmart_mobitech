import 'package:flutter/material.dart';

import 'package:youmart_mobitech/screens/home/components/categories_home.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Text(
            "Shop Items",
            style: TextStyle(
              fontSize: 35,
              color: Colors.cyan.shade800,
              fontFamily: 'Montserrat',
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
