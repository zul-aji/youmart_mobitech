class ProductModel {
  String? pid;
  String? name;
  String? price;
  String? category;
  String? image;

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
}
