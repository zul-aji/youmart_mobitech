import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';

import 'package:youmart_mobitech/model/product_download.dart';

import '../../../../constants.dart';

class ItemList extends StatelessWidget {
  final queryProductDownloadModel = FirebaseFirestore.instance
      .collection('product')
      .orderBy('name')
      .withConverter<ProductDownloadModel>(
        fromFirestore: (snapshot, _) =>
            ProductDownloadModel.fromJson(snapshot.data()!),
        toFirestore: (user, _) => user.toJson(),
      );

  ItemList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      FirestoreQueryBuilder<ProductDownloadModel>(
        query: queryProductDownloadModel,
        pageSize: 10,
        builder: (context, snapshot, _) {
          if (snapshot.isFetching) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text('Something went wrong! ${snapshot.error}');
          } else if (snapshot.hasData == false) {
            return const Text('No item available');
          } else {
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
                childAspectRatio: 0.68,
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
                        ? const CircularProgressIndicator()
                        : Container(),
                  );
                }

                final productData = snapshot.docs[index].data();
                return buildProductDownloadModel(productData);
              },
            );
          }
        },
      );

  Widget buildProductDownloadModel(ProductDownloadModel productData) {
    final price = productData.price.toString();

    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.only(right: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
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
                  tag: productData.pid,
                  child: Image.network(productData.image),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(height: 8),
                  Text(
                    productData.name,
                    style: const TextStyle(
                      color: colorPrimaryDark,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    "$price RM",
                    style: const TextStyle(
                      color: colorPrimaryDark,
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 5),
                  stockCheck(productData),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  stockCheck(productData) {
    int stock = int.parse(productData.stock);

    if (stock == 0) {
      return const Padding(
        padding: EdgeInsets.only(bottom: 14, top: 5),
        child: Text(
          "No Stock",
          style: TextStyle(
              fontSize: 20, color: colorAccent, fontWeight: FontWeight.bold),
        ),
      );
    } else {
      return Material(
        borderRadius: BorderRadius.circular(15),
        color: colorPrimaryDark,
        child: MaterialButton(
          padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          onPressed: () {},
          child: const Text(
            "Add to Cart",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 13, color: colorBase, fontWeight: FontWeight.bold),
          ),
        ),
      );
    }
  }
}
