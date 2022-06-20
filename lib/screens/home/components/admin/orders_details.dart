import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../constants.dart';
import '../../../../model/order_model.dart';

class OrdersDetails extends StatefulWidget {
  final String firstName, secondName, oid, uid, totalprice;
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
  OrderModel orderModel = OrderModel();

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
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 23),
            child: Text(
              widget.oid,
              style: const TextStyle(
                fontSize: 16,
                color: colorPrimaryDark,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0),
            child: SizedBox(
              height: 500,
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: widget.nameList?.length,
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
                            widget.nameList?[index],
                            style: const TextStyle(
                              fontSize: 20,
                              color: colorPrimaryDark,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Text(
                          "x${widget.quantityList?[index]}",
                          style: const TextStyle(
                            fontSize: 20,
                            color: colorPrimaryDark,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Text(
              'Total Price: ${widget.totalprice} RM',
              style: const TextStyle(
                fontSize: 24,
                color: colorPrimaryDark,
                fontWeight: FontWeight.w700,
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: 40,
              child: ElevatedButton(
                onPressed: acceptOrder,
                style: ElevatedButton.styleFrom(
                  primary: colorBase,
                  onPrimary: colorBase,
                ),
                child: const Text(
                  'Accept',
                  style: TextStyle(
                    fontSize: 15,
                    color: colorPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 40,
              child: ElevatedButton(
                onPressed: rejectOrder,
                style: ElevatedButton.styleFrom(
                  primary: colorAccent,
                  onPrimary: colorAccent,
                ),
                child: const Text(
                  'Reject',
                  style: TextStyle(
                    fontSize: 15,
                    color: colorBase,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 40,
              child: ElevatedButton(
                onPressed: completeOrder,
                style: ElevatedButton.styleFrom(
                  primary: colorPrimary,
                  onPrimary: colorPrimary,
                ),
                child: const Text(
                  'Completed',
                  style: TextStyle(
                    fontSize: 15,
                    color: colorWhite,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  acceptOrder() {
    // writing all the values
    FirebaseFirestore.instance.collection("order").doc(widget.oid).update({
      'status': 'Preparing',
    });

    Fluttertoast.showToast(msg: "Product status Updated");
  }

  rejectOrder() {
    // writing all the values
    FirebaseFirestore.instance.collection("order").doc(widget.oid).update({
      'status': 'Rejected',
    });

    Fluttertoast.showToast(msg: "Product status Updated");
  }

  completeOrder() {
    // writing all the values
    FirebaseFirestore.instance.collection("order").doc(widget.oid).update({
      'status': 'Completed',
    });

    Fluttertoast.showToast(msg: "Product status Updated");
  }
}
