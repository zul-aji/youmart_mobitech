import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:youmart_mobitech/model/product_download.dart';
import 'package:youmart_mobitech/model/product_upload.dart';

import '../../../../constants.dart';

final queryProductDownloadModel = FirebaseFirestore.instance
    .collection('product')
    .orderBy('name')
    .withConverter<ProductDownloadModel>(
      fromFirestore: (snapshot, _) =>
          ProductDownloadModel.fromJson(snapshot.data()!),
      toFirestore: (user, _) => user.toJson(),
    );

class DeleteItem extends StatefulWidget {
  DeleteItem({Key? key}) : super(key: key);

  @override
  State<DeleteItem> createState() => _DeleteItemState();
}

class _DeleteItemState extends State<DeleteItem> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(child: buildList(context));
  }

  Widget buildList(BuildContext context) =>
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
            return ListView.builder(
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
                return Card(
                  child: ListTile(
                    leading: Image.network(productData.image),
                    trailing: ElevatedButton(
                      onPressed: () {
                        FirebaseFirestore firebaseFirestore =
                            FirebaseFirestore.instance;
                        firebaseFirestore
                            .collection("product")
                            .doc(productData.pid)
                            .delete();
                        Fluttertoast.showToast(msg: "Product Deleted");
                      },
                      style: ElevatedButton.styleFrom(
                        primary: colorAccent,
                        onPrimary: colorBase,
                      ),
                      child: const Text('Delete Item'),
                    ),
                    title: Text(
                      productData.name,
                      style: const TextStyle(
                        color: colorPrimaryDark,
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      );
}
