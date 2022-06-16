import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../model/product_download.dart';

class CartController extends GetxController {
  final _products = {}.obs;

  void addProduct(ProductDownloadModel product) {
    if (_products.containsKey(product)) {
      _products[product] += 1;
    } else {
      _products[product] = 1;
    }

    Fluttertoast.showToast(msg: "${product.name} added to Cart");
  }

  void removeProduct(ProductDownloadModel product) {
    if (_products.containsKey(product) && _products[product] == 1) {
      _products.removeWhere((key, value) => key == product);
    } else {
      _products[product] -= 1;
    }

    Fluttertoast.showToast(msg: "${product.name} removed from Cart");
  }

  get products => _products;

  get productSubtotal => _products.entries
      .map((product) => product.key.price * product.value)
      .toList();

  get total => _products.entries
      .map((product) => double.parse(product.key.price) * product.value)
      .toList()
      .reduce((value, element) => value + element)
      .toStringAsFixed(2);
}
