import 'package:bloc/bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:github_search/modules/search/domain/usercases/search_by_text.dart';
import 'package:github_search/modules/search/presenter/search/states/state.dart';
import 'package:rxdart/rxdart.dart';

class SearchBloc extends Bloc<String, SearchState> implements Disposable {
  late final SearchByText searchByText;

  SearchBloc(this.searchByText) : super(const StartState()) {
    on<String>(
      (event, emit) async {
        if (event.isEmpty) {
          const StartState();
          return emit(const StartState());
        }

        emit(const LoadingState());

        var result = await searchByText(event);
        emit(result.fold(
          (failure) => ErrorState(failure),
          (success) => SuccessState(success),
        ));
      },
      transformer: debounce(const Duration(milliseconds: 900)),
    );
  }

  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }

  @override
  void dispose() {
    close();
  }
}
