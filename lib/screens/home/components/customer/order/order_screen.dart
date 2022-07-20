import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../constants.dart';
import '../../../../../model/user_model.dart';
import 'order_history.dart';
import 'order_list.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel(email: '');
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
    final upperLeftIcon3 = LayoutBuilder(builder: (context, constraints) {
      if (loggedInUser.role == 'Guest') {
        return const Text(" ");
      } else {
        return IconButton(
          icon: const Icon(Icons.history, color: colorAccent),
          onPressed: () => Get.to(() => const OrderHistory()),
        );
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Your Orders",
          style: TextStyle(
            fontSize: 25,
            color: colorPrimaryDark,
            fontWeight: FontWeight.w700,
          ),
        ),
        backgroundColor: colorWhite,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: colorAccent),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: upperLeftIcon3,
          ),
        ],
      ),
      body: OrderList(uid: loggedInUser.uid ?? " "),
    );
  }
}
