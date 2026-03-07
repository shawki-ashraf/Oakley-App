part of 'add_tocart_cubit.dart';

sealed class AddTocartState {}

// الحالة الابتدائية
final class AddTocartInitial extends AddTocartState {}

// Loading لأي action (Add / Update)
final class CartActionLoading extends AddTocartState {}

// Success بعد إضافة عنصر للكارت
final class CartActionSuccess extends AddTocartState {
  final CartitemModel item;
  CartActionSuccess({required this.item});
}

// Error لأي action
final class CartActionError extends AddTocartState {
  final String msg;
  CartActionError({required this.msg});
}

// Loading عند انتظار Stream من Firebase
final class CartLoading extends AddTocartState {}

// Stream نزل بيانات الكارت
final class CartLoaded extends AddTocartState {
  final List<CartitemModel> items;
  CartLoaded({required this.items});
}

// Error لو حصل حاجة في Stream
final class CartError extends AddTocartState {
  final String msg;
  CartError({required this.msg});
}

// ------------------- ORDER STATES -------------------

final class OrderLoading extends AddTocartState {}

final class OrderSuccess extends AddTocartState {
  final OrderModel order;
  OrderSuccess({required this.order});
}

final class OrderError extends AddTocartState {
  final String msg;
  OrderError({required this.msg});
}
