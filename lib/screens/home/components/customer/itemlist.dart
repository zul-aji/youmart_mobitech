import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:youmart_mobitech/constants.dart';
import 'package:youmart_mobitech/model/product_model.dart';
import 'package:youmart_mobitech/screens/home/components/customer/details_screen.dart';
import 'itemlist.dart';
import 'package:youmart_mobitech/api/firebase_api.dart';

class ItemList extends StatefulWidget {
  // final Product product;
  // final Function press;

  const ItemList({
    Key? key,
    // this.product,
    // this.press,
  }) : super(key: key);

  @override
  State<ItemList> createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // onTap: press,
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
              child: const Hero(
                tag: "pid",
                child: Text('image here'),
                // Image.network(src),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8, top: 15),
            child: Column(
              children: const [
                Text(
                  'Product name',
                  style: TextStyle(color: colorPrimaryDark),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 39.0, bottom: 10),
                  child: Text(
                    "Price RM",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
