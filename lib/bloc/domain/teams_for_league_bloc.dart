import 'package:handball_ergebnisse/bloc/api/api_bloc.dart';
import 'package:handball_ergebnisse/bloc/api/states.dart';
import 'package:handball_ergebnisse/domain/league.dart';
import 'package:handball_ergebnisse/domain/repositories/league.dart';
import 'package:handball_ergebnisse/domain/repositories/team.dart';
import 'package:handball_ergebnisse/domain/team.dart';

class TeamsForLeagueBloc extends ApiBloc<List<Team>> {
  final TeamRepository _teamRepo;

  TeamsForLeagueBloc(this._teamRepo);

  void loadTeams(String bhvLeagueId) async {
    emit(ApiLoadingState());

    try {
      final teams = await _teamRepo.getAllByLeague(bhvLeagueId);
      emit(ApiLoadedState(teams));
    } catch (e) {
      print(e);
      emit(ApiErrorState());
    }
  }
}
