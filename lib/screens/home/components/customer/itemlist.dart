import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';

import 'package:youmart_mobitech/model/product_fix.dart';
import 'package:youmart_mobitech/screens/home/components/customer/cart_counter.dart';

import '../../../../constants.dart';

class ItemList extends StatelessWidget {
  final queryProductList = FirebaseFirestore.instance
      .collection('product')
      .orderBy('name')
      .withConverter<ProductList>(
        fromFirestore: (snapshot, _) => ProductList.fromJson(snapshot.data()!),
        toFirestore: (user, _) => user.toJson(),
      );

  ItemList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => FirestoreQueryBuilder<ProductList>(
        query: queryProductList,
        pageSize: 2,
        builder: (context, snapshot, _) {
          if (snapshot.isFetching) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text('Something went wrong! ${snapshot.error}');
          } else if (snapshot.hasData == false) {
            return Text('No item available');
          } else {
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
                childAspectRatio: 0.69,
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

  Widget buildProductList(ProductList ProductList) => GestureDetector(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(12),
                height: 180,
                width: 160,
                decoration: BoxDecoration(
                  color: colorPrimaryLight,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Hero(
                  tag: ProductList.pid,
                  child: Image.network(ProductList.image),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5, right: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    ProductList.name,
                    style: TextStyle(
                      color: colorPrimaryDark,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    "${ProductList.price} RM",
                    style: const TextStyle(
                      color: colorPrimaryDark,
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                    ),
                  ),
                  CartCounter(),
                ],
              ),
            ),
          ],
        ),
      );
}
