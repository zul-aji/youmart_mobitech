import 'dart:collection';

import 'package:flutter/cupertino.dart';

import '../model/product_model.dart';

class ProductNotifier with ChangeNotifier {
  List<ProductModel> _productList = [];
  late ProductModel _currentProduct;

  UnmodifiableListView<ProductModel> get productList => UnmodifiableListView(_productList);

  ProductModel get currentProduct => _currentProduct;

  set productList(List<ProductModel> productList) {
    _productList = productList;
    notifyListeners();
  }

  set currentProduct(ProductModel productModel) {
    _currentProduct = productModel;
    notifyListeners();
  }

  // addFood(ProductModel productModel) {
  //   _productList.insert(0, productModel);
  //   notifyListeners();
  // }

  // deleteFood(Food food) {
  //   _foodList.removeWhere((_food) => _food.id == food.id);
  //   notifyListeners();
  // }
}