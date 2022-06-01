import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../model/user_model.dart';
import '../../../constants.dart';
import 'admin/add_item.dart';
import 'admin/delete_item.dart';
import 'admin/orders.dart';
import 'admin/update_item.dart';
import 'customer/itemlist.dart';

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

  // By default our first item will be selected
  int selectedIndex = 0;
  int categoryLength = 0;

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
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 0),
          child: SizedBox(
            height: 30,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categoryCount(),
              itemBuilder: (context, index) => buildCategory(index),
            ),
          ),
        ),
        adminOrCustomer(selectedIndex),
      ],
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

  Widget adminOrCustomer(int index) {
    if (loggedInUser.role == 'Admin') {
      return Expanded(
        child: Padding(padding: const EdgeInsets.all(36.0), child: adminBody()),
      );
    } else {
      return Expanded(
        child: Padding(
            padding: const EdgeInsets.only(left: 24.0, right: 10.0, top: 20),
            child: customerBody()),
      );
    }
  }

  adminBody() {
    if (selectedIndex == 0) {
      return AddItem();
    } else if (selectedIndex == 1) {
      return UpdateItem();
    } else if (selectedIndex == 2) {
      return DeleteItem();
    } else if (selectedIndex == 3) {
      return Orders();
    }
  }

  customerBody() {
    return ItemList();
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
