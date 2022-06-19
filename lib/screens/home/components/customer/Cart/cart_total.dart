import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

import '../../../../../constants.dart';
import '../../../../../controllers/cart_controller.dart';
import '../../../../../model/order_model.dart';
import '../../../../../model/user_model.dart';

final CartController controller = Get.put(CartController());

class CartTotal extends StatefulWidget {
  const CartTotal({Key? key}) : super(key: key);

  @override
  State<CartTotal> createState() => _CartTotalState();
}

class _CartTotalState extends State<CartTotal> {
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
    return Obx(
      () => Container(
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 50),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (controller.total == '0')
              const Text(
                '0 RM',
                style: TextStyle(
                  color: colorPrimaryDark,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              )
            else
              Text(
                '${controller.total} RM',
                style: const TextStyle(
                  color: colorPrimaryDark,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ElevatedButton(
              onPressed: () {
                placeOrderToDB();
              },
              style: ElevatedButton.styleFrom(
                  primary: colorPrimary,
                  onPrimary: colorBase,
                  textStyle: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 20,
                      fontWeight: FontWeight.w600)),
              child: const Text("Checkout"),
            ),
          ],
        ),
      ),
    );
  }

  placeOrderToDB() {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    OrderModel orderModel = OrderModel();
    var uuid = const Uuid();

    // writing all the values
    orderModel.oid = uuid.v1();
    orderModel.uid = loggedInUser.uid;
    orderModel.totalprice = controller.total;
    orderModel.nameList = controller.nameList;
    orderModel.imageList = controller.imageList;
    orderModel.quantityList = controller.quantityList;

    firebaseFirestore
        .collection("order")
        .doc(orderModel.oid)
        .set(orderModel.toFirestore());

    controller.clearProducts();
    Navigator.of(context).pop();
    Fluttertoast.showToast(msg: "Order Placed");
  }
}
