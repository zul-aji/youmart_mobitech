import 'package:cloud_firestore/cloud_firestore.dart';

class OrderCustomer {
  final String oid, uid, firstName, secondName, totalprice, status;
  final List<dynamic> nameList, imageList, quantityList;
  final Timestamp timestamp;

  const OrderCustomer({
    required this.oid,
    required this.uid,
    required this.firstName,
    required this.secondName,
    required this.timestamp,
    required this.status,
    required this.totalprice,
    required this.nameList,
    required this.imageList,
    required this.quantityList,
  });

  OrderCustomer.fromJson(Map<String, Object?> json)
      : this(
          oid: json['oid']! as String,
          uid: json['uid']! as String,
          firstName: json['firstName']! as String,
          secondName: json['secondName']! as String,
          timestamp: json['timestamp']! as Timestamp,
          totalprice: json['totalprice']! as String,
          status: json['status']! as String,
          nameList: json['nameList']! as List<dynamic>,
          imageList: json['imageList']! as List<dynamic>,
          quantityList: json['quantityList']! as List<dynamic>,
        );

  Map<String, Object?> toJson() => {
        'oid': oid,
        'uid': uid,
        'firstName': firstName,
        'secondName': secondName,
        'totalprice': totalprice,
        'status': status,
        'timestamp': timestamp,
        'nameList': nameList,
        'imageList': imageList,
        'quantityList': quantityList,
      };

  static OrderCustomer fromSnapshot(DocumentSnapshot snap) {
    OrderCustomer orderC = OrderCustomer(
      oid: snap['oid'],
      uid: snap['uid'],
      firstName: snap['firstName'],
      secondName: snap['secondName'],
      totalprice: snap['totalprice'],
      status: snap['status'],
      timestamp: snap['timestamp'],
      nameList: snap['nameList'],
      imageList: snap['imageList'],
      quantityList: snap['quantityList'],
    );
    return orderC;
  }
}
