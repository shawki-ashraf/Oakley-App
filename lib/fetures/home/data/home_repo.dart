import 'package:furneture_app/core/firebase_service.dart';
import 'package:furneture_app/fetures/home/data/products_model.dart';

class HomeRepo {
  final FirebaseService firebaseService = FirebaseService("products_furniture");
  final FirebaseService catogry = FirebaseService("category");

  // All Products
  Stream<List<ProductsModel>> getProductsStream() {
    final res = firebaseService.getStream();

    return res.map((snapshot) {
      return snapshot.docs.map((doc) {
        return ProductsModel.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();
    });
  }

  // category
  Stream<List<Catogerymodel>> getCatogrydata() {
    final res = catogry.getStream();

    return res.map((snapshot) {
      return snapshot.docs.map((doc) {
        return Catogerymodel.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();
    });
  }

  // Best Seller
  Stream<List<ProductsModel>> getBestSellerStream() {
    final res = firebaseService.query
        .where('isbestSallers', isEqualTo: true)
        .snapshots();

    return res.map((get) {
      return get.docs.map((doc) {
        return ProductsModel.fromJson(doc.data());
      }).toList();
    });
  }
}
