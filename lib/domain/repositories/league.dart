import 'package:handball_ergebnisse/domain/league.dart';

abstract class LeagueRepository {
  Future<League> get(String leagueId);

  Future<List<League>> getAllByDistrict(String districtId, String bhvSeasonId);
}
