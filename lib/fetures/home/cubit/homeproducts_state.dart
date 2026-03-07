part of 'homeproducts_cubit.dart';

sealed class HomeProductsState {}

final class HomeProductsInitial extends HomeProductsState {}

final class HomeProductsLoading extends HomeProductsState {}

final class HomeProductsLoaded extends HomeProductsState {
  final List<ProductsModel> products;
  final List<ProductsModel> bestsaller;
  final List<Catogerymodel> catogry;

  HomeProductsLoaded({
    required this.products,
    required this.bestsaller,
    required this.catogry,
  });
}

final class Bestsaller extends HomeProductsState {}

final class HomeProductsError extends HomeProductsState {
  final String message;

  HomeProductsError({required this.message});
}
