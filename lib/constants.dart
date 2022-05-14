import 'package:flutter/material.dart';

const colorPrimaryDark = Color(0xFF1D3557);
const colorPrimary = Color(0xFF457B9D);
const colorPrimaryLight = Color(0xFFA8DADC);
const colorBase = Color(0xFFF1FAEE);
const colorAccent = Color(0xFFE63946);
const colorUnpicked = Color(0xFFACACAC);

List<String> customerCategories = [
  "Snacks",
  "Instant Food",
  "Beverages",
  "Personal Care",
];

List<String> adminCategories = [
  "Add Item",
  "Update Item",
  "Delete Item",
  "Orders",
];

List<DropdownMenuItem<String>> get dropdownItems {
  List<DropdownMenuItem<String>> categoryItems = [
    const DropdownMenuItem(value: "Snacks", child: Text("Snacks")),
    const DropdownMenuItem(value: "Instant Food", child: Text("Instant Food")),
    const DropdownMenuItem(value: "Beverages", child: Text("Beverages")),
    const DropdownMenuItem(
        value: "Personal Care", child: Text("Personal Care")),
  ];
  return categoryItems;
}
