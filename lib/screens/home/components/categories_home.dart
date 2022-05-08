import 'package:flutter/material.dart';

class Categories extends StatefulWidget {
  const Categories({Key? key}) : super(key: key);

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  List<String> categories = [
    "Snacks",
    "Instant Food",
    "Beverages",
    "Ice Cream",
    "Personal Care",
  ];
  // By default our first item will be selected
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: SizedBox(
        height: 25,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: categories.length,
          itemBuilder: (context, index) => buildCategory(index),
        ),
      ),
    );
  }

  Widget buildCategory(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              categories[index],
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: selectedIndex == index
                    ? Colors.cyan.shade800
                    : Color(0xFFACACAC),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 5), //top padding 5
              height: 3,
              width: 40,
              color: selectedIndex == index
                  ? Colors.cyan.shade800
                  : Colors.transparent,
            )
          ],
        ),
      ),
    );
  }
}
