import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:youmart_mobitech/model/order_customer.dart';
import 'package:youmart_mobitech/screens/home/components/customer/order/orderc_details.dart';

import '../../../../../constants.dart';

class OrderList extends StatefulWidget {
  final String uid;
  const OrderList({
    Key? key,
    required this.uid,
  }) : super(key: key);

  @override
  State<OrderList> createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(child: buildList(context));
  }

  Widget buildList(BuildContext context) {
    final queryProductDownloadModel = FirebaseFirestore.instance
        .collection('order')
        .where("uid", isEqualTo: widget.uid)
        .withConverter<OrderCustomer>(
          fromFirestore: (snapshot, _) =>
              OrderCustomer.fromJson(snapshot.data()!),
          toFirestore: (user, _) => user.toJson(),
        );

    return FirestoreQueryBuilder<OrderCustomer>(
      query: queryProductDownloadModel,
      pageSize: 10,
      builder: (context, snapshot, _) {
        if (snapshot.isFetching) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text('Something went wrong! ${snapshot.error}');
        } else if (snapshot.hasData == false) {
          return const Text('No item available');
        } else {
          return ListView.builder(
            itemCount: snapshot.docs.length + 1,
            itemBuilder: (context, index) {
              final hasEndReached = snapshot.hasMore &&
                  index == snapshot.docs.length &&
                  !snapshot.isFetchingMore;

              if (hasEndReached) {
                snapshot.fetchMore();
              }

              if (index == snapshot.docs.length) {
                return Center(
                  child: snapshot.isFetchingMore
                      ? const CircularProgressIndicator()
                      : Container(),
                );
              }

              final orderData = snapshot.docs[index].data();
              return Card(
                elevation: 3.0,
                child: ListTile(
                  tileColor: colorBase,
                  title: Text(
                    "Order #${index + 1}",
                    style: const TextStyle(
                      color: colorPrimaryDark,
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                    ),
                  ),
                  subtitle: Text(
                    orderData.oid,
                    style: const TextStyle(
                      color: colorUnpicked,
                      fontWeight: FontWeight.w500,
                      fontSize: 13,
                    ),
                  ),
                  trailing: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OrderCDetails(
                            oid: orderData.oid,
                            firstName: orderData.firstName,
                            secondName: orderData.secondName,
                            totalprice: orderData.totalprice,
                            nameList: orderData.nameList,
                            imageList: orderData.imageList,
                            quantityList: orderData.quantityList,
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      primary: colorPrimary,
                      onPrimary: colorBase,
                    ),
                    child: const Text('Order Details'),
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }
}
