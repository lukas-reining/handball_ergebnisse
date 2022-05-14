import 'package:handball_ergebnisse/domain/team.dart';

abstract class TeamRepository {
  Future<Team> get(String bhvTeamId);

  Future<List<Team>> getAllByLeague(String bhvLeagueId);
}
