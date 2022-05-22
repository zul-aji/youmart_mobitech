import 'dart:core';

class ProductModelView {
  String pid;
  final String name;
  final String price;
  final String category;
  final String image;

  ProductModelView({
    this.pid = '',
    required this.name,
    required this.price,
    required this.category,
    required this.image,
  });

  Map<String, dynamic> toJson() => {
    'pid': pid,
    'name': name,
    'price': price,
    'category': category,
    'image': image,
  };

  static ProductModelView fromJson(Map<String, dynamic> json) => ProductModelView(
    pid: json['id'],
    name: json['name'],
    price: json['price'],
    category: json['category'],
    image: json['image'],
  );

}