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
  int? totalprice;
  List<String>? prices;
  List<String>? itemlist;

  OrderModel({
    this.oid,
    this.prices,
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
      prices:
      data?['prices'] is Iterable ? List.from(data?['prices']) : null,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (oid != null) "oid": oid,
      if (itemlist != null) "itemlist": itemlist,
      if (prices != null) "prices": prices,
      if (totalprice != null) "totalprice": totalprice,

    };
  }
}
