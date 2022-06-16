import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  String? oid;
  String? uid;
  String? totalprice;
  List<dynamic>? nameList;
  List<dynamic>? imageList;
  List<dynamic>? quantityList;

  OrderModel({
    this.oid,
    this.uid,
    this.totalprice,
    this.nameList,
    this.imageList,
    this.quantityList,
  });

  factory OrderModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return OrderModel(
      oid: data?['oid'],
      uid: data?['uid'],
      totalprice: data?['totalprice'],
      nameList:
          data?['nameList'] is Iterable ? List.from(data?['nameList']) : null,
      imageList:
          data?['imageList'] is Iterable ? List.from(data?['imageList']) : null,
      quantityList: data?['quantityList'] is Iterable
          ? List.from(data?['quantityList'])
          : null,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (oid != null) "oid": oid,
      if (uid != null) "uid": uid,
      if (totalprice != null) "totalprice": totalprice,
      if (nameList != null) "nameList": nameList,
      if (imageList != null) "imageList": imageList,
      if (quantityList != null) "quantityList": quantityList,
    };
  }
}
