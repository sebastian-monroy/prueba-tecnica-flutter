import 'dart:convert';

class Movie {
  final bool adult;
  String? backdropPath;
  final List<int> genreIds;
  final int id;
  final String originalLanguage; 
  final String originalTitle;
  final String overview;
  final double popularity;
  String? posterPath; 
  String? releaseDate; 
  final String title;
  final bool video;
  final double voteAverage;
  final int voteCount;

  Movie({
    required this.adult,
    this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    this.posterPath,
    this.releaseDate,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  get fullPosterImg {

    if(this.posterPath != null)
    return 'https://image.tmdb.org/t/p/w500${this.posterPath}';

    return 'https://www.mdvacationclub.com/wp-content/uploads/2018/12/Placeholder.png';
  }

    //imagen de la pelicula en detalles
    get fullbackdropPath {

    if(this.backdropPath != null)
    return 'https://image.tmdb.org/t/p/w500${this.backdropPath}';

    return 'https://www.mdvacationclub.com/wp-content/uploads/2018/12/Placeholder.png';
  }

  factory Movie.fromJson(String str) => Movie.fromMap(json.decode(str));

  
  factory Movie.fromMap(Map<String, dynamic> json) => Movie(
    adult: json["adult"], 
    backdropPath: json["backdrop_path"], 
    genreIds: List<int>.from(json["genre_ids"].map((x) => x)), 
    id: json["id"], 
    originalLanguage: json["original_language"], 
    originalTitle: json["original_title"], 
    overview: json["overview"], 
    popularity: json["popularity"].toDouble(), 
    posterPath: json["poster_path"], 
    releaseDate: json["release_date"], 
    title: json["title"], 
    video: json["video"], 
    voteAverage: json["vote_average"].toDouble(), 
    voteCount: json["vote_count"], 
  );
}
