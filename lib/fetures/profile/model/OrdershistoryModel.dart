// ignore: file_names
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:furneture_app/fetures/cart/model/cartitem_model.dart';

class OrdershistoryModel {
  final String id;
  final String orderNumber;
  final List<dynamic> items;
  final double total;
  final String paymentMethod;
  final String status;
  final DateTime createdAt;

  OrdershistoryModel({
    required this.id,
    required this.orderNumber,
    required this.items,
    required this.total,
    required this.paymentMethod,
    required this.status,
    required this.createdAt,
  });

  factory OrdershistoryModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return OrdershistoryModel(
      id: doc.id,
      orderNumber: doc.id.substring(0, 4),
      items: (data['items'] as List<dynamic>? ?? [])
          .map((e) => CartitemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      total: (data['total'] ?? 0).toDouble(),
      paymentMethod: data['paymentMethod'] ?? '',
      status: data['status'] ?? '',
      createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orderNumber': orderNumber,
      'items': items.map((e) => e.toJson()).toList(),
      'total': total,
      'paymentMethod': paymentMethod,
      'status': status,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
