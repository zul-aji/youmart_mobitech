import 'package:flutter/material.dart';

import '../../../../constants.dart';

class ItemList extends StatefulWidget {
  // final Product product;

  const ItemList({
    Key? key,
    // this.product,
  }) : super(key: key);

  @override
  State<ItemList> createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  int numOfItems = 0;
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
              child: const Hero(
                tag: "pid",
                child: Text('image here'),
                // Image.network(src),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5, right: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Product name',
                  style: TextStyle(color: colorPrimaryDark),
                ),
                const Text(
                  "Price RM",
                  style: TextStyle(
                      color: colorPrimaryDark, fontWeight: FontWeight.w700),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5),
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
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
