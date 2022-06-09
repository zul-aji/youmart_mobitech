import 'package:cloud_firestore/cloud_firestore.dart';

// class ProductDownloadModel {
//   final String oid, totalprice;
//   final List<String>? itemlist;
//
//   const ProductDownloadModel({
//     required this.oid,
//     required this.itemlist,
//     required this.totalprice,
//   });
//
//   // ProductDownloadModel.fromJson(Map<String, Object?> json)
//   //     : this(
//   //   oid: json['name']! as String,
//   //   itemlist: snap['itemlist'] is Iterable ? List.from(snap?['itemlist']) : null,
//   //   totalprice: json['price']! as String,
//   // );
//
//   Map<String, Object?> toJson() => {
//     'pid': pid,
//     'name': name,
//     'price': price,
//   };
//
//   static ProductDownloadModel fromSnapshot(DocumentSnapshot snap) {
//     ProductDownloadModel product = ProductDownloadModel(
//       pid: snap['[pid]'],
//       itemlist: snap['itemlist'] is Iterable ? List.from(snap?['itemlist']) : null,
//     );
//     return product;
//   }
// }

class OrderModel {
  String? oid;
  String? totalprice;
  List<String>? itemlist;

  OrderModel({
    this.oid,
    this.totalprice,
    this.itemlist,
  });

  factory OrderModel.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options,
      ) {
    final data = snapshot.data();
    return OrderModel(
      oid: data?['oid'],
      totalprice: data?['totalprice'],
      itemlist:
      data?['itemlist'] is Iterable ? List.from(data?['itemlist']) : null,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (oid != null) "oid": oid,
      if (totalprice != null) "totalprice": totalprice,
      if (itemlist != null) "regions": itemlist,
    };
  }
}
