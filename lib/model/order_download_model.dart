import 'package:cloud_firestore/cloud_firestore.dart';

class OrderDownloadModel {

  final String firstName, secondName, oid, uid, totalprice;
  final List<dynamic>? nameList, imageList, quantityList;

  const OrderDownloadModel({
    required this.oid,
    required this.firstName,
    required this.secondName,
    required this.uid,
    required this.totalprice,
    required this.nameList,
    required this.imageList,
    required this.quantityList,
  });


  factory OrderDownloadModel.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options,
      ) {
    final data = snapshot.data();
    return OrderDownloadModel(
      oid: data?['oid'],
      uid: data?['uid'],
      secondName: data?['secondName'],
      firstName: data?['firstName'],
      totalprice: data?['totalprice'],
      nameList:
      data?['nameList'] is Iterable ? List.from(data?['nameList']) : null,
      imageList:
      data?['imageList'] is Iterable ? List.from(data?['imageList']) : null,
      quantityList:
      data?['quantityList'] is Iterable ? List.from(data?['quantityList']) : null,
    );
  }

  OrderDownloadModel.fromJson(Map<String, Object?> json)
      : this(
        oid: json['name']! as String,
        uid: json['category']! as String,
        secondName: json['secondName']! as String,
        firstName: json['firstName']! as String,
        totalprice: json['price']! as String,
        nameList: json['stock']! as List,
        imageList: json['pid']! as List,
        quantityList: json['image']! as List,
  );

  Map<String, Object?> toJson() => {
    'oid': oid,
    'uid': uid,
    'secondName': secondName,
    'firstName': firstName,
    'totalprice': totalprice,
    'nameList': nameList,
    'imageList': imageList,
    'quantityList': quantityList,
  };

  static OrderDownloadModel fromSnapshot(DocumentSnapshot snap) {
    OrderDownloadModel order = OrderDownloadModel(
      oid: snap['oid'],
      uid: snap['uid'],
      secondName: snap['secondName'],
      firstName: snap['firstName'],
      totalprice: snap['totalprice'],
      nameList: snap['nameList'],
      imageList: snap['imageList'],
      quantityList: snap['quantityList'],
    );
    return order;
  }
}
