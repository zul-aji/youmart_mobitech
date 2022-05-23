import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:youmart_mobitech/screens/home/components/admin/add_item.dart';
import 'package:youmart_mobitech/screens/home/components/customer/cart_screen.dart';
import 'package:youmart_mobitech/screens/home/components/customer/itemlist.dart';

import '../../constants.dart';
import '../../model/local_product.dart';
import '../../model/product_model.dart';
import '../../model/user_model.dart';

import 'components/categories_home.dart';
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

    return MaterialApp(
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
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                headingTitle,
                const SizedBox(height: 18),
                const Categories(),
                adminOrCustomer(),
              ],
            )));
  }

  adminOrCustomer() {
    if (loggedInUser.role == 'Admin') {
      return Expanded(
        child: Padding(padding: const EdgeInsets.all(36.0), child: adminBody()),
      );
    } else {
      return Expanded(
          child: Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
              child: customerBody()));
    }
  }

  adminBody() {
    return AddItem();
  }

  customerBody() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("product")
                .doc(widget.pid)
                .collection("itemimage")
                .snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              return GridView.builder(
                  itemCount: snapshot.data!.docs.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 30,
                    childAspectRatio: 0.65,
                  ),
                  itemBuilder: (context, index) {
                    String url = snapshot.data!.docs[index]['downloadURL'];
                    return Image.network(
                      url,
                    );
                  });
            }),
      ),
    );
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
