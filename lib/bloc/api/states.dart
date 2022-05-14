class ApiState<T> {}

class ApiInitialState<T> extends ApiState<T> {}

class ApiLoadingState<T> extends ApiState<T> {}

class ApiLoadedState<T> extends ApiState<T> {
  final T result;

  ApiLoadedState(this.result);
}

class ApiErrorState<T> extends ApiState<T> {}
