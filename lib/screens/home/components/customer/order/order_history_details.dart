import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uuid/uuid.dart';

import '../../../../../constants.dart';
import '../../../../../model/order_model.dart';

//Order History Details
class OrderHDetails extends StatefulWidget {
  final String uid, firstName, secondName, coid, totalprice;
  final Timestamp timestamp;
  final int index;
  final List<dynamic> nameList, imageList, quantityList, pidList;

  const OrderHDetails({
    Key? key,
    required this.uid,
    required this.firstName,
    required this.secondName,
    required this.coid,
    required this.index,
    required this.timestamp,
    required this.totalprice,
    required this.nameList,
    required this.imageList,
    required this.quantityList,
    required this.pidList,
  }) : super(key: key);

  @override
  State<OrderHDetails> createState() => _OrderHDetailsState();
}

class _OrderHDetailsState extends State<OrderHDetails> {
  List<String> productStock = [];

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < widget.pidList.length; i++) {
      FirebaseFirestore.instance
          .collection('product')
          .doc(widget.pidList[i])
          .get()
          .then((value) {
        var fields = value.data();
        setState(() {
          productStock.insert(i, fields!['stock']);
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    DateTime time = DateTime.fromMicrosecondsSinceEpoch(
        widget.timestamp.microsecondsSinceEpoch);
    String convertedDateTime =
        "${time.year.toString()}-${time.month.toString().padLeft(2, '0')}-${time.day.toString().padLeft(2, '0')}, ${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}";

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Order Details",
          style: TextStyle(
            fontSize: 25,
            color: colorPrimaryDark,
            fontWeight: FontWeight.w700,
          ),
        ),
        backgroundColor: colorWhite,
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
              "ID:",
              style: TextStyle(
                fontSize: 20,
                color: colorPrimaryDark,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 23),
            child: Text(
              widget.coid,
              style: const TextStyle(
                fontSize: 17,
                color: colorPrimaryDark,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(
            height: 2,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 23),
            child: Text(
              "Date:",
              style: TextStyle(
                fontSize: 20,
                color: colorPrimaryDark,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 23),
            child: Text(
              convertedDateTime,
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
                height: 480,
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: widget.nameList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 25.0,
                          vertical: 10,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Image.network(
                              widget.imageList[index],
                              height: 70,
                              width: 70,
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(
                                  widget.nameList[index],
                                  style: const TextStyle(
                                    fontSize: 20,
                                    color: colorPrimary,
                                    fontWeight: FontWeight.w500,
                                  ),
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
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Total: ${widget.totalprice} RM',
              style: const TextStyle(
                color: colorPrimaryDark,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            ElevatedButton(
              onPressed: () => stockCheck(),
              style: ElevatedButton.styleFrom(
                  primary: colorPrimary,
                  textStyle: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 20,
                      fontWeight: FontWeight.w600)),
              child: const Text("Reorder"),
            ),
          ],
        ),
      ),
    );
  }

  placeOrderToDB() {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    OrderModel orderModel = OrderModel();
    var uuid = const Uuid();

    // writing all the values
    orderModel.oid = uuid.v1();
    orderModel.uid = widget.uid;
    orderModel.firstName = widget.firstName;
    orderModel.secondName = widget.secondName;
    orderModel.totalprice = widget.totalprice;
    orderModel.nameList = widget.nameList;
    orderModel.imageList = widget.imageList;
    orderModel.quantityList = widget.quantityList;
    orderModel.pidList = widget.pidList;
    orderModel.timestamp = Timestamp.now();
    orderModel.status = "Pending";

    firebaseFirestore
        .collection("order")
        .doc(orderModel.oid)
        .set(orderModel.toFirestore());

    Navigator.of(context).pop();
    Fluttertoast.showToast(msg: "Order Placed");
  }

  stockCheck() {
    for (int i = 0; i < productStock.length; i++) {
      if (productStock[i] == '0') {
        return showDialog<String>(
          context: context,
          barrierDismissible: true,
          builder: (BuildContext context) => AlertDialog(
            title: const Text(
              'Stock Empty',
              style: TextStyle(
                fontSize: 25,
                color: colorAccent,
                fontWeight: FontWeight.w700,
              ),
            ),
            content: Text(
              '${widget.nameList[i]} is out of stock',
              style: const TextStyle(
                color: colorPrimaryDark,
                fontWeight: FontWeight.w500,
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, 'Cancel'),
                child: const Text(
                  'Cancel',
                  style: TextStyle(
                    color: colorAccent,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
            backgroundColor: colorWhite,
          ),
        );
      } else {
        return showDialog<String>(
          context: context,
          barrierDismissible: true,
          builder: (BuildContext context) => AlertDialog(
            title: const Text(
              'Reorder',
              style: TextStyle(
                fontSize: 25,
                color: colorPrimary,
                fontWeight: FontWeight.w700,
              ),
            ),
            content: const Text(
              'All your items are available. Do you want to reorder?',
              style: TextStyle(
                color: colorPrimaryDark,
                fontWeight: FontWeight.w500,
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, 'Cancel'),
                child: const Text(
                  'Cancel',
                  style: TextStyle(
                    color: colorUnpicked,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  placeOrderToDB();
                },
                child: const Text(
                  'Reorder',
                  style: TextStyle(
                    color: colorPrimary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
            backgroundColor: colorWhite,
          ),
        );
      }
    }
  }
}
