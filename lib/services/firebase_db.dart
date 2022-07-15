import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/product_download.dart';

class FirestoreDB {
  // Initialise Firebase Cloud Firestore
  final CollectionReference fireCollection =
      FirebaseFirestore.instance.collection('product');

  //Queries for showing the Admin Categories
  final Query snackMap = FirebaseFirestore.instance
      .collection('product')
      .where("category", isEqualTo: "Snacks");
  final Query instantMap = FirebaseFirestore.instance
      .collection('product')
      .where("category", isEqualTo: "Instant Food");
  final Query beverageMap = FirebaseFirestore.instance
      .collection('product')
      .where("category", isEqualTo: "Beverages");
  final Query personalMap = FirebaseFirestore.instance
      .collection('product')
      .where("category", isEqualTo: "Personal Care");

  //Streams for the categories
  Stream<List<ProductDownloadModel>> getAllProducts() {
    return fireCollection.snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => ProductDownloadModel.fromSnapshot(doc))
          .toList();
    });
  }

  Stream<List<ProductDownloadModel>> getSnackProducts() {
    return snackMap.snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => ProductDownloadModel.fromSnapshot(doc))
          .toList();
    });
  }

  Stream<List<ProductDownloadModel>> getInstantProducts() {
    return instantMap.snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => ProductDownloadModel.fromSnapshot(doc))
          .toList();
    });
  }

  Stream<List<ProductDownloadModel>> getBeverageProducts() {
    return beverageMap.snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => ProductDownloadModel.fromSnapshot(doc))
          .toList();
    });
  }

  Stream<List<ProductDownloadModel>> getPersonalProducts() {
    return personalMap.snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => ProductDownloadModel.fromSnapshot(doc))
          .toList();
    });
  }
}
