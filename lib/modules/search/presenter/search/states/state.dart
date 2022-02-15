import 'package:github_search/modules/search/domain/entities/result_search.dart';
import 'package:github_search/modules/search/domain/errors/errors.dart';

abstract class SearchState {}

class StartState implements SearchState {
  const StartState();
}

class LoadingState  implements SearchState {
  const LoadingState();
}

class ErrorState implements SearchState {
  final FailureSearch error;
  ErrorState(this.error);
}

class SuccessState implements SearchState {
  final List<ResultSearch> list;
  SuccessState(this.list);
}