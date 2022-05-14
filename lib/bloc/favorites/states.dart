class FavoritesState<T> {}

class FavoritesInitialState<T> extends FavoritesState<T> {}

class FavoritesLoadingState<T> extends FavoritesState<T> {}

class FavoritesInitializedState<T> extends FavoritesState<T> {
  final List<T> favorites;

  FavoritesInitializedState(this.favorites);
}

class FavoritesErrorState<T> extends FavoritesState<T> {}
