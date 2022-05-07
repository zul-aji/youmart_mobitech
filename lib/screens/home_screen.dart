import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:youmart_mobitech/model/user_model.dart';
import 'package:youmart_mobitech/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:youmart_mobitech/screens/userprofile_screen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

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
      this.loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final welcomeName =
        Container(child: LayoutBuilder(builder: (context, constraints) {
      if (loggedInUser.role == 'Admin') {
        return Text("Hello, Admin ${loggedInUser.firstName}");
      } else {
        return Text("Hello, ${loggedInUser.firstName}");
      }
    }));

    final upperLeftIcon1 =
        Container(child: LayoutBuilder(builder: (context, constraints) {
      if (loggedInUser.role == 'Admin') {
        return Text(" ");
      } else {
        return IconButton(
          icon: Icon(Icons.shopping_cart_rounded, color: Colors.white),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => UserProfile()));
          },
        );
      }
    }));

    final upperLeftIcon2 =
        Container(child: LayoutBuilder(builder: (context, constraints) {
      if (loggedInUser.role == 'Guest') {
        return Text(" ");
      } else {
        return IconButton(
          icon: Icon(Icons.person, color: Colors.white),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => UserProfile()));
          },
        );
      }
    }));

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            appBar: AppBar(
              title: welcomeName,
              actions: [
                upperLeftIcon1,
                upperLeftIcon2,
              ],
            ),
            body: homeOrAdmin()));
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

  homeOrAdmin() {
    if (loggedInUser.role == 'Admin') {
      return Padding(
        padding: EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Admin of',
              style: TextStyle(fontSize: 30),
            ),
            SizedBox(height: 20),
            SizedBox(
                height: 150,
                child: Image.asset(
                  "assets/Logo.png",
                  fit: BoxFit.contain,
                )),
            SizedBox(height: 20),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(minimumSize: Size.fromHeight(50)),
              icon: Icon(Icons.logout, size: 30),
              label: Text(
                'Sign Out',
                style: TextStyle(fontSize: 24),
              ),
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
            ),
          ],
        ),
      );
    } else {
      return Padding(
        padding: EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome to',
              style: TextStyle(fontSize: 30),
            ),
            SizedBox(height: 20),
            SizedBox(
                height: 150,
                child: Image.asset(
                  "assets/Logo.png",
                  fit: BoxFit.contain,
                )),
            SizedBox(height: 20),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(minimumSize: Size.fromHeight(50)),
              icon: Icon(Icons.logout, size: 30),
              label: Text(
                'Sign Out',
                style: TextStyle(fontSize: 24),
              ),
              onPressed: () {
                if (loggedInUser.role == 'Guest') {
                  deleteAccount();
                } else {
                  FirebaseAuth.instance.signOut();
                }
              },
            ),
          ],
        ),
      );
    }
  }
}
