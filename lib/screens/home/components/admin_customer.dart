import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:youmart_mobitech/model/user_model.dart';

import 'admin/add_item.dart';
import 'customer/itemlist.dart';

class AdminOrCustomer extends StatefulWidget {
  AdminOrCustomer({Key? key}) : super(key: key);

  @override
  State<AdminOrCustomer> createState() => _AdminOrCustomerState();
}

class _AdminOrCustomerState extends State<AdminOrCustomer> {
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

  @override
  Widget build(BuildContext context) {
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
    return AddItem();
  }

  customerBody() {
    return ItemList();
  }
}
