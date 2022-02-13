import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/modules/search/domain/errors/errors.dart';
import 'package:github_search/modules/search/external/datasources/github_datasource.dart';
import 'package:mocktail/mocktail.dart';

import '../../utils/github_response.dart';

class DioMock extends Mock implements Dio{}

main(){
  final dio = DioMock();
  final datasource = GithubDatasource(dio: dio);
  RequestOptions options = RequestOptions(path: '');

  test("Precisa retornar um lista de ResultSearchModel", () {
     when(() => dio.get(any()))
         .thenAnswer((_) async => Response(data: jsonDecode(githubResult), statusCode: 200, requestOptions: options));
     final future = datasource.getSearch("honoratoamg");
     expect(future, completes);
  });

  test("Precisa retornar um erro se o statuscode nao for 200", () {
    when(() => dio.get(any()))
        .thenAnswer((_) async => Response(data: jsonDecode(githubResult), statusCode: 401, requestOptions: options));
    final future = datasource.getSearch("honoratoamg");
    expect(future, throwsA(isA<DatasourceError>()));
  });

  test("Precisa retornar uma Exception se tiver um erro no dio", () {
    when(() => dio.get(any()))
        .thenThrow(Exception());
    final future = datasource.getSearch("honoratoamg");
    expect(future, throwsA(isA<Exception>()));
  });
}