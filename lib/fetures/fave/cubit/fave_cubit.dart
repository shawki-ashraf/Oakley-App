import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furneture_app/fetures/fave/cubit/fave_state.dart';
import 'package:furneture_app/fetures/fave/data/fave_repo.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  final FavoriteRepo repo = FavoriteRepo();

  FavoriteCubit() : super(FavoriteInitial());

  void listenFavorites() {
    repo.getFavorites().listen((favorites) {
      emit(FavoriteLoaded(favorites.toSet()));
    });
  }

  Future<void> toggleFavorite(String productId) async {
    if (state is FavoriteLoaded) {
      final currentFavorites = (state as FavoriteLoaded).favoriteIds;

      if (currentFavorites.contains(productId)) {
        await repo.removeFromFavorite(productId);
      } else {
        await repo.addToFavorite(productId);
      }
    }
  }
}
