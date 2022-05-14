import 'package:handball_ergebnisse/domain/game.dart';

abstract class GameRepository {
  Future<List<Game>> getAllByTeam(String bhvLeagueId, String bhvTeamId);

  Future<List<Game>> getAllByLeague(String bhvLeagueId);
}
