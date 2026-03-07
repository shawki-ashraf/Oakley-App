import 'dart:async';
import 'package:bloc/bloc.dart';
import '../model/cartitem_model.dart';
import '../model/cartitem_repo.dart';
part 'add_tocart_state.dart';

class AddTocartCubit extends Cubit<AddTocartState> {
  final CartitemRepo repo = CartitemRepo();

  StreamSubscription? _sub;

  AddTocartCubit() : super(AddTocartInitial());

  // ------------------- Add Item -------------------
  Future<void> addToCart(CartitemModel item) async {
    emit(CartActionLoading());
    try {
      await repo.addItem(item);
      emit(CartActionSuccess(item: item));
      // ❌ لا تحتاج لأي get هنا، Stream هيعمل التحديث تلقائيًا
    } catch (e) {
      emit(CartActionError(msg: e.toString()));
    }
  }

  // ------------------- Listen / Get Cart -------------------
  void listenToCart() {
    emit(CartLoading());

    _sub?.cancel();
    _sub = repo.getCartItemsStream().listen(
      (items) {
        emit(CartLoaded(items: items));
      },
      onError: (e) {
        emit(CartError(msg: e.toString()));
      },
    );
  }

  Future<void> removeItem(String id) async {
    await repo.removeItem(id);
  }

  Future<void> placeOrder({
    required double total,
    required String paymentMethod,
  }) async {
    if (state is! CartLoaded) return;

    final items = (state as CartLoaded).items;

    emit(OrderLoading());

    try {
      final order = OrderModel.create(
        items: items,
        total: total,
        paymentMethod: paymentMethod,
      );

      await repo.addcheckoutItem(order);

      await repo.clearCart();

      emit(OrderSuccess(order: order));
    } catch (e) {
      emit(OrderError(msg: e.toString()));
    }
  }

  @override
  Future<void> close() {
    _sub?.cancel();
    return super.close();
  }
}
