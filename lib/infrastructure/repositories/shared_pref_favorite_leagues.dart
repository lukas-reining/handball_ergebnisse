import 'package:handball_ergebnisse/domain/repositories/favorite_leagues.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefFavoriteLeaguesRepository extends FavoriteLeaguesRepository {
  static const _preferenceKey = "favorite_leagues";

  @override
  Future<void> add(String bhvLeagueId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final newFavorites = prefs.getStringList(_preferenceKey) ?? [];
    newFavorites.add(bhvLeagueId);

    await prefs.setStringList(_preferenceKey, newFavorites);
  }

  @override
  Future<void> remove(String bhvLeagueId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final newFavorites = prefs.getStringList(_preferenceKey) ?? [];
    newFavorites.remove(bhvLeagueId);

    await prefs.setStringList(_preferenceKey, newFavorites);
  }

  @override
  Future<List<String>> getAll() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_preferenceKey) ?? [];
  }
}
