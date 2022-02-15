import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:github_search/modules/search/presenter/search/search_bloc.dart';

import '../../domain/entities/result_search.dart';
import '../../domain/errors/errors.dart';
import 'states/state.dart';
import 'search_bloc.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends ModularState<SearchPage, SearchBloc> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Github Search'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0, left: 8.0, top: 8.0),
            child: TextField(
              onChanged: controller.add,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: "Pesquise ..."),
            ),
          ),
          Expanded(
            child: BlocBuilder(
                bloc: controller,
                builder: (context, snapshot) {
                  final state = controller.state;

                  if (state is ErrorState) {
                    return _buildError(state.error);
                  }

                  if (state is StartState) {
                    return const Center(
                      child: Text('Pesquise por usuário do Github ...'),
                    );
                  } else if (state is LoadingState) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is SuccessState) {
                    return _buildList(state.list);
                  } else {
                    return Container();
                  }
                }),
          )
        ],
      ),
    );
  }

  Widget _buildList(List<ResultSearch> list) {
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (_, index) {
        var item = list[index];
        return ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(item.img),
          ),
          title: Text(item.title),
          subtitle: Text(item.content),
        );
      },
    );
  }

  Widget _buildError(FailureSearch error) {
    if (error is EmptyList) {
      return const Center(
        child: Text('Não foi encontrado nenhum usuário'),
      );
    } else if (error is ErrorSearch) {
      return const Center(
        child: Text('Erro no Github'),
      );
    } else {
      return const Center(
        child: Text('Foi encontrado um erro interno'),
      );
    }
  }
}
