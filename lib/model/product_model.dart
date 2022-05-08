class UserModel {
  String? pid;
  String? name;
  String? price;
  String? image;

  UserModel({this.pid, this.name, this.price, this.image});

  // receiving data from server
  factory UserModel.fromMap(map) {
    return UserModel(
        pid: map['pid'],
        name: map['name'],
        price: map['price'],
        image: map['image']);
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'pid': pid,
      'name': name,
      'price': price,
      'image': image,
    };
  }
}
