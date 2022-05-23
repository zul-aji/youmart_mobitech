class ProductModel {
  String? pid, name, price, category, image;

  ProductModel({this.pid, this.name, this.price, this.category, this.image});

  // receiving data from server
  factory ProductModel.fromMap(map) {
    return ProductModel(
        pid: map['pid'],
        name: map['name'],
        price: map['price'],
        category: map['category'],
        image: map['image']);
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'pid': pid,
      'name': name,
      'price': price,
      'category': category,
      'image': image,
    };
  }

  Map<String, dynamic> toJson() => {
        'pid': pid,
        'name': name,
        'price': price,
        'category': category,
        'image': image,
      };

  static ProductModel fromJson(Map<String, dynamic> json) => ProductModel(
        pid: json['id'],
        name: json['name'],
        price: json['price'],
        category: json['category'],
        image: json['image'],
      );
}
