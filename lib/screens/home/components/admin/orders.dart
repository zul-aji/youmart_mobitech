import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uuid/uuid.dart';

import '../../../../constants.dart';
import '../../../../model/order_model.dart';

class Orders extends StatefulWidget {
  Orders({Key? key}) : super(key: key);

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  @override
  void initState() {
    currentItem = customerCategories[0];
    super.initState();
  }

  // Form Key
  final _formKey = GlobalKey<FormState>();

  String currentItem = 'test';

  List<String> itemlist = [];

  //Controllers
  final totalPriceController = TextEditingController();
  final secondNameEditingController = TextEditingController();

  // string for displaying the error Message
  String? errorMessage;

  @override
  Widget build(BuildContext context) {
    final totalPriceField = TextFormField(
      autofocus: false,
      controller: totalPriceController,
      keyboardType: TextInputType.name,
      validator: (value) {
        RegExp regex = RegExp(r'^.{5,}$');
        if (value!.isEmpty) {
          return ("Name cannot be Empty");
        }
        if (!regex.hasMatch(value)) {
          return ("Valid Input(Min. 5 Char)");
        }
        return null;
      },
      onSaved: (value) {
        totalPriceController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Item Name",
        border: OutlineInputBorder(
          borderSide: const BorderSide(width: 3, color: colorPrimaryDark),
          borderRadius: BorderRadius.circular(15),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 3, color: colorPrimaryDark),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );

    //addOrderButton button
    final addOrderButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: colorPrimaryDark,
      child: MaterialButton(
        padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: postDetailsToFirestore,
        child: const Text(
          "Add Order",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 20, color: colorBase, fontWeight: FontWeight.bold),
        ),
      ),
    );

    final addItemButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: colorPrimaryDark,
      child: MaterialButton(
        padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: addItem,
        child: const Text(
          "Add Item",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 20, color: colorBase, fontWeight: FontWeight.bold),
        ),
      ),
    );

    final itemCategoryList = DropdownButtonFormField(
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 3, color: colorPrimaryDark),
            borderRadius: BorderRadius.circular(15),
          ),
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: colorPrimaryDark, width: 3),
            borderRadius: BorderRadius.circular(15),
          ),
          filled: true,
        ),
        validator: (value) => value == null ? "Choose Category" : null,
        dropdownColor: colorBase,
        value: currentItem,
        onChanged: (String? newValue) {
          setState(() {
            currentItem = newValue!;
          });
        },
        items: dropdownItems);

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: 'Poppins'),
        home: Scaffold(
          backgroundColor: const Color(0xFFFFFFFF),
          body: Center(
              child: SingleChildScrollView(
            child: Container(
                color: const Color(0xFFFFFFFF),
                child: Padding(
                  padding: const EdgeInsets.all(36.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        const SizedBox(height: 10),
                        itemCategoryList,
                        const SizedBox(height: 20),
                        addItemButton,
                        const SizedBox(height: 20),
                        totalPriceField,
                        const SizedBox(height: 20),
                        addOrderButton,
                        const SizedBox(height: 15),
                      ],
                    ),
                  ),
                )),
          )),
        ));
  }

  @override
  // Widget build(BuildContext context) {
  //   return SingleChildScrollView(
  //     child: Column(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       crossAxisAlignment: CrossAxisAlignment.center,
  //       children: <Widget>[
  //         const Text(
  //           'Order Details',
  //           style: TextStyle(
  //             fontSize: 25,
  //             color: colorPrimaryDark,
  //             fontFamily: 'Poppins',
  //            eight: FontWeight.w700,
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  addItem() async {
    itemlist.add(currentItem);
  }

  postDetailsToFirestore() async {
    // calling our firestore
    // calling our user model
    // sending these values

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    OrderModel orderModel = OrderModel();
    var uuid = Uuid();

    // writing all the values
    orderModel.oid = uuid.v1();
    orderModel.itemlist = itemlist;
    orderModel.totalprice = secondNameEditingController.text;

    await firebaseFirestore
        .collection("order")
        .doc(orderModel.oid)
        .set(orderModel.toFirestore());
    Fluttertoast.showToast(msg: "Item added successfully");
  }
}
