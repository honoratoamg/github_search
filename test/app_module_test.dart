import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:github_search/modules/search/domain/entities/result_search.dart';
import 'package:mocktail/mocktail.dart';
import 'package:modular_test/modular_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/app_module.dart';
import 'package:github_search/modules/search/domain/usercases/search_by_text.dart';

import 'modules/search/utils/github_response.dart';

class DioMock extends Mock implements Dio {}

main(){
  final dio = DioMock();
  RequestOptions options = RequestOptions(path: '');

  initModule(AppModule(), replaceBinds: [
    Bind<Dio>((i) => dio)
  ]);

  test('Precisa recuperar o usecase sem erro', (){
    final usecase = Modular.get<SearchByText>();
    expect(usecase, isA<SearchByTextImpl>());
  });

  test('Teste de integração: precisa trazer uma lista de ResultSearch', () async {
    when(() => dio.get(any()))
        .thenAnswer((_) async => Response(data: jsonDecode(githubResult), statusCode: 200, requestOptions: options));

    final usecase = Modular.get<SearchByText>();
    final result = await usecase("honorato");
    expect(result | [], isA<List<ResultSearch>>());
  });
}