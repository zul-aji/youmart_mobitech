import 'package:flutter/material.dart';

import '../../../../constants.dart';

class CartCounter extends StatefulWidget {
  CartCounter({Key? key}) : super(key: key);

  @override
  State<CartCounter> createState() => _CartCounterState();
}

class _CartCounterState extends State<CartCounter> {
  int numOfItems = 0;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
            iconSize: 25,
            icon: const Icon(Icons.remove, color: colorAccent),
            onPressed: () {
              if (numOfItems > 0) {
                setState(() {
                  numOfItems--;
                });
              }
            },
          ),
          Text(
            // if our item is less  then 10 then  it shows 01 02 like that
            numOfItems.toString().padLeft(2, "0"),
            style: const TextStyle(
                color: colorPrimaryDark,
                fontSize: 20,
                fontWeight: FontWeight.w800),
          ),
          IconButton(
            iconSize: 25,
            icon: const Icon(Icons.add, color: colorAccent),
            onPressed: () {
              setState(() {
                numOfItems++;
              });
            },
          ),
        ],
      ),
    );
  }
}
