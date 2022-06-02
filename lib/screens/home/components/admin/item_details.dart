import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../constants.dart';
import '../../../../model/product_download.dart';

final queryProductDownloadModel = FirebaseFirestore.instance
    .collection('product')
    .orderBy('name')
    .withConverter<ProductDownloadModel>(
      fromFirestore: (snapshot, _) =>
          ProductDownloadModel.fromJson(snapshot.data()!),
      toFirestore: (user, _) => user.toJson(),
    );

class ItemDetails extends StatefulWidget {
  ItemDetails(String pid, {Key? key}) : super(key: key);

  @override
  State<ItemDetails> createState() => _ItemDetailsState();
}

class _ItemDetailsState extends State<ItemDetails> {
  //Controllers
  final firstNameEditingController = TextEditingController();
  final secondNameEditingController = TextEditingController();

  // @override
  // void initState() {
  //   super.initState();
  //   FirebaseFirestore.instance
  //       .collection("users")
  //       .doc(user!.uid)
  //       .get()
  //       .then((value) {
  //     this.loggedInUser = UserModel.fromMap(value.data());
  //     setState(() {});
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    // first name field
    final firstNameField = TextFormField(
      autofocus: false,
      controller: firstNameEditingController,
      keyboardType: TextInputType.name,
      validator: (value) {
        RegExp regex = RegExp(r'^.{3,}$');
        if (value!.isEmpty) {
          return ("First Name cannot be Empty");
        }
        if (!regex.hasMatch(value)) {
          return ("Enter Valid name(Min. 3 Character)");
        }
        return null;
      },
      onSaved: (value) {
        firstNameEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.person),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "loggedInUser.firstName",
        border: OutlineInputBorder(
          borderSide: const BorderSide(width: 3, color: colorPrimary),
          borderRadius: BorderRadius.circular(15),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 3, color: colorPrimary),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );

    // second name field
    final secondNameField = TextFormField(
      autofocus: false,
      controller: secondNameEditingController,
      keyboardType: TextInputType.name,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Second Name cannot be Empty");
        }
        return null;
      },
      onSaved: (value) {
        secondNameEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.person),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "loggedInUser.secondName",
        border: OutlineInputBorder(
          borderSide: const BorderSide(width: 3, color: colorPrimary),
          borderRadius: BorderRadius.circular(15),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 3, color: colorPrimary),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );

    //update button
    final updateButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: colorPrimaryDark,
      child: MaterialButton(
        padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {},
        child: const Text(
          "Update Profile",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 18, color: colorBase, fontWeight: FontWeight.bold),
        ),
      ),
    );

    //sign out button
    final signOutButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: colorBase,
      child: MaterialButton(
        padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {},
        child: const Text(
          "Sign Out",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 18, color: colorAccent, fontWeight: FontWeight.bold),
        ),
      ),
    );

    //delete button
    final deleteButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: colorAccent,
      child: MaterialButton(
        padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {},
        child: const Text(
          "Delete Account",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 18, color: colorBase, fontWeight: FontWeight.bold),
        ),
      ),
    );

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: 'Poppins'),
        home: Scaffold(
          appBar: AppBar(
            backgroundColor: const Color(0xFFFFFFFF),
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: colorAccent),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          body: Center(
              child: SingleChildScrollView(
            child: Container(
                color: const Color(0xFFFFFFFF),
                child: Padding(
                  padding: const EdgeInsets.all(36.0),
                  child: Form(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                            height: 100,
                            child: Image.asset(
                              "images/Logo/Profile.png",
                              fit: BoxFit.contain,
                            )),
                        const SizedBox(height: 3),
                        Text(
                          'loggedInUser.email',
                          style: const TextStyle(
                              fontSize: 18, color: colorPrimary),
                        ),
                        const SizedBox(height: 20),
                        firstNameField,
                        const SizedBox(height: 20),
                        secondNameField,
                        const SizedBox(height: 15),
                        updateButton,
                        const SizedBox(height: 15),
                        signOutButton,
                        const SizedBox(height: 15),
                        deleteButton,
                        const SizedBox(height: 45),
                      ],
                    ),
                  ),
                )),
          )),
        ));
  }
}
