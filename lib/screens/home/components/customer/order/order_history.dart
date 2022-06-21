import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:youmart_mobitech/screens/home/components/customer/order/order_history_list.dart';

import '../../../../../constants.dart';
import '../../../../../model/user_model.dart';

class OrderHistory extends StatefulWidget {
  OrderHistory({Key? key}) : super(key: key);

  @override
  State<OrderHistory> createState() => _OrderHistoryState();
}

class _OrderHistoryState extends State<OrderHistory> {
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
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Order History",
          style: TextStyle(
            fontSize: 25,
            color: colorPrimaryDark,
            fontWeight: FontWeight.w700,
          ),
        ),
        backgroundColor: const Color(0xFFFFFFFF),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: colorAccent),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: OrderHistoryList(uid: loggedInUser.uid ?? " "),
    );
  }
}
