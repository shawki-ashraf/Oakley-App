import 'package:cloud_firestore/cloud_firestore.dart';

class CartitemModel {
  final String name;
  final int price;
  final String dec;
  final String image;
  // ignore: non_constant_identifier_names
  final int products_ID;

  CartitemModel({
    required this.name,
    required this.price,
    required this.dec,
    required this.image,
    // ignore: non_constant_identifier_names
    required this.products_ID,
  });

  factory CartitemModel.fromJson(Map<String, dynamic> json) {
    return CartitemModel(
      name: json['name'] ?? '',
      products_ID: json["products_ID"] ?? 0,
      dec: json['dec'] ?? '',
      image: json['imageURL'] ?? '', // ✅ اتصلحت هنا
      price: json['price'] is int
          ? json['price']
          : int.tryParse(json['price'].toString()) ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'dec': dec,
      'imageURL': image, // خليه نفس اسم المفتاح في fromJson
      'price': price,
      "products_ID": products_ID,
    };
  }
}

class OrderModel {
  final String? id;
  final List<CartitemModel> items;
  final double total;
  final String paymentMethod;
  final String status;
  final DateTime timestamp;

  OrderModel({
    this.id,
    required this.items,
    required this.total,
    required this.paymentMethod,
    required this.status,
    required this.timestamp,
  });

  Map<String, dynamic> toJson() {
    return {
      'items': items
          .map((e) => e.toJson())
          .toList(), // CartitemModel لازم يكون فيه toJson
      'total': total,
      'paymentMethod': paymentMethod,
      'status': status,
      'timestamp': Timestamp.fromDate(timestamp),
    };
  }

  /// 👇 لتحويل البيانات من Firebase لـ OrderModel
  factory OrderModel.fromJson(Map<String, dynamic> json, String id) {
    return OrderModel(
      id: id,
      items: (json['items'] as List<dynamic>)
          .map((e) => CartitemModel.fromJson(e))
          .toList(),
      total: (json['total'] as num).toDouble(),
      paymentMethod: json['paymentMethod'],
      status: json['status'],
      timestamp: (json['timestamp'] as Timestamp).toDate(),
    );
  }

  factory OrderModel.create({
    required List<CartitemModel> items,
    required double total,
    required String paymentMethod,
  }) {
    return OrderModel(
      items: items,
      total: total,
      paymentMethod: paymentMethod,
      status: "pending",
      timestamp: DateTime.now(),
    );
  }

  /// 👇 copyWith لو محتاج تعدل بعد Firebase
  OrderModel copyWith({String? id, String? status}) {
    return OrderModel(
      id: id ?? this.id,
      items: items,
      total: total,
      paymentMethod: paymentMethod,
      status: status ?? this.status,
      timestamp: timestamp,
    );
  }
}
