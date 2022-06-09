import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youmart_mobitech/controllers/cart_controller.dart';
import 'package:youmart_mobitech/model/local_product.dart';
import 'package:youmart_mobitech/screens/home/components/customer/cart_total.dart';

import '../../../../constants.dart';

class CartScreen extends StatelessWidget {
  final CartController controller = Get.find();

  CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          title: const Text(
            "Your Cart",
            style: TextStyle(
              fontSize: 25,
              color: colorPrimaryDark,
              fontWeight: FontWeight.w700,
            ),
          ),
          backgroundColor: const Color(0xFFFFFFFF),
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: colorAccent),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: ListView.builder(
            itemCount: controller.products.length,
            itemBuilder: (BuildContext context, int index) {
              return CartProductCard(
                controller: controller,
                product: controller.products.keys.toList()[index],
                quantity: controller.products.values.toList()[index],
                index: index,
              );
            }),
        bottomNavigationBar: Container(
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (controller.total == '0')
                  const Text(
                    '0 RM',
                    style: TextStyle(
                      color: colorPrimaryDark,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                else
                  Text(
                    '${controller.total} RM',
                    style: const TextStyle(
                      color: colorPrimaryDark,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                      primary: colorPrimary,
                      onPrimary: colorBase,
                      textStyle: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 20,
                          fontWeight: FontWeight.w600)),
                  child: const Text('Order Item'),
                ),
              ],
            )),
      ),
    );
  }
}

class CartProductCard extends StatelessWidget {
  final CartController controller;
  final LocalProduct product;
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
          Image.asset(
            product.image,
            height: 50,
            width: 50,
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: Text(
              product.title,
              style: const TextStyle(
                fontSize: 20,
                color: colorPrimaryDark,
                fontWeight: FontWeight.w700,
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
