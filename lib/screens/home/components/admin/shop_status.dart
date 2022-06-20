import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// final queryShopStatusModel = FirebaseFirestore.instance.collection('product')
//     .orderBy('name')
//     .withConverter<ShopStatus>(
//   fromFirestore: (snapshot, _) =>
//       ShopStatus.fromJson(snapshot.data()!),
//   toFirestore: (user, _) => user.toJson(),
// );

class ShopStatus extends StatefulWidget {

  @override
  State<ShopStatus> createState() => _ShopStatusDetails();

  // bool shopstatus;

  // ShopStatus({
  //   Key? key,
  //   required this.shopstatus,
  // }) : super(key: key);

  // ShopStatus.fromJson(Map<String, Object?> json)
  //     : this(
  //   shopstatus: json['shopstatus']! as bool,
  // );
  //
  // Map<String, Object?> toJson() => {
  //   'shopstatus': shopstatus,
  // };
}

class _ShopStatusDetails extends State<ShopStatus> {
  bool state = false;
  @override

  // FirestoreQueryBuilder<ProductDownloadModel>(
  // query: queryProductDownloadModel,
  // pageSize: 10,
  // builder: (context, snapshot, _) {
  // if (snapshot.isFetching) {
  // return const Center(child: CircularProgressIndicator());
  // } else if (snapshot.hasError) {
  // return Text('Something went wrong! ${snapshot.error}');
  // } else if (snapshot.hasData == false) {
  // return const Text('No item available');
  // } else {
  //
  Widget build(BuildContext context) {
    return new CupertinoPageScaffold(
      backgroundColor: Colors.black,
      child:Material(
        child: Container(
            margin: EdgeInsets.only(top:100, left: 30, right: 25),
            width: double.infinity,
            child:Column(
              children: [
                Container(
                  width: double.infinity,
                  child: Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width*0.25,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width*0.20,
                        child: CupertinoSwitch(
                          value:state,
                          onChanged: (value){
                            state = value;
                            setState(() {
                            },
                            );
                          },
                          thumbColor: CupertinoColors.tertiarySystemBackground,
                          activeColor: CupertinoColors.activeGreen,
                          trackColor: CupertinoColors.systemRed,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(state == true? "Shop is Open": "Shop is Closed",
                  style:TextStyle(
                      fontWeight: FontWeight.bold,
                      color: state == true? CupertinoColors.activeGreen
                          : CupertinoColors.systemRed
                  ),
                ),
              ],
            )
        ),
      ),
    );
  }
}