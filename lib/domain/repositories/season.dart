import 'package:handball_ergebnisse/domain/season.dart';

abstract class SeasonRepository {
  Future<List<Season>> getAll();
}
