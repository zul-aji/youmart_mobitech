import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:youmart_mobitech/model/local_product.dart';
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

class UpdateItem extends StatefulWidget {
  UpdateItem({Key? key}) : super(key: key);

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
        pageSize: 2,
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
                return ListTile(
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
                      child: Text('Update Item'),
                      style: ElevatedButton.styleFrom(
                        primary: colorPrimaryDark,
                        onPrimary: colorBase,
                      ),
                    ),
                    title: Text(
                      productData.name,
                      style: const TextStyle(
                        color: colorPrimaryDark,
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                      ),
                    ));
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
                  Material(
                    borderRadius: BorderRadius.circular(15),
                    color: colorPrimaryDark,
                    child: MaterialButton(
                      padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                      onPressed: () {},
                      child: const Text(
                        "Add to Cart",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 12,
                            color: colorBase,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  deleteAccount() async {
    // calling our firestore
    // calling our user model
    // sending these values

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    ProductUploadModel productUploadModel = ProductUploadModel();

    Fluttertoast.showToast(msg: "Product Deleted");
  }
}
