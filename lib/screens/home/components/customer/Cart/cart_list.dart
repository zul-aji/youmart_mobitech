import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../constants.dart';
import '../../../../../controllers/cart_controller.dart';
import '../../../../../model/product_download.dart';

class CartList extends StatelessWidget {
  final CartController controller = Get.put(CartController());
  CartList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SizedBox(
        child: ListView.builder(
            itemCount: controller.products.length,
            itemBuilder: (BuildContext context, int index) {
              return CartProductCard(
                controller: controller,
                product: controller.products.keys.toList()[index],
                quantity: controller.products.values.toList()[index],
                index: index,
              );
            }),
      ),
    );
  }
}

class CartProductCard extends StatelessWidget {
  final CartController controller;
  final ProductDownloadModel product;
  final int quantity;
  final int index;

  const CartProductCard({
    Key? key,
    required this.controller,
    required this.product,
    required this.quantity,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 10,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.network(
            product.image,
            height: 50,
            width: 50,
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: Text(
              product.name,
              style: const TextStyle(
                fontSize: 20,
                color: colorPrimary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              controller.removeProduct(product);
            },
            icon: const Icon(
              Icons.remove_circle,
              color: colorAccent,
            ),
          ),
          Text(
            '$quantity',
            style: const TextStyle(
              fontSize: 17,
              color: colorPrimaryDark,
              fontWeight: FontWeight.w600,
            ),
          ),
          IconButton(
            onPressed: () {
              controller.addProduct(product);
            },
            icon: const Icon(
              Icons.add_circle,
              color: colorPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
