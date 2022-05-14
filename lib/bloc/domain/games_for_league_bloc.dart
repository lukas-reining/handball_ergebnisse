import 'package:handball_ergebnisse/bloc/api/api_bloc.dart';
import 'package:handball_ergebnisse/bloc/api/states.dart';
import 'package:handball_ergebnisse/domain/game.dart';
import 'package:handball_ergebnisse/domain/repositories/game.dart';

class GamesForLeagueBloc extends ApiBloc<List<Game>> {
  final GameRepository _gameRepo;

  GamesForLeagueBloc(this._gameRepo);

  void loadGamesForLeague(String bhvLeagueId) async {
    emit(ApiLoadingState());

    try {
      final games = await _gameRepo.getAllByLeague(bhvLeagueId);
      emit(ApiLoadedState(games));
    } catch (e) {
      print(e);
      emit(ApiErrorState());
    }
  }

  void loadGamesForTeam(String bhvLeagueId, String bhvTeamId) async {
    emit(ApiLoadingState());

    try {
      final games = await _gameRepo.getAllByTeam(bhvLeagueId, bhvTeamId);
      emit(ApiLoadedState(games));
    } catch (e) {
      print(e);
      emit(ApiErrorState());
    }
  }
}
