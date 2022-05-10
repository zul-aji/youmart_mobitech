class UserModel {
  String? pid;
  String? name;
  String? price;
  String? category;

  UserModel({this.pid, this.name, this.price, this.category});

  // receiving data from server
  factory UserModel.fromMap(map) {
    return UserModel(
        pid: map['pid'],
        name: map['name'],
        price: map['price'],
        category: map['category']);
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'pid': pid,
      'name': name,
      'price': price,
      'category': category,
    };
  }
}
