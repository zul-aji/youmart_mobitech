import 'package:get/get.dart';
import 'package:youmart_mobitech/services/firebase_db.dart';

import '../model/product_download.dart';

class ProductController extends GetxController {
  // Add a list of Product objects.
  final allProduct = <ProductDownloadModel>[].obs;
  final snackProduct = <ProductDownloadModel>[].obs;
  final instantProduct = <ProductDownloadModel>[].obs;
  final beverageProduct = <ProductDownloadModel>[].obs;
  final personalProduct = <ProductDownloadModel>[].obs;

  @override
  void onInit() {
    allProduct.bindStream(FirestoreDB().getAllProducts());
    snackProduct.bindStream(FirestoreDB().getSnackProducts());
    instantProduct.bindStream(FirestoreDB().getInstantProducts());
    beverageProduct.bindStream(FirestoreDB().getBeverageProducts());
    personalProduct.bindStream(FirestoreDB().getPersonalProducts());
    super.onInit();
  }
}
