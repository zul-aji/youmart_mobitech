import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../constants.dart';
import '../../../../model/product_upload.dart';

class DetailsUpdate extends StatefulWidget {
  final String pid, price, image, name, stock;

  const DetailsUpdate(
      {Key? key,
      required this.pid,
      required this.image,
      required this.name,
      required this.price,
      required this.stock})
      : super(key: key);

  @override
  State<DetailsUpdate> createState() => _DetailsUpdateState();
}

class _DetailsUpdateState extends State<DetailsUpdate> {
  ProductUploadModel productUploadModel = ProductUploadModel();

  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController stockController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // name field
    // TextEditingController nameController =
    //     TextEditingController(text: widget.name);
    TextFormField nameField = TextFormField(
      controller: nameController,
      autofocus: false,
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
        nameController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        prefixIcon: const Icon(Icons.tag_rounded),
        hintText: widget.name,
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

    // price field
    // TextEditingController priceController =
    //     TextEditingController(text: widget.price);
    TextFormField priceField = TextFormField(
      controller: priceController,
      autofocus: false,
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Price cannot be Empty");
        }
        return null;
      },
      onSaved: (value) {
        priceController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        prefixIcon: const Icon(Icons.attach_money_rounded),
        hintText: widget.price,
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

    //stock field
    // TextEditingController stockController =
    //     TextEditingController(text: widget.stock);
    TextFormField stockField = TextFormField(
      controller: stockController,
      autofocus: false,
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Stock cannot be Empty");
        }
        return null;
      },
      onSaved: (value) {
        stockController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        prefixIcon: const Icon(Icons.inventory_2_outlined),
        hintText: widget.stock,
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

    //update button
    final updateButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: colorPrimary,
      child: MaterialButton(
        padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          updateItem(nameController, priceController, stockController);
        },
        child: const Text(
          "Update Account",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 18, color: colorBase, fontWeight: FontWeight.bold),
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
        onPressed: () => showDialog<String>(
          context: context,
          barrierDismissible: true,
          builder: (BuildContext context) => AlertDialog(
            title: const Text(
              'Delete Item',
              style: TextStyle(
                fontSize: 25,
                color: colorAccent,
                fontWeight: FontWeight.w700,
              ),
            ),
            content: Text(
              'Are you sure you want to delete ${widget.name} from database?',
              style: const TextStyle(
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
                  Navigator.pop(context, 'Delete');
                  deleteProduct();
                },
                child: const Text(
                  'Delete',
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
        child: const Text(
          "Delete Item",
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
        backgroundColor: colorWhite,
        appBar: AppBar(
          backgroundColor: colorWhite,
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
              color: colorWhite,
              child: Padding(
                padding: const EdgeInsets.all(36.0),
                child: Form(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                          height: 180,
                          child: Image.network(
                            widget.image,
                            fit: BoxFit.contain,
                          )),
                      const SizedBox(height: 10),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          ' Item Name',
                          style: TextStyle(
                            fontSize: 17,
                            color: colorPrimaryDark,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      nameField,
                      const SizedBox(height: 10),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          ' Item Price',
                          style: TextStyle(
                            fontSize: 17,
                            color: colorPrimaryDark,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      priceField,
                      const SizedBox(height: 10),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          ' Item Stock',
                          style: TextStyle(
                            fontSize: 17,
                            color: colorPrimaryDark,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      stockField,
                      const SizedBox(height: 25),
                      updateButton,
                      const SizedBox(height: 15),
                      deleteButton,
                      const SizedBox(height: 45),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  updateItem(nameController, priceController, stockController) {
    // writing all the values
    productUploadModel.pid = widget.pid;

    if (nameController.text == "" || nameController.text == " ") {
      FirebaseFirestore.instance.collection("product").doc(widget.pid).update({
        'name': widget.name,
      });
    } else {
      FirebaseFirestore.instance.collection("product").doc(widget.pid).update({
        'name': nameController.text,
      });
    }

    if (priceController.text == "" || priceController.text == " ") {
      FirebaseFirestore.instance.collection("product").doc(widget.pid).update({
        'price': widget.price,
      });
    } else {
      FirebaseFirestore.instance.collection("product").doc(widget.pid).update({
        'price': priceController.text,
      });
    }

    if (stockController.text == "" || stockController.text == " ") {
      FirebaseFirestore.instance.collection("product").doc(widget.pid).update({
        'stock': widget.stock,
      });
    } else {
      FirebaseFirestore.instance.collection("product").doc(widget.pid).update({
        'stock': stockController.text,
      });
    }

    Fluttertoast.showToast(msg: "Item Updated");
    Navigator.of(context).pop();
  }

  deleteProduct() {
    FirebaseFirestore.instance.collection("product").doc(widget.pid).delete();

    Fluttertoast.showToast(msg: "Product Deleted");
    Navigator.of(context).pop();
  }
}
