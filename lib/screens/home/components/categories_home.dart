import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:youmart_mobitech/constants.dart';

import '../../../model/user_model.dart';

class Categories extends StatefulWidget {
  const Categories({Key? key}) : super(key: key);

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
  }

  // By default our first item will be selected
  int selectedIndex = 0;
  int categoryLength = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0),
      child: SizedBox(
        height: 30,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: categoryCount(),
          itemBuilder: (context, index) => buildCategory(index),
        ),
      ),
    );
  }

  Widget buildCategory(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            categoryShown(index),
            Container(
              margin: const EdgeInsets.only(top: 5), //top padding 5
              height: 3,
              width: 40,
              color: selectedIndex == index ? colorAccent : Colors.transparent,
            )
          ],
        ),
      ),
    );
  }

  categoryShown(index) {
    if (loggedInUser.role == 'Admin') {
      return Text(
        adminCategories[index],
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: selectedIndex == index ? colorPrimaryDark : colorUnpicked,
        ),
      );
    } else {
      return Text(
        customerCategories[index],
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: selectedIndex == index ? colorPrimaryDark : colorUnpicked,
        ),
      );
    }
  }

  categoryCount() {
    if (loggedInUser.role == 'Admin') {
      return categoryLength = adminCategories.length;
    } else {
      return categoryLength = customerCategories.length;
    }
  }
}
