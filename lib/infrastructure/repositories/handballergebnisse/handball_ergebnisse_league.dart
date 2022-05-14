import 'dart:convert';

import 'package:handball_ergebnisse/domain/league.dart';
import 'package:handball_ergebnisse/domain/repositories/league.dart';

import 'api_http_client.dart';

class HandballErgebnisseLeagueRepository extends LeagueRepository {
  @override
  Future<League> get(String leagueId) async {
    final client = HandballErgebnisseApiHttpClient();

    final response = await client.get(
      Uri.parse(
        '${HandballErgebnisseApiHttpClient.BASE_URL}/leagues/$leagueId',
      ),
    );

    final leagueDto = jsonDecode(utf8.decode(response.bodyBytes));

    return League.fromJson(leagueDto);
  }

  @override
  Future<List<League>> getAllByDistrict(
    String districtId,
    String seasonId,
  ) async {
    final client = HandballErgebnisseApiHttpClient();

    final response = await client.get(
      Uri.parse(
        '${HandballErgebnisseApiHttpClient.BASE_URL}/leagues?districtId=$districtId&seasonId=$seasonId',
      ),
    );

    final leaguesDtos = jsonDecode(
      utf8.decode(response.bodyBytes),
    ) as List<dynamic>;

    return leaguesDtos.map((leagueDto) => League.fromJson(leagueDto)).toList();
  }
}
