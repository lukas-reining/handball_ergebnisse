import 'dart:convert';

import 'package:handball_ergebnisse/domain/season.dart';
import 'package:handball_ergebnisse/domain/repositories/season.dart';

import 'api_http_client.dart';

class HandballErgebnisseSeasonRepository implements SeasonRepository {
  @override
  Future<List<Season>> getAll() async {
    final client = HandballErgebnisseApiHttpClient();

    final response = await client.get(
      Uri.parse('${HandballErgebnisseApiHttpClient.BASE_URL}/seasons'),
    );

    final seasonDtos = jsonDecode(
      utf8.decode(response.bodyBytes),
    ) as List<dynamic>;

    return seasonDtos.map((seasonDto) => Season.fromJson(seasonDto)).toList();
  }
}
