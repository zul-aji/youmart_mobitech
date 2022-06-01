import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  final String pid, name, category, image, price;

  const Product({
    required this.pid,
    required this.name,
    required this.category,
    required this.price,
    required this.image,
  });

  static Product fromSnapshot(DocumentSnapshot snap) {
    Product product = Product(
      pid: snap['[pid]'],
      name: snap['name'],
      category: snap['category'],
      price: snap['price'],
      image: snap['image'],
    );
    return product;
  }
}
