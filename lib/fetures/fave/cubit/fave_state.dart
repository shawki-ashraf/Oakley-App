abstract class FavoriteState {}

class FavoriteInitial extends FavoriteState {}

class FavoriteLoading extends FavoriteState {}

class FavoriteLoaded extends FavoriteState {
  final Set<String> favoriteIds;

  FavoriteLoaded(this.favoriteIds);
}

class FavoriteError extends FavoriteState {}
