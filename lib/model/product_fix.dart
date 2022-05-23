import 'package:cloud_firestore/cloud_firestore.dart';

class ProductList {
  final String pid, name, category, price, image;

  const ProductList({
    required this.pid,
    required this.name,
    required this.category,
    required this.price,
    required this.image,
  });

  ProductList.fromJson(Map<String, Object?> json)
      : this(
          name: json['name']! as String,
          category: json['category']! as String,
          price: json['price']! as String,
          pid: json['pid']! as String,
          image: json['image']! as String,
        );

  Map<String, Object?> toJson() => {
        'pid': pid,
        'title': name,
        'likes': price,
        'price': category,
        'image': image,
      };
}
