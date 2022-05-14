import 'package:handball_ergebnisse/bloc/api/api_bloc.dart';
import 'package:handball_ergebnisse/bloc/api/states.dart';
import 'package:handball_ergebnisse/domain/league.dart';
import 'package:handball_ergebnisse/domain/repositories/league.dart';

class LeaguesForDistrictBloc extends ApiBloc<List<League>> {
  final LeagueRepository _leagueRepo;

  LeaguesForDistrictBloc(this._leagueRepo);

  void loadLeagues(String bhvDistrictId, String bhvSeasonId) async {
    emit(ApiLoadingState());

    try {
      final leagues = await _leagueRepo.getAllByDistrict(
        bhvDistrictId,
        bhvSeasonId,
      );
      emit(ApiLoadedState(leagues));
    } catch (e) {
      print(e);
      emit(ApiErrorState());
    }
  }
}
