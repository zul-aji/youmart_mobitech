import 'package:flutter/material.dart';

import '../../../../constants.dart';

class CartScreen extends StatefulWidget {
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: 'Poppins'),
        home: Scaffold(
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
          body: Column(
            children: [
              // ListView.builder(
              //     itemCount: _cart.length,
              //     itemBuilder: (BuildContext context, int index) {
              //       var item = _cart[index];
              //       return Padding(
              //         padding: const EdgeInsets.symmetric(
              //           horizontal: 20.0,
              //           vertical: 10,
              //         ),
              //         child: Row(
              //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //           children: [
              //             Image.network(item.image),
              //             SizedBox(
              //               width: 20,
              //             ),
              //             Expanded(
              //               child: Text(item.name),
              //             ),
              //             IconButton(
              //               onPressed: () {
              //                 // if (item.quantity > 1)
              //                 // item.quantity--;
              //               },
              //               icon: Icon(Icons.remove_circle),
              //             ),
              //             Text('${item.quantity}'),
              //             IconButton(
              //               onPressed: () {
              //                 // item.quantity++;
              //               },
              //               icon: Icon(Icons.add_circle),
              //             ),
              //           ],
              //         ),
              //       );
              //     }),
            ],
          ),
        ));
  }
}
