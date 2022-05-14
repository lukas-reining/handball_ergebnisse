import 'dart:convert';

import 'package:handball_ergebnisse/domain/district.dart';
import 'package:handball_ergebnisse/domain/repositories/district.dart';

import 'api_http_client.dart';

class HandballErgebnisseDistrictRepository implements DistrictRepository {
  @override
  Future<List<District>> getAllByAssociation(
    String associationId,
    String bhvSeasonId,
  ) async {
    final client = HandballErgebnisseApiHttpClient();

    final response = await client.get(
      Uri.parse(
        '${HandballErgebnisseApiHttpClient.BASE_URL}/districts?associationId=$associationId&seasonId=$bhvSeasonId',
      ),
    );

    final districtDtos = jsonDecode(
      utf8.decode(response.bodyBytes),
    ) as List<dynamic>;

    return districtDtos
        .map((districtDto) => District.fromJson(districtDto))
        .toList();
  }
}
