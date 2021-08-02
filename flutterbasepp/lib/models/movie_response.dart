class MovieResponse {
  late int page;
  late int totalResults;
  late int totalPages;
  late List<Movie> results;

  MovieResponse({
    required this.page,
    required this.totalResults,
    required this.totalPages,
    required this.results,
  });

  MovieResponse.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    totalResults = json['total_results'];
    totalPages = json['total_pages'];
    if (json['results'] != null) {
      results = <Movie>[];
      json['results'].forEach((v) {
        results.add(new Movie.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page'] = this.page;
    data['total_results'] = this.totalResults;
    data['total_pages'] = this.totalPages;
    data['results'] = this.results.map((v) => v.toJson()).toList();
    return data;
  }
}

class Movie {
  Movie({
    this.voteCount = 0,
    required this.id,
    this.video = false,
    this.voteAverage,
    this.title = '',
    this.popularity = 0,
    this.posterPath = '',
    this.originalLanguage = '',
    this.originalTitle = '',
    this.genreIds,
    this.backdropPath = '',
    this.adult = false,
    this.overview = '',
    this.releaseDate = '',
  });

  Movie.fromJson(Map<String, dynamic> json) {
    voteCount = json['vote_count'];
    id = json['id'];
    video = json['video'];
    voteAverage = json['vote_average'];
    title = json['title'];
    popularity = json['popularity'];
    posterPath = json['poster_path'];
    originalLanguage = json['original_language'];
    originalTitle = json['original_title'];
    genreIds = json['genre_ids'].cast<int>();
    backdropPath = json['backdrop_path'];
    adult = json['adult'];
    overview = json['overview'];
    releaseDate = json['release_date'];
  }

  late int voteCount;
  late int id;
  late bool video;
  var voteAverage;
  late String title;
  late double popularity;
  late String posterPath;
  late String originalLanguage;
  late String originalTitle;
  List<int>? genreIds;
  late String backdropPath;
  late bool adult;
  late String overview;
  late String releaseDate;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['vote_count'] = this.voteCount;
    data['id'] = this.id;
    data['video'] = this.video;
    data['vote_average'] = this.voteAverage;
    data['title'] = this.title;
    data['popularity'] = this.popularity;
    data['poster_path'] = this.posterPath;
    data['original_language'] = this.originalLanguage;
    data['original_title'] = this.originalTitle;
    data['genre_ids'] = this.genreIds;
    data['backdrop_path'] = this.backdropPath;
    data['adult'] = this.adult;
    data['overview'] = this.overview;
    data['release_date'] = this.releaseDate;
    return data;
  }
}
