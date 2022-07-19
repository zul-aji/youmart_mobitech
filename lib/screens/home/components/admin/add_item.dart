import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path/path.dart';
import 'package:uuid/uuid.dart';

import '../../../../api/firebase_api.dart';
import '../../../../constants.dart';
import '../../../../model/product_upload.dart';

class AddItem extends StatefulWidget {
  const AddItem({Key? key}) : super(key: key);

  @override
  State<AddItem> createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  File? file;
  UploadTask? task;
  //Controllers
  final itemNameController = TextEditingController();
  final itemPriceController = TextEditingController();
  final itemStockController = TextEditingController();

  String? currentItem = 'Snacks';

  @override
  void initState() {
    currentItem = customerCategories[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final fileName = file != null ? basename(file!.path) : 'No File Selected';

    // item name field
    final itemNameField = TextFormField(
      autofocus: false,
      controller: itemNameController,
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
        itemNameController.text = value!;
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

    // item price field
    final itemPriceField = TextFormField(
      autofocus: false,
      controller: itemPriceController,
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Price cannot be Empty");
        }
        return null;
      },
      onSaved: (value) {
        itemPriceController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Item Price",
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

    // item stock field
    final itemStockField = TextFormField(
      autofocus: false,
      controller: itemStockController,
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Stock cannot be Empty");
        }
        return null;
      },
      onSaved: (value) {
        itemStockController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Item Stock",
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

    // item category list
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
        dropdownColor: colorWhite,
        value: currentItem,
        onChanged: (String? newValue) {
          setState(() {
            currentItem = newValue!;
          });
        },
        items: dropdownItems);

    //select image button
    final selectImageButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: colorPrimaryDark,
      child: MaterialButton(
        padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: selectFile,
        child: const Text(
          "Select Image",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 18, color: colorWhite, fontWeight: FontWeight.bold),
        ),
      ),
    );

    // upload item button
    final uploadItemButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: colorPrimaryDark,
      child: MaterialButton(
        padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          uploadFile();
          postItemDetailsToFirestore();
        },
        child: const Text(
          "Upload Item",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 18, color: colorWhite, fontWeight: FontWeight.bold),
        ),
      ),
    );

    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const Text(
            'Input Item Details',
            style: TextStyle(
              fontSize: 25,
              color: colorPrimaryDark,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 10),
          itemNameField,
          const SizedBox(height: 10),
          itemPriceField,
          const SizedBox(height: 10),
          itemStockField,
          const SizedBox(height: 10),
          const Text(
            'Item Category',
            style: TextStyle(
              fontSize: 18,
              color: colorPrimaryDark,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 10),
          itemCategoryList,
          const SizedBox(height: 15),
          selectImageButton,
          Text(
            fileName,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          // const SizedBox(height: 10),
          // uploadImageButton,
          task != null ? buildUploadStatus(task!) : Container(),
          const SizedBox(height: 15),
          uploadItemButton,
        ],
      ),
    );
  }

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);

    if (result == null) return;
    final path = result.files.single.path!;

    setState(() => file = File(path));
  }

  Future uploadFile() async {
    if (file == null) return;

    final fileName = basename(file!.path);
    final destination = 'itemimage/$fileName';

    task = FirebaseApi.uploadFile(destination, file!);
    setState(() {});

    if (task == null) return;
  }

  Widget buildUploadStatus(UploadTask task) => StreamBuilder<TaskSnapshot>(
        stream: task.snapshotEvents,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final snap = snapshot.data!;
            final progress = snap.bytesTransferred / snap.totalBytes;
            final percentage = (progress * 100).toStringAsFixed(2);

            return Text(
              '$percentage %',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            );
          } else {
            return Container();
          }
        },
      );

  postItemDetailsToFirestore() async {
    var uuid = const Uuid();
    final snapshot = await task!.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();

    ProductUploadModel productUploadModel = ProductUploadModel();

    // writing all the values
    productUploadModel.pid = uuid.v1();
    productUploadModel.name = itemNameController.text;
    productUploadModel.price = itemPriceController.text;
    productUploadModel.stock = itemStockController.text;
    productUploadModel.category = currentItem;
    productUploadModel.image = urlDownload;

    FirebaseFirestore.instance
        .collection("product")
        .doc(productUploadModel.pid)
        .set(productUploadModel.toJson());

    Fluttertoast.showToast(msg: "Product created successfully");

    setState(() {
      itemNameController.text = "";
      itemPriceController.text = "";
      itemStockController.text = "";
      currentItem = "";
    });
  }
}
