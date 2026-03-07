import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:furneture_app/fetures/profile/model/OrdershistoryModel.dart';

class OrderRepo {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<List<OrdershistoryModel>> getUserOrders() {
    final userId = _auth.currentUser!.uid;

    return _firestore
        .collection('users')
        .doc(userId)
        .collection('orders')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs.map((doc) {
            final data = doc.data();
            return OrdershistoryModel(
              id: doc.id,
              items: data['items'] ?? [],
              total: data['total'] ?? 0,
              paymentMethod: data['paymentMethod'] ?? '',
              status: data['status'] ?? '',
              createdAt: (data['timestamp'] as Timestamp).toDate(),
              orderNumber: userId,
            );
          }).toList(),
        );
  }
}
