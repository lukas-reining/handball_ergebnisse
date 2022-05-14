abstract class FavoriteLeaguesRepository {
  Future<void> add(String bhvLeagueId);

  Future<void> remove(String bhvLeagueId);

  Future<List<String>> getAll();
}
