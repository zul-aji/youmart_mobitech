import 'package:flutter/material.dart';

class OrderCDetails extends StatefulWidget {
  final String oid, firstName, secondName, totalprice;
  final List<dynamic> nameList, imageList, quantityList;

  OrderCDetails({
    Key? key,
    required this.oid,
    required this.firstName,
    required this.secondName,
    required this.totalprice,
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
    return Container();
  }
}
