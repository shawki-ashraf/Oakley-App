import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:furneture_app/fetures/cart/model/cartitem_model.dart';

class FirebaseCartService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addToCart(CartitemModel item) async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final path = 'users/$uid/cart_products/${item.products_ID}';
    await _firestore.doc(path).set(item.toJson());
  }

  // 🔥 STREAM
  Stream<List<CartitemModel>> getCartItemsStream() {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    return _firestore
        .collection('users')
        .doc(uid)
        .collection('cart_products')
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => CartitemModel.fromJson(doc.data()))
              .toList(),
        );
  }

  Future<void> updateQuantity(String productId, int quantity) async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final path = 'users/$uid/cart_products/$productId';
    await _firestore.doc(path).update({'quantity': quantity});
  }

  Future<void> removeFromCart(String productId) async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final path = 'users/$uid/cart_products/$productId';
    await _firestore.doc(path).delete();
  }

  Future<void> clearCart() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final cartCollection = _firestore
        .collection('users')
        .doc(uid)
        .collection('cart_products');

    final snapshot = await cartCollection.get();
    for (var doc in snapshot.docs) {
      await doc.reference.delete();
    }
  }
}
