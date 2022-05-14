import 'package:handball_ergebnisse/domain/district.dart';

abstract class DistrictRepository {
  Future<List<District>> getAllByAssociation(
    String associationId,
    String bhvSeasonId,
  );
}
