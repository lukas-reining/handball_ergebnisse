import 'package:handball_ergebnisse/bloc/api/api_bloc.dart';
import 'package:handball_ergebnisse/bloc/api/states.dart';
import 'package:handball_ergebnisse/domain/association.dart';
import 'package:handball_ergebnisse/domain/repositories/association.dart';

class AssociationsBloc extends ApiBloc<List<Association>> {
  final AssociationRepository _associationRepo;

  AssociationsBloc(this._associationRepo);

  void loadAssociations() async {
    emit(ApiLoadingState());

    try {
      final associations = await _associationRepo.getAll();
      emit(ApiLoadedState(associations));
    } catch (e) {
      print(e);
      emit(ApiErrorState());
    }
  }
}
