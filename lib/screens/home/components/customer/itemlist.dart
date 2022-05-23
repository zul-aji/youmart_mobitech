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
