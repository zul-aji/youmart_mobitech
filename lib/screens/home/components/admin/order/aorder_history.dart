import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';

import '../../../../../constants.dart';
import '../../../../../model/complete_order_customer.dart';
import 'history_details.dart';

final queryHistoryOrderModel = FirebaseFirestore.instance
    .collection('complete_order')
    .orderBy('timestamp', descending: true)
    .withConverter<CompleteOrderCustomer>(
      fromFirestore: (snapshot, _) =>
          CompleteOrderCustomer.fromJson(snapshot.data()!),
      toFirestore: (user, _) => user.toJson(),
    );

class AdmminOrderHistory extends StatefulWidget {
  const AdmminOrderHistory({Key? key}) : super(key: key);

  @override
  State<AdmminOrderHistory> createState() => _AdmminOrderHistoryState();
}

class _AdmminOrderHistoryState extends State<AdmminOrderHistory> {
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
      FirestoreQueryBuilder<CompleteOrderCustomer>(
        query: queryHistoryOrderModel,
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
                    title: Text(
                      "${orders.firstName}'s order",
                      style: const TextStyle(
                        color: colorPrimaryDark,
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                      ),
                    ),
                    subtitle: Text(
                      orders.coid,
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
                            builder: (context) => OrderHistoryDetails(
                              uid: orders.uid,
                              imageList: orders.imageList,
                              nameList: orders.nameList,
                              quantityList: orders.quantityList,
                              timestamp: orders.timestamp,
                              firstName: orders.firstName,
                              secondName: orders.secondName,
                              totalprice: orders.totalprice,
                              coid: orders.coid,
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        onPrimary: colorBase,
                        primary: colorPrimary,
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
