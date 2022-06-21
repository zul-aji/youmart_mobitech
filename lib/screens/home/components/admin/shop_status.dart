import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../constants.dart';

class ShopStatus extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('shop_status').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView(
            children: snapshot.data!.docs.map((document) {
              bool state = document['status'];
              return Container(
                child: Center(child:
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const SizedBox(height: 4),
                    CupertinoSwitch(
                      value: state,
                      onChanged: (value) {
                        state = value;
                        if (state == true) {
                          openShop();
                        } else {
                          closeShop();
                        }
                      },
                      thumbColor: colorBase,
                      activeColor: colorPrimary,
                      trackColor: colorAccent,
                    ),
                    Text(
                      state == true ? "Shop Open" : "Shop Closed",
                      style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: state == true ? colorPrimary : colorAccent),
                    )
                  ],
                ),
              )
              );
            }).toList(),
          );
        },
      ),
    );
  }
  openShop() {
    FirebaseFirestore.instance
        .collection("shop_status")
        .doc("statID")
        .update({'status': true});

    Fluttertoast.showToast(msg: "Shop Open");
  }

  closeShop() {
    FirebaseFirestore.instance
        .collection("shop_status")
        .doc("statID")
        .update({'status': false});

    Fluttertoast.showToast(msg: "Shop Close");
  }
}