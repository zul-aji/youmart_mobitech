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
import 'cart_list.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final cartController = Get.put(CartController());
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
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Your Cart",
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
      ),
      body: CartList(),
      bottomNavigationBar: Obx(
        () => Container(
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 50),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ifTotalEmpty(),
              ifCheckoutEmpty(),
            ],
          ),
        ),
      ),
    );
  }

  ifTotalEmpty() {
    if (cartController.products.length < 1) {
      return const Text(
        '0 RM',
        style: TextStyle(
          color: colorPrimaryDark,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      );
    } else if (cartController.products.length > 0) {
      return Text(
        '${cartController.total} RM',
        style: const TextStyle(
          color: colorPrimaryDark,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      );
    }
  }

  ifCheckoutEmpty() {
    if (cartController.products.length < 1) {
      return ElevatedButton(
        onPressed: () {
          Fluttertoast.showToast(msg: "There is no product in cart");
        },
        style: ElevatedButton.styleFrom(
            primary: colorUnpicked,
            textStyle: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 20,
                fontWeight: FontWeight.w600)),
        child: const Text("Checkout"),
      );
    } else if (cartController.products.length > 0) {
      return ElevatedButton(
        onPressed: () => showDialog<String>(
          context: context,
          barrierDismissible: true,
          builder: (BuildContext context) => AlertDialog(
            title: const Text(
              'Checkout Items',
              style: TextStyle(
                fontSize: 25,
                color: colorPrimary,
                fontWeight: FontWeight.w700,
              ),
            ),
            content: const Text(
              'You will not be able to cancel or change items if you checkout',
              style: TextStyle(
                color: colorPrimaryDark,
                fontWeight: FontWeight.w500,
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, 'Cancel'),
                child: const Text(
                  'Cancel',
                  style: TextStyle(
                    color: colorUnpicked,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  placeOrderToDB();
                  cartController.clearProducts();
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'Checkout',
                  style: TextStyle(
                    color: colorPrimaryDark,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
            backgroundColor: colorWhite,
          ),
        ),
        style: ElevatedButton.styleFrom(
            primary: colorPrimary,
            textStyle: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 20,
                fontWeight: FontWeight.w600)),
        child: const Text("Checkout"),
      );
    }
  }

  placeOrderToDB() {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    OrderModel orderModel = OrderModel();
    var uuid = const Uuid();

    // writing all the values
    orderModel.oid = uuid.v1();
    orderModel.uid = loggedInUser.uid;
    orderModel.firstName = loggedInUser.firstName;
    orderModel.secondName = loggedInUser.secondName;
    orderModel.totalprice = cartController.total as String?;
    orderModel.nameList = cartController.nameList;
    orderModel.imageList = cartController.imageList;
    orderModel.quantityList = cartController.quantityList;
    orderModel.pidList = cartController.pidList;
    orderModel.timestamp = Timestamp.now();
    orderModel.status = "Pending";

    firebaseFirestore
        .collection("order")
        .doc(orderModel.oid)
        .set(orderModel.toFirestore());

    Navigator.of(context).pop();
    Fluttertoast.showToast(msg: "Order Placed");
  }
}
