class ShopStatusModel {
  bool? status;

  ShopStatusModel(
      {
        this.status
      }
      );

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

// class ShopStatusModelDownload {
//   bool? status;
//
//   ShopStatusModelDownload(
//       {
//         required this.status
//       }
//       );
//
//   // receiving data from server
//   ShopStatusModelDownload.fromJson(Map<String, Object?> json)
//       : this(
//       status: json['status']! as bool,
//   );
//
//   // sending data to our server
//   Map<String, Object?> toJson() =>
//       {
//         'status': status,
//       };
// }
