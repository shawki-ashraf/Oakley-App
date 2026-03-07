import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:furneture_app/fetures/cart/model/cartitem_model.dart';

class CheckoutFireservice {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // ---------------- CHECKOUT (CREATE ORDER) ----------------
  Future<OrderModel> checkout(OrderModel order) async {
    final user = _auth.currentUser;

    if (user == null) {
      throw Exception("User not logged in");
    }

    final docRef = await _firestore
        .collection('users')
        .doc(user.uid)
        .collection('orders')
        .add(order.toJson());

    // 🔥 نرجع الـ Order بالـ ID اللي Firebase ولده
    return order.copyWith(id: docRef.id);
  }

  // ---------------- STREAM ORDERS ----------------
  Stream<List<OrderModel>> getCheckoutStream() {
    final user = _auth.currentUser;

    if (user == null) {
      throw Exception("User not logged in");
    }

    return _firestore
        .collection('users')
        .doc(user.uid)
        .collection('orders')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => OrderModel.fromJson(doc.data(), doc.id))
              .toList(),
        );
  }
}
