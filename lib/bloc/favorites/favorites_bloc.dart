import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:handball_ergebnisse/bloc/favorites/states.dart';

abstract class FavoritesBloc<T> extends Cubit<FavoritesState<T>> {
  FavoritesBloc() : super(FavoritesInitialState<T>());
}
