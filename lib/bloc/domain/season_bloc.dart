import 'package:handball_ergebnisse/bloc/api/api_bloc.dart';
import 'package:handball_ergebnisse/bloc/api/states.dart';
import 'package:handball_ergebnisse/domain/season.dart';
import 'package:handball_ergebnisse/domain/repositories/season.dart';

class SeasonsBloc extends ApiBloc<List<Season>> {
  final SeasonRepository _seasonRepo;

  SeasonsBloc(this._seasonRepo);

  void loadSeasons() async {
    emit(ApiLoadingState());

    try {
      final seasons = await _seasonRepo.getAll();
      emit(ApiLoadedState(seasons));
    } catch (e) {
      print(e);
      emit(ApiErrorState());
    }
  }
}
