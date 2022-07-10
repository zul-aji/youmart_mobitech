import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../constants.dart';

class OrderCDetails extends StatefulWidget {
  final String oid, totalprice, status;
  final Timestamp timestamp;
  final int index;
  final List<dynamic> nameList, imageList, quantityList;

  OrderCDetails({
    Key? key,
    required this.oid,
    required this.index,
    required this.timestamp,
    required this.totalprice,
    required this.status,
    required this.nameList,
    required this.imageList,
    required this.quantityList,
  }) : super(key: key);

  @override
  State<OrderCDetails> createState() => _OrderCDetailsState();
}

class _OrderCDetailsState extends State<OrderCDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Order #${widget.index + 1}",
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
                fontWeight: FontWeight.w600,
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
            padding: const EdgeInsets.symmetric(horizontal: 0),
            child: SizedBox(
                height: 500,
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
                                    color: colorPrimaryDark,
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
}
