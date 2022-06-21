class ShopStatusModel {
  String? status;

  ShopStatusModel({this.status});

  // receiving data from server
  factory ShopStatusModel.fromMap(map) {
    return ShopStatusModel(status: map['status']);
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'status': status,
    };
  }
}
