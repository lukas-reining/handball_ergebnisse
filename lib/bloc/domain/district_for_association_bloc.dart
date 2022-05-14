import 'package:handball_ergebnisse/bloc/api/api_bloc.dart';
import 'package:handball_ergebnisse/bloc/api/states.dart';
import 'package:handball_ergebnisse/domain/association.dart';
import 'package:handball_ergebnisse/domain/district.dart';
import 'package:handball_ergebnisse/domain/league.dart';
import 'package:handball_ergebnisse/domain/repositories/association.dart';
import 'package:handball_ergebnisse/domain/repositories/district.dart';
import 'package:handball_ergebnisse/domain/repositories/league.dart';

class DistrictsForAssociationBloc extends ApiBloc<List<District>> {
  final DistrictRepository _districtRepo;

  DistrictsForAssociationBloc(this._districtRepo);

  void loadDistricts(String bhvAssociationId, String bhvSeasonId) async {
    emit(ApiLoadingState());

    try {
      final districts = await _districtRepo.getAllByAssociation(
        bhvAssociationId,
        bhvSeasonId,
      );
      emit(ApiLoadedState(districts));
    } catch (e) {
      print(e);
      emit(ApiErrorState());
    }
  }
}
