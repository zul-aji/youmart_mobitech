// import 'dart:core';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutterfire_ui/firestore.dart';
// // import 'package:provider/provider.dart';
// import 'package:youmart_mobitech/constants.dart';
// import 'package:youmart_mobitech/screens/home/components/customer/details_screen.dart';

// import '../../../../notifier/product_notifier.dart';
// import 'package:youmart_mobitech/api/firebase_api.dart';
// import 'package:youmart_mobitech/model/product_fix.dart';
//

// class ItemList extends StatelessWidget {
//   final queryProductList = FirebaseFirestore.instance
//       .collection('product')
//       .orderBy('name')
//       .withConverter<ProductList>(
//     fromFirestore: (snapshot, _) => ProductList.fromJson(snapshot.data()!),
//     toFirestore: (user, _) => user.toJson(),
//   );

//   @override
//   Widget build(BuildContext context) => FirestoreQueryBuilder<ProductList>(
//     query: queryProductList,
//     pageSize: 2,
//     builder: (context, snapshot, _) {
//       if (snapshot.isFetching) {
//         return Center(child: CircularProgressIndicator());
//       } else if (snapshot.hasError) {
//         return Text('Something went wrong! ${snapshot.error}');
//       } else {
//         return GridView.builder(
//           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: 2,
//           ),
//           itemCount: snapshot.docs.length + 1,
//           itemBuilder: (context, index) {
//             final hasEndReached = snapshot.hasMore &&
//                 index == snapshot.docs.length &&
//                 !snapshot.isFetchingMore;

//             if (hasEndReached) {
//               snapshot.fetchMore();
//             }

//             if (index == snapshot.docs.length) {
//               return Center(
//                 child: snapshot.isFetchingMore
//                     ? CircularProgressIndicator()
//                     : Container(),
//               );
//             }

//             final ProductList = snapshot.docs[index].data();
//             return buildProductList(ProductList);
//           },
//         );
//       }
//     },
//   );

//   Widget buildProductList(ProductList ProductList) => Card(
//     child: Container(
//       padding: EdgeInsets.all(8),
//       child: Column(
//         children: [
//           Expanded(
//             child: Image.network(
//               ProductList.image,
//               fit: BoxFit.cover,
//               width: double.infinity,
//             ),
//           ),
//           const SizedBox(height: 12),
//           Text(ProductList.name),
//         ],
//       ),
//     ),
//   );
// }
import 'package:flutter/material.dart';
import 'package:youmart_mobitech/screens/home/components/customer/cart_counter.dart';
import '../../../../model/local_product.dart';

import '../../../../constants.dart';

class ItemList extends StatelessWidget {
  const ItemList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(15),
              height: 180,
              width: 160,
              decoration: BoxDecoration(
                color: colorPrimaryLight,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Hero(
                tag: 'product ID',
                // "${product.id}",
                child: Text('Image here'),
                // Image.asset(product.image),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5, right: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'title',
                  // product.title,
                  style: TextStyle(color: colorPrimaryDark),
                ),
                Text(
                  'price',
                  // "${product.price} RM",
                  style: const TextStyle(
                      color: colorPrimaryDark, fontWeight: FontWeight.w700),
                ),
                CartCounter(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
