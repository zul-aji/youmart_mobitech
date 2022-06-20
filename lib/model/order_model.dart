import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  String? oid;
  String? uid;
  String? firstName;
  String? secondName;
  String? totalprice;
  String? status;
  Timestamp? timestamp;
  List<dynamic>? nameList;
  List<dynamic>? imageList;
  List<dynamic>? quantityList;

  OrderModel({
    this.oid,
    this.uid,
    this.firstName,
    this.secondName,
    this.totalprice,
    this.status,
    this.nameList,
    this.timestamp,
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
      firstName: data?['firstName'],
      secondName: data?['secondName'],
      totalprice: data?['totalprice'],
      timestamp: data?['timestamp'],
      status: data?['status'],
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
      if (firstName != null) "firstName": firstName,
      if (secondName != null) "secondName": secondName,
      if (totalprice != null) "totalprice": totalprice,
      if (nameList != null) "nameList": nameList,
      if (imageList != null) "imageList": imageList,
      if (quantityList != null) "quantityList": quantityList,
      if (timestamp != null) "timestamp": timestamp,
      if (status != null) "status": status,
    };
  }
}
