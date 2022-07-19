import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';

import '../../../../../constants.dart';
import '../../../../../model/complete_order_customer.dart';
import '../../../../../model/user_model.dart';
import 'order_history_details.dart';

class OrderHistoryList extends StatefulWidget {
  final String uid;
  const OrderHistoryList({
    Key? key,
    required this.uid,
  }) : super(key: key);

  @override
  State<OrderHistoryList> createState() => _OrderHistoryListState();
}

class _OrderHistoryListState extends State<OrderHistoryList> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(child: buildList(context));
  }

  Widget buildList(BuildContext context) {
    final queryOrderHistoryList = FirebaseFirestore.instance
        .collection('complete_order')
        .where("uid", isEqualTo: widget.uid)
        .withConverter<CompleteOrderCustomer>(
          fromFirestore: (snapshot, _) =>
              CompleteOrderCustomer.fromJson(snapshot.data()!),
          toFirestore: (user, _) => user.toJson(),
        );

    return FirestoreQueryBuilder<CompleteOrderCustomer>(
      query: queryOrderHistoryList,
      pageSize: 10,
      builder: (context, snapshot, _) {
        if (snapshot.isFetching) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text('Something went wrong! ${snapshot.error}');
        } else if (snapshot.hasData == false) {
          return const Text('No item available');
        } else {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: ListView.builder(
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
                DateTime time = DateTime.fromMicrosecondsSinceEpoch(
                    orderData.timestamp.microsecondsSinceEpoch);
                String convertedDateTime =
                    "${time.year.toString()}-${time.month.toString().padLeft(2, '0')}-${time.day.toString().padLeft(2, '0')}, ${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}";
                return Card(
                  elevation: 3.0,
                  child: ListTile(
                    tileColor: colorWhite,
                    title: Text(
                      convertedDateTime,
                      style: const TextStyle(
                        color: colorPrimaryDark,
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                      ),
                    ),
                    subtitle: Text(
                      orderData.coid,
                      style: const TextStyle(
                        color: colorUnpicked,
                        fontWeight: FontWeight.w500,
                        fontSize: 11,
                      ),
                    ),
                    trailing: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => OrderHDetails(
                              uid: loggedInUser.uid ?? "",
                              firstName: loggedInUser.firstName ?? "",
                              secondName: loggedInUser.secondName ?? "",
                              coid: orderData.coid,
                              index: index,
                              totalprice: orderData.totalprice,
                              timestamp: orderData.timestamp,
                              nameList: orderData.nameList,
                              imageList: orderData.imageList,
                              quantityList: orderData.quantityList,
                              pidList: orderData.pidList,
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        primary: colorPrimary,
                      ),
                      child: const Text('Order Details'),
                    ),
                  ),
                );
              },
            ),
          );
        }
      },
    );
  }
}
