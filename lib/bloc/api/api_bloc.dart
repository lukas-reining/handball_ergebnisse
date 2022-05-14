import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:handball_ergebnisse/bloc/api/states.dart';

class ApiBloc<T> extends Cubit<ApiState<T>> {
  ApiBloc() : super(ApiInitialState<T>());
}
