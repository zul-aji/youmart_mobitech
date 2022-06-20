import 'package:cloud_firestore/cloud_firestore.dart';

class OrderAdmin {

  final String firstName, secondName, oid, uid, totalprice;
  final List<dynamic> nameList, imageList, quantityList;

  const OrderAdmin({
    required this.oid,
    required this.firstName,
    required this.secondName,
    required this.uid,
    required this.totalprice,
    required this.nameList,
    required this.imageList,
    required this.quantityList,
  });


  // factory OrderAdmin.fromFirestore(
  //     DocumentSnapshot<Map<String, dynamic>> snapshot,
  //     SnapshotOptions? options,
  //     ) {
  //   final data = snapshot.data();
  //   return OrderAdmin(
  //     oid: data?['oid'],
  //     uid: data?['uid'],
  //     secondName: data?['secondName'],
  //     firstName: data?['firstName'],
  //     totalprice: data?['totalprice'],
  //     nameList:
  //     data?['nameList'] is Iterable ? List.from(data?['nameList']) : null,
  //     imageList:
  //     data?['imageList'] is Iterable ? List.from(data?['imageList']) : null,
  //     quantityList:
  //     data?['quantityList'] is Iterable ? List.from(data?['quantityList']) : null,
  //   );
  // }

  OrderAdmin.fromJson(Map<String, Object?> json)
      : this(
        oid: json['oid']! as String,
        uid: json['uid']! as String,
        secondName: json['secondName']! as String,
        firstName: json['firstName']! as String,
        totalprice: json['totalprice']! as String,
        nameList: json['quantityList']! as List,
        imageList: json['nameList']! as List,
        quantityList: json['imageList']! as List,
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

  static OrderAdmin fromSnapshot(DocumentSnapshot snap) {
    OrderAdmin order = OrderAdmin(
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
