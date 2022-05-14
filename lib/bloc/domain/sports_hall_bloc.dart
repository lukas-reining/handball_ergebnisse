import 'package:handball_ergebnisse/bloc/api/api_bloc.dart';
import 'package:handball_ergebnisse/bloc/api/states.dart';
import 'package:handball_ergebnisse/domain/league.dart';
import 'package:handball_ergebnisse/domain/repositories/league.dart';
import 'package:handball_ergebnisse/domain/repositories/sports_hall.dart';
import 'package:handball_ergebnisse/domain/repositories/team.dart';
import 'package:handball_ergebnisse/domain/sports_hall.dart';
import 'package:handball_ergebnisse/domain/team.dart';

class SportsHallBloc extends ApiBloc<SportsHall> {
  final SportsHallRepository _sportsHallRepo;

  SportsHallBloc(this._sportsHallRepo);

  void loadSportsHall(String bhvGymId) async {
    emit(ApiLoadingState());

    try {
      final hall = await _sportsHallRepo.get(bhvGymId);
      emit(ApiLoadedState(hall));
    } catch (e) {
      print(e);
      emit(ApiErrorState());
    }
  }
}
