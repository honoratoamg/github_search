import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/modules/search/domain/entities/result_search.dart';
import 'package:github_search/modules/search/domain/errors/errors.dart';
import 'package:github_search/modules/search/infra/datasources/search_datasource.dart';
import 'package:github_search/modules/search/infra/models/result_search_model.dart';
import 'package:github_search/modules/search/infra/repositories/search_repository_impl.dart';

class SearchDatasourceMock implements SearchDatasource {
  @override
  Future<List<ResultSearchModel>> getSearch(String searchText) {
    return Future.value(<ResultSearchModel>[]);
  }
}

class SearchDatasourceMockError implements SearchDatasource {
  @override
  Future<List<ResultSearchModel>> getSearch(String searchText) {
    throw Exception();
  }
}

main() {
  final datasource = SearchDatasourceMock();
  final repository = SearchRepositoryImpl(datasource);

  test('Precisa retornar uma lista de ResultSearch', () async {
    final result = await repository.search("honorato");
    expect(result | [],  isA<List<ResultSearch>>());
  });

  test('Precisa retornar um DatasourceError se o datasource falhar', () async {
    final datasource = SearchDatasourceMockError();
    final repository = SearchRepositoryImpl(datasource);
    final result = await repository.search("honorato");
    expect(result.fold(id,id), isA<DatasourceError>());
  });
}