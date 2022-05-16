import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:youmart_mobitech/constants.dart';
import 'package:youmart_mobitech/model/product_model.dart';
import 'package:youmart_mobitech/screens/home/components/customer/details_screen.dart';

import '../../../../notifier/product_notifier.dart';
import 'package:youmart_mobitech/api/firebase_api.dart';

class ItemList extends StatefulWidget {
  final String? productId;
  ItemList({Key? key, this.productId}) : super(key: key);

  @override
  State<ItemList> createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  User? product = FirebaseAuth.instance.currentUser;
  ProductModel productItem = ProductModel();

  @override
  void initState() {
    FirebaseFirestore.instance
        .collection("product")
        .doc(widget.productId)
        .get()
        .then((value) {
      this.productItem = ProductModel.fromMap(value.data());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection("product")
          .doc(widget.productId)
          .collection("itemimage")
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return (const Center(child: Text("No Images Found")));
        } else {
          return GridView.builder(
              itemCount: snapshot.data!.docs.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
                childAspectRatio: 0.75,
              ),
              itemBuilder: (context, index) {
                String url = snapshot.data!.docs[index]['downloadURL'];
                return GestureDetector(
                  // onTap: () {
                  //   Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //         builder: (context) => DetailsScreen(
                  //           product: snapshot.data!.docs[index],
                  //         ),
                  //       ));
                  // },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: colorBase,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Hero(
                            tag: "${productItem.pid}",
                            child: Image.network(
                              url,
                              height: 300,
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Text(
                          // products is out demo list
                          '${productItem.name}',
                          style: TextStyle(color: colorPrimaryDark),
                        ),
                      ),
                      Text(
                        "\$${productItem.price}",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                );
              });
        }
      },
    );
  }
}
