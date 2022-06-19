import 'package:cloud_firestore/cloud_firestore.dart';

class OrderCustomer {
  final String oid, pid, firstName, secondName, totalprice;
  final List<dynamic> nameList, imageList, quantityList;

  const OrderCustomer({
    required this.oid,
    required this.pid,
    required this.firstName,
    required this.secondName,
    required this.totalprice,
    required this.nameList,
    required this.imageList,
    required this.quantityList,
  });

  static OrderCustomer fromSnapshot(DocumentSnapshot snap) {
    OrderCustomer orderC = OrderCustomer(
      oid: snap['oid'],
      pid: snap['pid'],
      firstName: snap['firstName'],
      secondName: snap['secondName'],
      totalprice: snap['totalprice'],
      nameList: snap['nameList'],
      imageList: snap['imageList'],
      quantityList: snap['quantityList'],
    );
    return orderC;
  }
}
