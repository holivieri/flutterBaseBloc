import 'package:flutterbasepp/services/movies_service.dart';

import '../api/api_base_helper.dart';
import '../models/movie_response.dart';
import 'repository_base.dart';
import 'repository_cache.dart';

class MovieRepository extends Repository {
  final String _apiKey = "78b9f63937763a206bff26c070b94158";
  static String movieKey(String movieId) => 'movie::$movieId';
  final RepositoryCache _cache = RepositoryCache();
  final MoviesService _apiService = MoviesService();
  static const MOVIE_KEY = 'movies_featured';

  ApiBaseHelper _helper = ApiBaseHelper();

  Future<List<Movie>> fetchMovieList() async {
    //_cache.getObjectList(movieKey, Movie);
    final response = await _helper.get("movie/popular?api_key=$_apiKey");
    return MovieResponse.fromJson(response).results;
  }

  Future<List<Movie>> _readMovieList(String key) async =>
      _cache
          .readObjectList<String>(key)
          ?.map((movieId) =>
              _cache.readObject<Movie>(movieKey(movieId)) ??
              Movie(id: int.parse(movieId)))
          .toList() ??
      List.empty();

  Future<List<Movie>> _readMovieListMax(String key, {int max = 0}) =>
      _readMovieList(key).then((list) => Repository.trimmedList(list, max));

  Stream<RepositoryStatus<List<Movie>>> getMovies({int max = 0}) async* {
    yield RepositoryStatus(RepositoryStatus.STATUS_FETCHING,
        data: await _readMovieListMax(MOVIE_KEY, max: max));

    try {
      final result = await _apiService.getMovies();
      if (result.isNotEmpty) {
        final List<String> idList = [];
        for (final movie in result) {
          idList.add(movie.id.toString());
          _cache.stowObject(movieKey(movie.id.toString()), movie);
        }
        _cache.stowObjectList(MOVIE_KEY, idList);
      }
      yield RepositoryStatus(RepositoryStatus.STATUS_OK,
          data: await _readMovieListMax(MOVIE_KEY, max: max));
    } on Exception catch (error) {
      yield RepositoryStatus(RepositoryStatus.STATUS_ERROR,
          error: error.toString(),
          data: await _readMovieListMax(MOVIE_KEY, max: max));
    }
  }
}
