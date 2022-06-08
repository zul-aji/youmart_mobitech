import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:youmart_mobitech/model/local_product.dart';

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
}
