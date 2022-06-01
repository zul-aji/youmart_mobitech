import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../model/product_upload.dart';
import '../notifier/product_notifier.dart';

//these are function to upload file / bytes (for textfile maybe)
class FirebaseApi {
  static UploadTask? uploadFile(String destination, File file) {
    try {
      final ref = FirebaseStorage.instance.ref(destination);

      return ref.putFile(file);
    } on FirebaseException catch (e) {
      return null;
    }
  }

  static UploadTask? uploadBytes(String destination, Uint8List data) {
    try {
      final ref = FirebaseStorage.instance.ref(destination);

      return ref.putData(data);
    } on FirebaseException catch (e) {
      return null;
    }
  }

  getProduct(ProductNotifier productNotifier) async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('product')
        .orderBy("name", descending: true)
        .get();

    List<ProductUploadModel> _productList = [];

    snapshot.docs.forEach((document) {
      ProductUploadModel product = ProductUploadModel.fromMap(document.data);
      _productList.add(product);
    });

    productNotifier.productList = _productList;
  }
}
