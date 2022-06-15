import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youmart_mobitech/constants.dart';
import 'package:youmart_mobitech/controllers/cart_controller.dart';

class CartTotal extends StatelessWidget {
  final CartController controller = Get.put(CartController());
  CartTotal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
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
              onPressed: () {
                // controller.postOrderToFirestore(
                //     controller.products.keys.toList()[CartProductCard]);
              },
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
        ),
      ),
    );
  }
}
