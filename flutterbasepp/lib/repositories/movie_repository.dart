import '../api/api_base_helper.dart';
import '../models/movie_response.dart';
import 'repository_base.dart';
import 'repository_cache.dart';

class MovieRepository extends Repository {
  final String _apiKey = "78b9f63937763a206bff26c070b94158";
  static movieKey(String movieId) => 'movie::$movieId';
  final RepositoryCache _cache = RepositoryCache();

  ApiBaseHelper _helper = ApiBaseHelper();

  Future<List<Movie>> fetchMovieList() async {
    final response = await _helper.get("movie/popular?api_key=$_apiKey");
    return MovieResponse.fromJson(response).results;
  }
}
