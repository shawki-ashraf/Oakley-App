import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:furneture_app/fetures/home/data/home_repo.dart';
import 'package:furneture_app/fetures/home/data/products_model.dart';

part 'homeproducts_state.dart';

class HomeProductsCubit extends Cubit<HomeProductsState> {
  final HomeRepo homeRepo = HomeRepo();

  HomeProductsCubit() : super(HomeProductsInitial());

  StreamSubscription? _productsSub;
  StreamSubscription? _bestSellerSub;
  StreamSubscription? _categorySub;

  /// المنتجات الأصلية
  List<ProductsModel> allproducts = [];

  /// المنتجات المعروضة
  List<ProductsModel> _products = [];

  /// نتائج البحث
  List<ProductsModel> searchResults = [];

  List<ProductsModel> _bestSeller = [];
  List<Catogerymodel> _categories = [];

  bool _isProductsLoaded = false;
  bool _isBestSellerLoaded = false;
  bool _isCategoriesLoaded = false;

  /// تحميل بيانات الهوم
  void loadHomeData() {
    emit(HomeProductsLoading());

    /// 🔹 Products
    _productsSub?.cancel();
    _productsSub = homeRepo.getProductsStream().listen(
      (products) {
        allproducts = products;
        _products = products;

        _isProductsLoaded = true;
        _emitLoaded();
      },
      onError: (error) {
        emit(HomeProductsError(message: error.toString()));
      },
    );

    /// 🔹 Best Seller
    _bestSellerSub?.cancel();
    _bestSellerSub = homeRepo.getBestSellerStream().listen(
      (bestSeller) {
        _bestSeller = bestSeller;
        _isBestSellerLoaded = true;
        _emitLoaded();
      },
      onError: (error) {
        emit(HomeProductsError(message: error.toString()));
      },
    );

    /// 🔹 Categories
    _categorySub?.cancel();
    _categorySub = homeRepo.getCatogrydata().listen(
      (categories) {
        _categories = categories;
        _isCategoriesLoaded = true;
        _emitLoaded();
      },
      onError: (error) {
        emit(HomeProductsError(message: error.toString()));
      },
    );
  }

  /// Search Products
  void searchProducts(String query) {
    if (query.isEmpty) {
      _products = allproducts;
    } else {
      searchResults = allproducts.where((product) {
        return product.name.toLowerCase().contains(query.toLowerCase());
      }).toList();

      _products = searchResults;
    }

    emit(
      HomeProductsLoaded(
        products: _products,
        bestsaller: _bestSeller,
        catogry: _categories,
      ),
    );
  }

  /// emit state لما كل البيانات توصل
  void _emitLoaded() {
    if (!_isProductsLoaded || !_isBestSellerLoaded || !_isCategoriesLoaded) {
      return;
    }

    emit(
      HomeProductsLoaded(
        products: _products,
        bestsaller: _bestSeller,
        catogry: _categories,
      ),
    );
  }

  /// Refresh يدوي
  void refreshHome() {
    _isProductsLoaded = false;
    _isBestSellerLoaded = false;
    _isCategoriesLoaded = false;

    loadHomeData();
  }

  @override
  Future<void> close() {
    _productsSub?.cancel();
    _bestSellerSub?.cancel();
    _categorySub?.cancel();
    return super.close();
  }
}
