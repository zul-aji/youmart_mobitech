import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../constants.dart';
import '../../model/product_model.dart';
import '../../model/user_model.dart';
import 'components/customer/cart_screen.dart';
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

  ProductModel productModel = ProductModel();
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
          icon: const Icon(Icons.search_outlined, color: colorAccent),
          onPressed: () {},
        );
      }
    });

    final upperLeftIcon2 = LayoutBuilder(builder: (context, constraints) {
      if (loggedInUser.role == 'Admin') {
        return const Text(" ");
      } else {
        return IconButton(
          icon: const Icon(Icons.shopping_cart_rounded, color: colorAccent),
          onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CartScreen(),
              )),
        );
      }
    });

    final upperLeftIcon3 = LayoutBuilder(builder: (context, constraints) {
      if (loggedInUser.role == 'Guest') {
        return IconButton(
          icon: const Icon(Icons.logout_outlined, color: colorAccent),
          onPressed: () {
            deleteAccount();
          },
        );
      } else {
        return IconButton(
          icon: const Icon(Icons.person, color: colorAccent),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => UserProfile()));
          },
        );
      }
    });

    final headingTitle = Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
      child: LayoutBuilder(builder: (context, constraints) {
        if (loggedInUser.role == 'Admin') {
          return const Text(
            "Manage Items",
            style: TextStyle(
              fontSize: 30,
              color: colorPrimaryDark,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w700,
            ),
          );
        } else {
          return const Text(
            "Shop Items",
            style: TextStyle(
              fontSize: 30,
              color: colorPrimaryDark,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w700,
            ),
          );
        }
      }),
    );

    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: 'Poppins'),
        home: Scaffold(
            backgroundColor: colorBase,
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
    // calling our firestore
    // calling our user model
    // sending these values

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
