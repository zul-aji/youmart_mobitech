import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/product_download.dart';

class FirestoreDB {
  // Initialise Firebase Cloud Firestore
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Stream<List<ProductDownloadModel>> getAllProducts() {
    return _firebaseFirestore.collection('product').snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => ProductDownloadModel.fromSnapshot(doc))
          .toList();
    });
  }
}
