import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';
// import 'package:provider/provider.dart';
import 'package:youmart_mobitech/constants.dart';
import 'package:youmart_mobitech/model/product_model_view.dart';
import 'package:youmart_mobitech/screens/home/components/customer/details_screen.dart';

import '../../../../notifier/product_notifier.dart';
import 'package:youmart_mobitech/api/firebase_api.dart';
import 'package:youmart_mobitech/model/product_fix.dart';
//
// class ItemList extends StatefulWidget {
//   final String? productId;
//   ItemList({Key? key, this.productId}) : super(key: key);
//
//   @override
//   State<ItemList> createState() => _ItemListState();
// }
//
// class _ItemListState extends State<ItemList> {
//   User? product = FirebaseAuth.instance.currentUser;
//
//   @override
//   Widget build(BuildContext context) => MaterialApp(
//         debugShowCheckedModeBanner: false,
//         title: title,
//         theme: ThemeData(
//           primarySwatch: Colors.red,
//           elevatedButtonTheme: ElevatedButtonThemeData(
//             style: ElevatedButton.styleFrom(
//               minimumSize: Size.fromHeight(46),
//               textStyle: TextStyle(fontSize: 24),
//             ),
//           ),
//         ),
//       );
//
//   static final String title = 'Firestore CRUD Write';
//
//   Widget buildProductModelView() => StreamBuilder<List<ProductModelView>>(
//       stream: readProduct(),
//       builder: (context, snapshot) {
//         if (snapshot.hasError) {
//           return Text('Something went wrong! ${snapshot.error}');
//         } else if (snapshot.hasData) {
//           final productModelView = snapshot.data!;
//           return ListView(children: productModelView.docs.toList());
//         } else {
//           return Center(child: CircularProgressIndicator());
//         }
//       });
//
//   Widget buildProduct(ProductModelView productModelView) => ListTile(
//         leading: Text(productModelView.category),
//         title: Text(productModelView.name),
//         subtitle: Text(productModelView.price),
//       );
//
//   Stream<List<ProductModelView>> readProduct() => FirebaseFirestore.instance
//       .collection('product')
//       .snapshots()
//       .map((snapshot) => snapshot.docs
//           .map((doc) => ProductModelView.fromJson(doc.data()))
//           .toList());
// }


class ItemList extends StatelessWidget {
  final queryProductList = FirebaseFirestore.instance
      .collection('product')
      .orderBy('name')
      .withConverter<ProductList>(
    fromFirestore: (snapshot, _) => ProductList.fromJson(snapshot.data()!),
    toFirestore: (user, _) => user.toJson(),
  );

  @override
  Widget build(BuildContext context) => FirestoreQueryBuilder<ProductList>(
    query: queryProductList,
    pageSize: 2,
    builder: (context, snapshot, _) {
      if (snapshot.isFetching) {
        return Center(child: CircularProgressIndicator());
      } else if (snapshot.hasError) {
        return Text('Something went wrong! ${snapshot.error}');
      } else {
        return GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          itemCount: snapshot.docs.length + 1,
          itemBuilder: (context, index) {
            final hasEndReached = snapshot.hasMore &&
                index == snapshot.docs.length &&
                !snapshot.isFetchingMore;

            if (hasEndReached) {
              snapshot.fetchMore();
            }

            if (index == snapshot.docs.length) {
              return Center(
                child: snapshot.isFetchingMore
                    ? CircularProgressIndicator()
                    : Container(),
              );
            }

            final ProductList = snapshot.docs[index].data();
            return buildProductList(ProductList);
          },
        );
      }
    },
  );

  Widget buildProductList(ProductList ProductList) => Card(
    child: Container(
      padding: EdgeInsets.all(8),
      child: Column(
        children: [
          Expanded(
            child: Image.network(
              ProductList.image,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
          const SizedBox(height: 12),
          Text(ProductList.name),
        ],
      ),
    ),
  );
}