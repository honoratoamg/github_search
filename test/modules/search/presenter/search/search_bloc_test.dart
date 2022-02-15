import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/modules/search/domain/entities/result_search.dart';
import 'package:github_search/modules/search/domain/errors/errors.dart';
import 'package:github_search/modules/search/domain/usercases/search_by_text.dart';
import 'package:github_search/modules/search/presenter/search/search_bloc.dart';
import 'package:github_search/modules/search/presenter/search/states/state.dart';
import 'package:mocktail/mocktail.dart';

class SearchByTextMock extends Mock implements SearchByText {}

class SearchBlocMock extends MockBloc<String, SearchState>
    implements SearchBloc {}

main() {
  final usecase = SearchByTextMock();
  var searchBloc = SearchBlocMock();
  searchBloc.searchByText = usecase;

  test('Precisa emitir sequencia correta de estados', () async {
    when(() => usecase.call(any()))
        .thenAnswer((_) async => const Right(<ResultSearch>[]));
    whenListen(searchBloc,
        Stream.fromIterable([LoadingState(), SuccessState(<ResultSearch>[])]));
    expect(
        searchBloc.stream,
        emitsInOrder([
          isA<LoadingState>(),
          isA<SuccessState>(),
        ]));
  });

  test("Precisa retornar um erro", () {
    final error = InvalidTextError();
    when(() => usecase.call(any())).thenAnswer((_) async => Left(error));
    whenListen(searchBloc,
        Stream.fromIterable([const LoadingState(), ErrorState(error)]));

    expect(
        searchBloc.stream,
        emitsInOrder([
          isA<LoadingState>(),
          isA<ErrorState>(),
        ]));
  });
}
