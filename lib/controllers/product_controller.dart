import 'package:get/get.dart';
import 'package:youmart_mobitech/services/firebase_db.dart';

import '../model/product_download.dart';

class ProductController extends GetxController {
  // Add a list of Product objects.
  final products = <ProductDownloadModel>[].obs;

  @override
  void onInit() {
    products.bindStream(FirestoreDB().getAllProducts());
    super.onInit();
  }
}
