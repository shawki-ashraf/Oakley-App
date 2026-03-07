import 'package:furneture_app/core/cartfirebase_service.dart';
import 'package:furneture_app/core/checkout_fireservice.dart';
import 'package:furneture_app/fetures/cart/model/cartitem_model.dart';

class CartitemRepo {
  final FirebaseCartService firebaseCartService = FirebaseCartService();
  final CheckoutFireservice checkoutFireservice = CheckoutFireservice();

  // --------- Add Item (Future ✔️) ---------
  Future<void> addItem(CartitemModel item) async {
    await firebaseCartService.addToCart(item);
  }

  // --------- Get Cart Stream (🔥 التعديل المهم) ---------
  Stream<List<CartitemModel>> getCartItemsStream() {
    return firebaseCartService.getCartItemsStream();
  }

  // --------- Update Quantity (Future ✔️) ---------
  Future<void> updateQuantity(String productId, int quantity) async {
    await firebaseCartService.updateQuantity(productId, quantity);
  }

  // --------- Remove Item (Future ✔️) ---------
  Future<void> removeItem(String productId) async {
    await firebaseCartService.removeFromCart(productId);
  }

  // --------- Clear Cart (Future ✔️) ---------
  Future<void> clearCart() async {
    await firebaseCartService.clearCart();
  }

  Future<void> addcheckoutItem(OrderModel item) async {
    await checkoutFireservice.checkout(item);
  }
}
