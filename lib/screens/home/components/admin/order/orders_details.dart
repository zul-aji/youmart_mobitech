import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uuid/uuid.dart';
import 'package:youmart_mobitech/model/product_upload.dart';

import '../../../../../constants.dart';
import '../../../../../model/complete_order_model.dart';
import '../../../../../model/order_model.dart';

class OrdersDetails extends StatefulWidget {
  final String firstName, secondName, oid, uid, totalprice;
  final Timestamp timestamp;
  final List<dynamic>? nameList, imageList, quantityList, pidList;

  OrdersDetails({
    Key? key,
    required this.firstName,
    required this.secondName,
    required this.oid,
    required this.uid,
    required this.timestamp,
    required this.totalprice,
    required this.nameList,
    required this.imageList,
    required this.quantityList,
    required this.pidList,
  }) : super(key: key);

  @override
  State<OrdersDetails> createState() => _OrdersDetailsState();
}

class _OrdersDetailsState extends State<OrdersDetails> {
  OrderModel orderModel = OrderModel();

  List<String> initialStock = [];

  @override
  void initState() {
    for (int i = 0; i < widget.quantityList!.length; i++) {
      FirebaseFirestore.instance
          .collection('product')
          .doc(widget.pidList![i])
          .get()
          .then((value) {
        var fields = value.data();

        setState(() {
          initialStock.add(fields!['stock']);
        });
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DateTime time = DateTime.fromMicrosecondsSinceEpoch(
        widget.timestamp.microsecondsSinceEpoch);
    String convertedDateTime =
        "${time.year.toString()}-${time.month.toString().padLeft(2, '0')}-${time.day.toString().padLeft(2, '0')}, ${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}";

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
          const SizedBox(
            height: 2,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 23),
            child: Text(
              "Date: $convertedDateTime",
              style: const TextStyle(
                fontSize: 17,
                color: colorPrimaryDark,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0),
            child: SizedBox(
              height: 470,
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: widget.nameList?.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24.0,
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
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              widget.nameList?[index],
                              style: const TextStyle(
                                fontSize: 20,
                                color: colorPrimaryDark,
                                fontWeight: FontWeight.w500,
                              ),
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
                onPressed: rejectOrder,
                style: ElevatedButton.styleFrom(
                  foregroundColor: colorAccent,
                  backgroundColor: colorAccent,
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
                onPressed: acceptOrder,
                style: ElevatedButton.styleFrom(
                  foregroundColor: colorBase,
                  backgroundColor: colorBase,
                ),
                child: const Text(
                  'Ready',
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
                onPressed: completeOrder,
                style: ElevatedButton.styleFrom(
                  foregroundColor: colorPrimary,
                  backgroundColor: colorPrimary,
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
    FirebaseFirestore.instance.collection("order").doc(widget.oid).update({
      'status': 'Ready',
    });

    Fluttertoast.showToast(msg: "Order status Updated");
  }

  rejectOrder() {
    // FirebaseFirestore.instance.collection("order").doc(widget.oid).update({
    //   'status': 'Rejected',
    // });

    // Fluttertoast.showToast(msg: "Order status Updated");
    updateStock();
  }

  completeOrder() {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    CompleteOrderModel completeOrderModel = CompleteOrderModel();
    var uuid = const Uuid();

    // writing all the values
    completeOrderModel.coid = uuid.v1();
    completeOrderModel.uid = widget.uid;
    completeOrderModel.firstName = widget.firstName;
    completeOrderModel.secondName = widget.secondName;
    completeOrderModel.totalprice = widget.totalprice;
    completeOrderModel.nameList = widget.nameList;
    completeOrderModel.imageList = widget.imageList;
    completeOrderModel.quantityList = widget.quantityList;
    completeOrderModel.pidList = widget.pidList;
    completeOrderModel.timestamp = Timestamp.now();

    firebaseFirestore
        .collection("complete_order")
        .doc(completeOrderModel.coid)
        .set(completeOrderModel.toFirestore());

    // updateStock();
    firebaseFirestore.collection("order").doc(widget.oid).delete();
    Fluttertoast.showToast(msg: "Order Completed");
    Navigator.of(context).pop();
  }

  updateStock() {
    for (int i = 0; i < widget.quantityList!.length; i++) {
      var stockBefore = int.parse(initialStock[i]);
      var stockTaken = widget.quantityList![i];
      print(widget.nameList![i]);
      // print(widget.pidList![i]);
      print(initialStock);
      // print(stockTaken);
      String newStock = (stockBefore - stockTaken).toString();
      // print(newStock);

      // FirebaseFirestore.instance
      //     .collection("product")
      //     .doc(widget.pidList![i])
      //     .update({
      //   'stock': newStock,
      // });
    }
  }
}
