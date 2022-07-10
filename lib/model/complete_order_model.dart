import 'package:cloud_firestore/cloud_firestore.dart';

class CompleteOrderModel {
  String? coid;
  String? uid;
  String? firstName;
  String? secondName;
  String? totalprice;
  Timestamp? timestamp;
  List<dynamic>? nameList;
  List<dynamic>? imageList;
  List<dynamic>? quantityList;
  List<dynamic>? pidList;

  CompleteOrderModel({
    this.coid,
    this.uid,
    this.firstName,
    this.secondName,
    this.totalprice,
    this.nameList,
    this.timestamp,
    this.imageList,
    this.quantityList,
    this.pidList,
  });

  factory CompleteOrderModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return CompleteOrderModel(
      coid: data?['coid'],
      uid: data?['uid'],
      firstName: data?['firstName'],
      secondName: data?['secondName'],
      totalprice: data?['totalprice'],
      timestamp: data?['timestamp'],
      nameList:
          data?['nameList'] is Iterable ? List.from(data?['nameList']) : null,
      imageList:
          data?['imageList'] is Iterable ? List.from(data?['imageList']) : null,
      quantityList: data?['quantityList'] is Iterable
          ? List.from(data?['quantityList'])
          : null,
      pidList:
          data?['pidList'] is Iterable ? List.from(data?['pidList']) : null,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (coid != null) "coid": coid,
      if (uid != null) "uid": uid,
      if (firstName != null) "firstName": firstName,
      if (secondName != null) "secondName": secondName,
      if (totalprice != null) "totalprice": totalprice,
      if (nameList != null) "nameList": nameList,
      if (imageList != null) "imageList": imageList,
      if (quantityList != null) "quantityList": quantityList,
      if (pidList != null) "pidList": pidList,
      if (timestamp != null) "timestamp": timestamp,
    };
  }
}
