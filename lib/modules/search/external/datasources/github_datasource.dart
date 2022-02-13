import 'package:dio/src/dio.dart';
import 'package:github_search/modules/search/domain/errors/errors.dart';

import 'package:github_search/modules/search/infra/models/result_search_model.dart';

import '../../infra/datasources/search_datasource.dart';

class GithubDatasource implements SearchDatasource {
  late final Dio dio;

  GithubDatasource({required this.dio});

  @override
  Future<List<ResultSearchModel>> getSearch(String searchText) async {
    final response = 
        await dio.get("https://api.github.com/search/users?q=${normalizeText(searchText)}");
    if(response.statusCode == 200){
      final list = (response.data['items'] as List)
          .map((e) => ResultSearchModel.fromMap(e))
          .toList();
      return list;
    } else {
     throw DatasourceError();
    }
  }

  String normalizeText(String text){
    return text.replaceAll(" ", "+");
  }
}