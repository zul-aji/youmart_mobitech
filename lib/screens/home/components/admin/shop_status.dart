import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../constants.dart';

class ShopStatus extends StatelessWidget {
  const ShopStatus({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('shop_status').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        return ListView(
          children: snapshot.data!.docs.map((document) {
            bool state = document['status'];
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 180),
                  SizedBox(
                    height: 120,
                    width: 180,
                    child: Transform.scale(
                      transformHitTests: true,
                      scale: 3.5,
                      child: CupertinoSwitch(
                        value: state,
                        onChanged: (value) {
                          state = value;
                          if (state == true) {
                            openShop();
                          } else {
                            closeShop();
                          }
                        },
                        thumbColor: colorWhite,
                        activeColor: colorPrimary,
                        trackColor: colorAccent,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    state == true ? "Shop Open" : "Shop Closed",
                    style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.w700,
                        color: state == true ? colorPrimary : colorAccent),
                  )
                ],
              ),
            );
          }).toList(),
        );
      },
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
