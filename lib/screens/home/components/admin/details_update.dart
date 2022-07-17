import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:youmart_mobitech/screens/home/components/admin/update_item.dart';

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
  //Controllers
  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final stockController = TextEditingController();

  ProductUploadModel productUploadModel = ProductUploadModel();

  @override
  Widget build(BuildContext context) {
    // name field
    final nameField = TextFormField(
      autofocus: false,
      controller: nameController,
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
        suffixIcon: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 9.0),
          child: ElevatedButton(
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(colorBase),
              backgroundColor: MaterialStateProperty.all<Color>(colorPrimary),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            onPressed: () {
              if (nameController.text == '' || nameController.text == ' ') {
                showDialog<String>(
                  context: context,
                  barrierDismissible: true,
                  builder: (BuildContext context) => AlertDialog(
                    title: const Text(
                      'Empty Field',
                      style: TextStyle(
                        fontSize: 25,
                        color: colorPrimary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    content: const Text(
                      'Field cannot be empty',
                      style: TextStyle(
                        color: colorPrimaryDark,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.pop(context, 'Close'),
                        child: const Text(
                          'Close',
                          style: TextStyle(
                            color: colorAccent,
                          ),
                        ),
                      ),
                    ],
                    backgroundColor: colorBase,
                  ),
                );
              } else {
                showDialog<String>(
                  context: context,
                  barrierDismissible: true,
                  builder: (BuildContext context) => AlertDialog(
                    title: const Text(
                      'Update Item Name',
                      style: TextStyle(
                        fontSize: 25,
                        color: colorPrimary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    content: Text(
                      'Are you sure you want to change your Item Name to ${nameController.text}?',
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
                            color: colorAccent,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          updateName();
                          Navigator.pop(context, 'Update');
                        },
                        child: const Text(
                          'Update',
                          style: TextStyle(
                            color: colorPrimary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                    backgroundColor: colorBase,
                  ),
                );
              }
            },
            child: const Text('Update'),
          ),
        ),
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
    final priceField = TextFormField(
      autofocus: false,
      controller: priceController,
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
        suffixIcon: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 9.0),
          child: ElevatedButton(
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(colorBase),
              backgroundColor: MaterialStateProperty.all<Color>(colorPrimary),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            onPressed: () {
              if (priceController.text == '' || priceController.text == ' ') {
                showDialog<String>(
                  context: context,
                  barrierDismissible: true,
                  builder: (BuildContext context) => AlertDialog(
                    title: const Text(
                      'Empty Field',
                      style: TextStyle(
                        fontSize: 25,
                        color: colorPrimary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    content: const Text(
                      'Field cannot be empty',
                      style: TextStyle(
                        color: colorPrimaryDark,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.pop(context, 'Close'),
                        child: const Text(
                          'Close',
                          style: TextStyle(
                            color: colorAccent,
                          ),
                        ),
                      ),
                    ],
                    backgroundColor: colorBase,
                  ),
                );
              } else {
                showDialog<String>(
                  context: context,
                  barrierDismissible: true,
                  builder: (BuildContext context) => AlertDialog(
                    title: const Text(
                      'Update Item Price',
                      style: TextStyle(
                        fontSize: 25,
                        color: colorPrimary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    content: Text(
                      'Are you sure you want to change your Item Price to ${priceController.text}?',
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
                            color: colorAccent,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          updatePrice();
                          Navigator.pop(context, 'Update');
                        },
                        child: const Text(
                          'Update',
                          style: TextStyle(
                            color: colorPrimary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                    backgroundColor: colorBase,
                  ),
                );
              }
            },
            child: const Text('Update'),
          ),
        ),
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
    final stockField = TextFormField(
      autofocus: false,
      controller: stockController,
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
        suffixIcon: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 9.0),
          child: ElevatedButton(
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(colorBase),
              backgroundColor: MaterialStateProperty.all<Color>(colorPrimary),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            onPressed: () {
              if (stockController.text == '' || stockController.text == ' ') {
                showDialog<String>(
                  context: context,
                  barrierDismissible: true,
                  builder: (BuildContext context) => AlertDialog(
                    title: const Text(
                      'Empty Field',
                      style: TextStyle(
                        fontSize: 25,
                        color: colorPrimary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    content: const Text(
                      'Field cannot be empty',
                      style: TextStyle(
                        color: colorPrimaryDark,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.pop(context, 'Close'),
                        child: const Text(
                          'Close',
                          style: TextStyle(
                            color: colorAccent,
                          ),
                        ),
                      ),
                    ],
                    backgroundColor: colorBase,
                  ),
                );
              } else {
                showDialog<String>(
                  context: context,
                  barrierDismissible: true,
                  builder: (BuildContext context) => AlertDialog(
                    title: const Text(
                      'Update Item Stock',
                      style: TextStyle(
                        fontSize: 25,
                        color: colorPrimary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    content: Text(
                      'Are you sure you want to change your Item Stock to ${stockController.text}?',
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
                            color: colorAccent,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          updateStock();
                          Navigator.pop(context, 'Update');
                        },
                        child: const Text(
                          'Update',
                          style: TextStyle(
                            color: colorPrimary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                    backgroundColor: colorBase,
                  ),
                );
              }
            },
            child: const Text('Update'),
          ),
        ),
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

  updateName() {
    // writing all the values
    productUploadModel.pid = widget.pid;

    FirebaseFirestore.instance.collection("product").doc(widget.pid).update({
      'name': nameController.text,
    });

    Fluttertoast.showToast(msg: "Product Updated");
    Navigator.of(context).pop();
  }

  updatePrice() {
    // writing all the values
    productUploadModel.pid = widget.pid;

    FirebaseFirestore.instance.collection("product").doc(widget.pid).update({
      'price': priceController.text,
    });

    Fluttertoast.showToast(msg: "Product Updated");
    Navigator.of(context).pop();
  }

  updateStock() {
    // writing all the values
    productUploadModel.pid = widget.pid;

    FirebaseFirestore.instance.collection("product").doc(widget.pid).update({
      'stock': stockController.text,
    });

    Fluttertoast.showToast(msg: "Product Updated");
    Navigator.of(context).pop();
  }

  deleteProduct() {
    FirebaseFirestore.instance.collection("product").doc(widget.pid).delete();

    Fluttertoast.showToast(msg: "Product Deleted");
    Navigator.of(context).pop();
  }
}
