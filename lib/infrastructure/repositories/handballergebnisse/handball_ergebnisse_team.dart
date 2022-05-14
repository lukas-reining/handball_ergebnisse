import 'dart:convert';

import 'package:handball_ergebnisse/domain/repositories/team.dart';
import 'package:handball_ergebnisse/domain/team.dart';
import 'package:handball_ergebnisse/infrastructure/repositories/handballergebnisse/api_http_client.dart';

class HandballErgebnisseTeamRepository extends TeamRepository {
  @override
  Future<Team> get(String bhvTeamId) async {
    throw UnimplementedError();
  }

  @override
  Future<List<Team>> getAllByLeague(String leagueId) async {
    final client = HandballErgebnisseApiHttpClient();

    final response = await client.get(
      Uri.parse(
        '${HandballErgebnisseApiHttpClient.BASE_URL}/teams?leagueId=$leagueId',
      ),
    );

    final teamsDtos = jsonDecode(
      utf8.decode(response.bodyBytes),
    ) as List<dynamic>;

    return teamsDtos.map((teamDto) => Team.fromJson(teamDto)).toList();
  }
}
