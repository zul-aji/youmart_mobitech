import 'package:flutter/material.dart';
import 'itemcategory.dart';
import 'package:youmart_mobitech/model/product_model.dart';

class ItemList extends StatefulWidget {
  ItemList({Key? key}) : super(key: key);

  @override
  State<ItemList> createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        // itemCount: products.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
          childAspectRatio: 0.75,
        ),
        itemBuilder: (context, index) {
          return ItemCategory(
              // product: products[index],
              // press: () => Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //       builder: (context) => DetailsScreen(
              //         product: products[index],
              //       ),
              //     )),
              );
        });
  }
}
