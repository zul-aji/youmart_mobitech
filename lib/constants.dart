import 'package:flutter/material.dart';

//Color constants
const colorPrimaryDark = Color(0xFF1D3557);
const colorPrimary = Color(0xFF457B9D);
const colorPrimaryLight = Color(0xFFA8DADC);
const colorBase = Color(0xFFF1FAEE);
const colorAccent = Color(0xFFE63946);
const colorUnpicked = Color(0xFFACACAC);
const colorWhite = Color(0xFFFFFFFF);

//Categories for the customers
List<String> customerCategories = [
  "Snacks",
  "Instant Food",
  "Beverages",
  "Personal Care",
];

//Categories for admins
List<String> adminCategories = [
  "Shop Status",
  "Add Item",
  "Edit Item",
  "Orders",
  "Order History",
];

//Categories for the dropdown menu
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
