import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';

import '../../../../constants.dart';
import '../../../../model/order_admin.dart';


final queryOrderModel = FirebaseFirestore.instance
    .collection('order')
    .orderBy('totalprice')
    .withConverter<OrderAdmin>(
  fromFirestore: (snapshot, _) =>
      OrderAdmin.fromJson(snapshot.data()!),
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

  @override
  Widget build(BuildContext context) {
    return Container(child: buildList(context));
  }

  Widget buildList(BuildContext context) =>
      FirestoreQueryBuilder<OrderAdmin>(
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
                    leading: Image.network(orders.imageList![1]),
                    title: Text(
                      orders.nameList![1],
                      style: const TextStyle(
                        color: colorPrimaryDark,
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                      ),
                    ),
                    subtitle: Text(
                      orders.totalprice,
                      style: const TextStyle(
                        color: colorUnpicked,
                        fontWeight: FontWeight.w500,
                        fontSize: 13,
                      ),
                    ),
                    trailing: ElevatedButton(
                      onPressed: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => DetailsUpdate(
                        //       pid: orders.pid,
                        //       image: orders.image,
                        //       name: orders.name,
                        //       price: orders.price,
                        //       oid: orders.oid,
                        //     ),
                        //   ),
                        // );
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
