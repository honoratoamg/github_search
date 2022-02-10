import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/modules/search/domain/entities/result_search.dart';
import 'package:github_search/modules/search/domain/errors/errors.dart';
import 'package:github_search/modules/search/domain/repositories/search_repository.dart';
import 'package:github_search/modules/search/domain/usercases/search_by_text.dart';

class SearchRepositoryMock implements SearchRepository {
  @override
  Future<Either<FailureSearch, List<ResultSearch>>> search(String searchText) async {
    return const Right(<ResultSearch>[]);
  }
}

main() {
  // Teste unitário - Testa o que vai acontecer sem ter uma UI

  final repository = SearchRepositoryMock();
  final usecase = SearchByTextImpl(repository);

  test('Ele precisa retornar uma lista de ResultSearch', () async {
    final result = await usecase("honorato");
    expect(result | [], isA<List<ResultSearch>>());
  });

  test('Ele precisa retornar um InvalidTextError no caso de texto inválido', () async {
    final result = await usecase('');
    expect(result.isLeft(), true);
  });

}