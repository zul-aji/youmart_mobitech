import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';

import '../../../../constants.dart';
import '../../../../model/order_customer.dart';
import 'orders_details.dart';


final queryOrderModel = FirebaseFirestore.instance
    .collection('order')
    .orderBy('totalprice')
    .withConverter<OrderCustomer>(
  fromFirestore: (snapshot, _) =>
      OrderCustomer.fromJson(snapshot.data()!),
  toFirestore: (user, _) => user.toJson(),
);

class Orders extends StatefulWidget {
  const Orders({Key? key}) : super(key: key);

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  @override
  void initState() {
    super.initState();
  }

  // final firebaseDoc = await FirebaseFirestore.instance.collection('order').get();
  // List<String> imagesList = firebaseDoc.data()['images'];


  @override
  Widget build(BuildContext context) {
    return Container(child: buildList(context));
  }

  Widget buildList(BuildContext context) =>
      FirestoreQueryBuilder<OrderCustomer>(
        query: queryOrderModel,
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

                final orders = snapshot.docs[index].data();
                return Card(
                  elevation: 3.0,
                  child: ListTile(
                    tileColor: colorBase,
                    // leading:
                    // SizedBox(height: 50, width: 50, child: Image.network(orders.imageList[index])),
                    title: Text(
                      "${orders.firstName}'s order",
                      style: const TextStyle(
                        color: colorPrimaryDark,
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                      ),
                    ),
                    subtitle: Text(
                      "Order id: ${orders.oid}",
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
                            builder: (context) => OrdersDetails(
                              uid: orders.uid,
                              imageList: orders.imageList,
                              nameList: orders.nameList,
                              quantityList: orders.quantityList,
                              firstName: orders.firstName,
                              secondName: orders.secondName,
                              totalprice: orders.totalprice,
                              oid: orders.oid,
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        primary: colorPrimary,
                        onPrimary: colorBase,
                      ),
                      child: const Text('View Order Detail'),
                    ),
                  ),
                );
              },
            );
          }
        },
      );
}
