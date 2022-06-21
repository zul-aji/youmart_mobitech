import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../model/user_model.dart';
import '../../../constants.dart';
import '../../../model/shopstat_model.dart';
import 'admin/add_item.dart';
import 'admin/delete_item.dart';
import 'admin/order/aorder_history.dart';
import 'admin/order/orders.dart';
import 'admin/shop_status.dart';
import 'admin/update_item.dart';
import 'customer/beverage_list.dart';
import 'customer/instant_list.dart';
import 'customer/personalc_list.dart';
import 'customer/snack_list.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({Key? key}) : super(key: key);

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  ShopStatusModel shopStatus = ShopStatusModel();
  // ShopStatusModel shopStatusD = ShopStatusModelDownload(status: status);

  // string for displaying the error Message
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance.collection("users").doc(user!.uid).get().then(
      (value) {
        loggedInUser = UserModel.fromMap(value.data());
        setState(() {});
      },
    );
    FirebaseFirestore.instance
        .collection("shop_status")
        .doc("statID")
        .get()
        .then(
      (value) {
        shopStatus = ShopStatusModel.fromMap(value.data());
        setState(() {});
      },
    );
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
          return custOpenClose();
        }
      }),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Row(
          children: [
            headingTitle,
          ],
        ),
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
        child: Padding(
            padding: const EdgeInsets.only(left: 30.0, right: 30.0, top: 10),
            child: adminBody()),
      );
    } else {
      return Expanded(
        child: Padding(
            padding: const EdgeInsets.only(left: 18.0, right: 4.0, top: 20),
            child: customerBody()),
      );
    }
  }

  custOpenClose() {
    if (shopStatus.status == true) {
      return const Text(
        "Shop is open!",
        style: TextStyle(
          fontSize: 35,
          color: colorPrimaryDark,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w700,
        ),
      );
    } else {
      return const Text(
        "Shop closed",
        style: TextStyle(
          fontSize: 35,
          color: colorAccent,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w700,
        ),
      );
    }
  }

  adminBody() {
    if (selectedIndex == 0) {
      return ShopStatus();
    } else if (selectedIndex == 1) {
      return const AddItem();
    } else if (selectedIndex == 2) {
      return const UpdateItem();
    } else if (selectedIndex == 3) {
      return const DeleteItem();
    } else if (selectedIndex == 4) {
      return const Orders();
    } else if (selectedIndex == 5) {
      return const AdmminOrderHistory();
    }
  }

  customerBody() {
    if (selectedIndex == 0) {
      return SnackList();
    } else if (selectedIndex == 1) {
      return InstantList();
    } else if (selectedIndex == 2) {
      return BeverageList();
    } else if (selectedIndex == 3) {
      return PersonalCList();
    }
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
