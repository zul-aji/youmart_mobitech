import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:youmart_mobitech/model/local_product.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';
import '../../../../model/order_model.dart';

class CartController extends GetxController {
  final _products = {}.obs;

  void addProduct(LocalProduct product) {
    if (_products.containsKey(product)) {
      _products[product] += 1;
    } else {
      _products[product] = 1;
    }

    Fluttertoast.showToast(msg: "${product.title} added to Cart");
  }

  void removeProduct(LocalProduct product) {
    if (_products.containsKey(product) && _products[product] == 1) {
      _products.removeWhere((key, value) => key == product);
    } else {
      _products[product] -= 1;
    }

    Fluttertoast.showToast(msg: "${product.title} removed from Cart");
  }

  get products => _products;

  get productSubtotal => _products.entries
      .map((product) => product.key.price * product.value)
      .toList();

  get total => _products.entries
      .map((product) => product.key.price * product.value)
      .toList()
      .reduce((value, element) => value + element)
      .toStringAsFixed(2);

  void postOrderToFirestore(LocalProduct product) {
    // calling our firestore
    // calling our user model
    // sending these values

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    OrderModel orderModel = OrderModel();
    var uuid = Uuid();
    List<String> itemlist = [];

    // itemlist.add(product);

    // writing all the values
    orderModel.oid = uuid.v1();
    orderModel.itemlist = itemlist;
    // orderModel.prices = total;

    firebaseFirestore
        .collection("order")
        .doc(orderModel.oid)
        .set(orderModel.toFirestore());
    Fluttertoast.showToast(msg: "Order added successfully");
  }
}
