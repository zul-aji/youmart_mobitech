import 'package:cloud_firestore/cloud_firestore.dart';

class CompleteOrderCustomer {
  final String coid, uid, firstName, secondName, totalprice;
  final List<dynamic> nameList, imageList, quantityList;
  final Timestamp timestamp;

  const CompleteOrderCustomer({
    required this.coid,
    required this.uid,
    required this.firstName,
    required this.secondName,
    required this.timestamp,
    required this.totalprice,
    required this.nameList,
    required this.imageList,
    required this.quantityList,
  });

  CompleteOrderCustomer.fromJson(Map<String, Object?> json)
      : this(
          coid: json['coid']! as String,
          uid: json['uid']! as String,
          firstName: json['firstName']! as String,
          secondName: json['secondName']! as String,
          timestamp: json['timestamp']! as Timestamp,
          totalprice: json['totalprice']! as String,
          nameList: json['nameList']! as List<dynamic>,
          imageList: json['imageList']! as List<dynamic>,
          quantityList: json['quantityList']! as List<dynamic>,
        );

  Map<String, Object?> toJson() => {
        'coid': coid,
        'uid': uid,
        'firstName': firstName,
        'secondName': secondName,
        'totalprice': totalprice,
        'timestamp': timestamp,
        'nameList': nameList,
        'imageList': imageList,
        'quantityList': quantityList,
      };

  static CompleteOrderCustomer fromSnapshot(DocumentSnapshot snap) {
    CompleteOrderCustomer completeOrderC = CompleteOrderCustomer(
      coid: snap['coid'],
      uid: snap['uid'],
      firstName: snap['firstName'],
      secondName: snap['secondName'],
      totalprice: snap['totalprice'],
      timestamp: snap['timestamp'],
      nameList: snap['nameList'],
      imageList: snap['imageList'],
      quantityList: snap['quantityList'],
    );
    return completeOrderC;
  }
}
