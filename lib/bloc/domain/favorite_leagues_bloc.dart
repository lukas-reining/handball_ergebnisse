import 'package:handball_ergebnisse/bloc/favorites/favorites_bloc.dart';
import 'package:handball_ergebnisse/bloc/favorites/states.dart';
import 'package:handball_ergebnisse/domain/repositories/favorite_leagues.dart';

class FavoriteLeaguesBloc extends FavoritesBloc<String> {
  final FavoriteLeaguesRepository _favoriteLeaguesRepo;

  List<String>? _favoriteLeagues;

  FavoriteLeaguesBloc(this._favoriteLeaguesRepo);

  void loadFavoriteLeagues() async {
    emit(FavoritesLoadingState());

    try {
      _favoriteLeagues =
          _favoriteLeagues ?? await _favoriteLeaguesRepo.getAll();

      emit(FavoritesInitializedState(_favoriteLeagues!));
    } catch (e) {
      emit(FavoritesErrorState());
    }
  }

  void addFavoriteLeague(String bhvLeagueId) async {
    try {
      _favoriteLeaguesRepo.add(bhvLeagueId);
      _favoriteLeagues?.add(bhvLeagueId);
      emit(FavoritesInitializedState(_favoriteLeagues!));
    } catch (e) {
      emit(FavoritesErrorState());
    }
  }

  void removeFavoriteLeague(String bhvLeagueId) async {
    try {
      _favoriteLeaguesRepo.remove(bhvLeagueId);
      _favoriteLeagues?.remove(bhvLeagueId);
      emit(FavoritesInitializedState(_favoriteLeagues!));
    } catch (e) {
      emit(FavoritesErrorState());
    }
  }
}
