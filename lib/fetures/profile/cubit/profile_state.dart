part of 'profile_cubit.dart';

sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

final class Deleteloding extends ProfileState {}

final class Deleteloaded extends ProfileState {}

final class DeleteError extends ProfileState {
  final String msg;

  DeleteError({required this.msg});
}

//orders items

final class Ordersloding extends ProfileState {}

final class Ordersloaded extends ProfileState {
  final List<OrdershistoryModel> orders;

  Ordersloaded({required this.orders});
}

final class OrdersError extends ProfileState {
  final String msg;

  OrdersError({required this.msg});
}

//LOGOUT

final class Logoutloding extends ProfileState {}

final class Logoutloaded extends ProfileState {}

final class LogoutError extends ProfileState {
  final String msg;

  LogoutError({required this.msg});
}
