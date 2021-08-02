
class RepositoryStatus<T> {
  RepositoryStatus(this.status, {this.data, this.error, this.code});

  static const STATUS_OK = 0;
  static const STATUS_FETCHING = 1;
  static const STATUS_ERROR = -2;

  final int status;
  final T? data;

  final String? error;
  final int? code;
}

abstract class Repository {
  static List<T> trimmedList<T>(List<T> list, int max) => max <= 0 || list.length <= max ? list : list.sublist(0, max);
}