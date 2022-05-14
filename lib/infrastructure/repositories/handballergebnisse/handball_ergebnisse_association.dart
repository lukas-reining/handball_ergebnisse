import 'dart:convert';

import 'package:handball_ergebnisse/domain/association.dart';
import 'package:handball_ergebnisse/domain/repositories/association.dart';

import 'api_http_client.dart';

class HandballErgebnisseAssociationRepository implements AssociationRepository {
  @override
  Future<List<Association>> getAll() async {
    final client = HandballErgebnisseApiHttpClient();

    final response = await client.get(
      Uri.parse(
        '${HandballErgebnisseApiHttpClient.BASE_URL}/associations',
      ),
    );

    final associationDtos = jsonDecode(
      utf8.decode(response.bodyBytes),
    ) as List<dynamic>;

    return associationDtos
        .map((associationDto) => Association.fromJson(associationDto))
        .toList();
  }
}
