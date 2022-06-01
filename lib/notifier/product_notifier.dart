import 'dart:collection';

import 'package:flutter/cupertino.dart';

import '../model/product_upload.dart';

class ProductNotifier with ChangeNotifier {
  List<ProductUploadModel> _productList = [];
  late ProductUploadModel _currentProduct;

  UnmodifiableListView<ProductUploadModel> get productList =>
      UnmodifiableListView(_productList);

  ProductUploadModel get currentProduct => _currentProduct;

  set productList(List<ProductUploadModel> productList) {
    _productList = productList;
    notifyListeners();
  }

  set currentProduct(ProductUploadModel ProductUploadModel) {
    _currentProduct = ProductUploadModel;
    notifyListeners();
  }
}
