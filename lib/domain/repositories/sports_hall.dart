import 'package:handball_ergebnisse/domain/sports_hall.dart';

abstract class SportsHallRepository {
  Future<SportsHall> get(String gymId);
}
