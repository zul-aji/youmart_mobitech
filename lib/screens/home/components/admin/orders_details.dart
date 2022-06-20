import 'package:flutter/material.dart';

import '../../../../constants.dart';

class OrdersDetails extends StatefulWidget {
  final String firstName,
      secondName,
      oid,
      uid,
      totalprice;
  final List<dynamic>? nameList, imageList, quantityList;

  OrdersDetails({
    Key? key,
    required this.firstName,
    required this.secondName,
    required this.oid,
    required this.uid,
    required this.totalprice,
    required this.nameList,
    required this.imageList,
    required this.quantityList,
  }) : super(key: key);

  @override
  State<OrdersDetails> createState() => _OrdersDetailsState();
}

class _OrdersDetailsState extends State<OrdersDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "${widget.firstName} Order List",
          style: const TextStyle(
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
            print(widget.nameList);
            print(widget.nameList.length);
          },
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(
            height: 5,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 23),
            child: Text(
              "Order ID:",
              style: TextStyle(
                fontSize: 20,
                color: colorPrimaryDark,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 23),
            child: Text(
              widget.oid,
              style: const TextStyle(
                fontSize: 17,
                color: colorPrimaryDark,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 0),
            child: SizedBox(
                height: 539,
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: widget.nameList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20.0,
                          vertical: 10,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Image.network(
                              widget.imageList![index],
                              height: 70,
                              width: 70,
                            ),
                            Expanded(
                              child: Text(
                                widget.nameList[index],
                                style: const TextStyle(
                                  fontSize: 20,
                                  color: colorPrimaryDark,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Text(
                              "x${widget.quantityList[index]}",
                              style: const TextStyle(
                                fontSize: 20,
                                color: colorPrimaryDark,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      );
                    })),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Total Price: ${widget.totalprice} RM',
              style: const TextStyle(
                color: colorPrimaryDark,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // updateProduct() {
  //   // writing all the values
  //   orderModel.oid = widget.oid;
  //
  //   FirebaseFirestore.instance.collection("order").doc(widget.oid).update({
  //     'name': nameController.text,
  //     'price': priceController.text,
  //     'stock': stockController.text,
  //   });
  //
  //   Fluttertoast.showToast(msg: "Product Updated");
  //   Navigator.of(context).pop();
  // }
}
