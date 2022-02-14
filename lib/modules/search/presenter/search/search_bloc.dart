import 'package:bloc/bloc.dart';
import 'package:github_search/modules/search/domain/usercases/search_by_text.dart';
import 'package:github_search/modules/search/presenter/search/states/state.dart';

class SearchBloc extends Bloc<String, SearchState> {
  final SearchByText usecase;

  SearchBloc(this.usecase) : super(SearchStart()){
    // TODO: Implementar
  }

}
