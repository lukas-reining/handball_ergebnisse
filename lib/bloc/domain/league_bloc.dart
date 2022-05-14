import 'package:handball_ergebnisse/bloc/api/api_bloc.dart';
import 'package:handball_ergebnisse/bloc/api/states.dart';
import 'package:handball_ergebnisse/domain/league.dart';
import 'package:handball_ergebnisse/domain/repositories/league.dart';

class LeagueBloc extends ApiBloc<League> {
  final LeagueRepository _leagueRepo;

  LeagueBloc(this._leagueRepo);

  void loadLeague(String bhvLeagueId) async {
    emit(ApiLoadingState());

    try {
      final league = await _leagueRepo.get(bhvLeagueId);
      emit(ApiLoadedState(league));
    } catch (e) {
      print(e);
      emit(ApiErrorState());
    }
  }
}
