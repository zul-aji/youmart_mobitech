import 'dart:core';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../constants.dart';
import '../../../../controllers/cart_controller.dart';
import '../../../../controllers/product_controller.dart';

class BeverageList extends StatelessWidget {
  final productController = Get.put(ProductController());

  BeverageList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Flexible(
        child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 20,
              crossAxisSpacing: 20,
              childAspectRatio: 0.68,
            ),
            itemCount: productController.beverageProduct.length,
            itemBuilder: (BuildContext context, int index) {
              return CatalogProductCard(index: index);
            }),
      ),
    );
  }
}

final cartController = Get.put(CartController());

class CatalogProductCard extends StatelessWidget {
  final productController = Get.put(ProductController());
  final int index;

  CatalogProductCard({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productData = productController.beverageProduct[index];
    return Padding(
      padding: const EdgeInsets.only(right: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(13),
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
                  "${productData.price} RM",
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
    );
  }
}

stockCheck(productData) {
  var stock = int.parse(productData.stock);
  if (stock < 1) {
    return const Padding(
      padding: EdgeInsets.only(bottom: 14, top: 5),
      child: Text(
        "No Stock",
        style: TextStyle(
            fontSize: 20, color: colorAccent, fontWeight: FontWeight.bold),
      ),
    );
  } else {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Material(
        borderRadius: BorderRadius.circular(15),
        color: colorPrimaryDark,
        child: MaterialButton(
          padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          onPressed: () {
            cartController.addProduct(productData);
          },
          child: const Text(
            "Add to Cart",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 13, color: colorBase, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
