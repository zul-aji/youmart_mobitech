import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:youmart_mobitech/screens/home/components/customer/order/order_screen.dart';

import '../../constants.dart';
import '../../model/user_model.dart';
import 'components/customer/Cart/cart_screen.dart';
import 'components/home_body.dart';
import 'userprofile_screen.dart';

class HomeScreen extends StatefulWidget {
  final String? pid;
  const HomeScreen({Key? key, this.pid}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
    final welcomeName = Container(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: LayoutBuilder(builder: (context, constraints) {
        if (loggedInUser.role == 'Admin') {
          return Text("Hello, Admin ${loggedInUser.firstName}",
              style: const TextStyle(
                  color: colorPrimary, fontWeight: FontWeight.bold));
        } else {
          return Text("Hello, ${loggedInUser.firstName}",
              style: const TextStyle(
                  color: colorPrimary, fontWeight: FontWeight.bold));
        }
      }),
    );

    final upperLeftIcon1 = LayoutBuilder(builder: (context, constraints) {
      if (loggedInUser.role == 'Admin') {
        return const Text(" ");
      } else {
        return IconButton(
          icon: const Icon(Icons.list_alt_rounded, color: colorAccent),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const OrderScreen()));
          },
        );
      }
    });

    final upperLeftIcon2 = LayoutBuilder(builder: (context, constraints) {
      if (loggedInUser.role == 'Admin') {
        return const Text(" ");
      } else {
        return IconButton(
          icon: const Icon(Icons.shopping_cart_rounded, color: colorAccent),
          onPressed: () => Get.to(() => const CartScreen()),
        );
      }
    });

    final upperLeftIcon3 = LayoutBuilder(builder: (context, constraints) {
      if (loggedInUser.role == 'Guest') {
        return IconButton(
          icon: const Icon(Icons.logout_outlined, color: colorAccent),
          onPressed: () => showDialog<String>(
            context: context,
            barrierDismissible: true,
            builder: (BuildContext context) => AlertDialog(
              title: const Text(
                'Guest Sign out',
                style: TextStyle(
                  fontSize: 25,
                  color: colorAccent,
                  fontWeight: FontWeight.w700,
                ),
              ),
              content: const Text(
                "If you sign out, you won't be able to see your order details anymore",
                style: TextStyle(
                  color: colorPrimaryDark,
                  fontWeight: FontWeight.w500,
                ),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, 'Cancel'),
                  child: const Text(
                    'Cancel',
                    style: TextStyle(
                      color: colorPrimary,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    deleteAccount();
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    'Sign Out',
                    style: TextStyle(
                      color: colorAccent,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
              backgroundColor: colorBase,
            ),
          ),
        );
      } else {
        return IconButton(
          icon: const Icon(Icons.person, color: colorAccent),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const UserProfile()));
          },
        );
      }
    });

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: 'Poppins'),
        home: Scaffold(
            backgroundColor: colorWhite,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: welcomeName,
              actions: [
                upperLeftIcon1,
                upperLeftIcon2,
                upperLeftIcon3,
              ],
            ),
            body: const HomeBody()));
  }

  deleteAccount() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = FirebaseAuth.instance.currentUser;

    UserModel userModel = UserModel();

    // writing all the values
    userModel.uid = user?.uid;

    await firebaseFirestore.collection("users").doc(user?.uid).delete();
    user?.delete();
    Fluttertoast.showToast(msg: "Signed Out");

    FirebaseAuth.instance.signOut();
  }
}
