abstract class FailureSearch implements Exception {}

class InvalidTextError implements FailureSearch {}

class DatasourceError implements FailureSearch {
  // Se o Datasource mandar um erro específico
  // late final String message;
  // DatasourceError({required this.message});
}

class EmptyList extends FailureSearch {}

class ErrorSearch extends FailureSearch {}
