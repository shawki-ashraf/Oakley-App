import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FavoriteRepo {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> addToFavorite(String productId) async {
    final userId = _auth.currentUser!.uid;

    await _firestore
        .collection("users")
        .doc(userId)
        .collection("favorites")
        .doc(productId)
        .set({
          "productId": productId,
          "createdAt": FieldValue.serverTimestamp(),
        });
  }

  Future<void> removeFromFavorite(String productId) async {
    final userId = _auth.currentUser!.uid;

    await _firestore
        .collection("users")
        .doc(userId)
        .collection("favorites")
        .doc(productId)
        .delete();
  }

  Stream<List<String>> getFavorites() {
    final userId = _auth.currentUser!.uid;

    return _firestore
        .collection("users")
        .doc(userId)
        .collection("favorites")
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((doc) => doc.id).toList();
        });
  }
}
