import 'dart:convert';

import 'package:handball_ergebnisse/domain/repositories/sports_hall.dart';
import 'package:handball_ergebnisse/domain/sports_hall.dart';
import 'package:handball_ergebnisse/infrastructure/repositories/handballergebnisse/api_http_client.dart';

class HandballErgebnisseSportsHallRepository extends SportsHallRepository {
  @override
  Future<SportsHall> get(String bhvGymId) async {
    final client = HandballErgebnisseApiHttpClient();

    final response = await client.get(
      Uri.parse(
        '${HandballErgebnisseApiHttpClient.BASE_URL}/gymnasiums/$bhvGymId',
      ),
    );

    final gymDto = jsonDecode(utf8.decode(response.bodyBytes));

    return SportsHall.fromJson(gymDto);
  }
}
