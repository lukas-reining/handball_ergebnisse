import 'package:handball_ergebnisse/domain/association.dart';

abstract class AssociationRepository {
  Future<List<Association>> getAll();
}
