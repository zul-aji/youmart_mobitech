import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';

import '../../../../constants.dart';
import '../../../../model/product_download.dart';
import 'item_details.dart';

final queryProductDownloadModel = FirebaseFirestore.instance
    .collection('product')
    .orderBy('name')
    .withConverter<ProductDownloadModel>(
      fromFirestore: (snapshot, _) =>
          ProductDownloadModel.fromJson(snapshot.data()!),
      toFirestore: (user, _) => user.toJson(),
    );

class UpdateItem extends StatefulWidget {
  const UpdateItem({Key? key}) : super(key: key);

  @override
  State<UpdateItem> createState() => _UpdateItemState();
}

class _UpdateItemState extends State<UpdateItem> {
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
                  elevation: 3.0,
                  child: ListTile(
                    leading: Image.network(productData.image),
                    title: Text(
                      productData.name,
                      style: const TextStyle(
                        color: colorPrimaryDark,
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                      ),
                    ),
                    subtitle: Text(
                      productData.category,
                      style: const TextStyle(
                        color: colorUnpicked,
                        fontWeight: FontWeight.w500,
                        fontSize: 13,
                      ),
                    ),
                    trailing: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ItemDetails(productData.pid)));
                      },
                      style: ElevatedButton.styleFrom(
                        primary: colorPrimary,
                        onPrimary: colorBase,
                      ),
                      child: const Text('Update Item'),
                    ),
                  ),
                );
              },
            );
          }
        },
      );
}
