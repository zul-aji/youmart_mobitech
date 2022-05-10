import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:youmart_mobitech/constants.dart';
import 'package:youmart_mobitech/screens/home/components/body/add_item.dart';

import '../../../model/user_model.dart';
import 'categories_home.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({Key? key}) : super(key: key);

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  // string for displaying the error Message
  String? errorMessage;

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

  @override
  Widget build(BuildContext context) {
    final headingTitle = Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: LayoutBuilder(builder: (context, constraints) {
        if (loggedInUser.role == 'Admin') {
          return const Text(
            "Manage Items",
            style: TextStyle(
              fontSize: 35,
              color: colorPrimaryDark,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w700,
            ),
          );
        } else {
          return const Text(
            "Shop Items",
            style: TextStyle(
              fontSize: 35,
              color: colorPrimaryDark,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w700,
            ),
          );
        }
      }),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        headingTitle,
        const SizedBox(height: 18),
        const Categories(),
        adminOrCustomer(),
      ],
    );
  }

  adminOrCustomer() {
    if (loggedInUser.role == 'Admin') {
      return Expanded(
        child: Padding(padding: const EdgeInsets.all(36.0), child: adminBody()),
      );
    } else {
      return Expanded(
        child:
            Padding(padding: const EdgeInsets.all(36.0), child: customerBody()),
      );
    }
  }

  adminBody() {
    return AddItem();
  }

  customerBody() {}
}
