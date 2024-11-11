import 'package:equatable/equatable.dart';
import 'package:movies_list_app/layers/domain/models/models.dart';

class MoviesState extends Equatable {
  final List<Movie> onDisplayMovies;
  final List<Movie> popularMovies;
  final Map<int, List<Cast>> moviesCast;
  final bool isLoading;
  final List<Movie> searchedMovies;

  MoviesState({
    this.onDisplayMovies = const [],
    this.popularMovies = const [],
    this.moviesCast = const {},
    this.isLoading = false,
    this.searchedMovies = const [],
  });

  MoviesState copyWith({
    List<Movie>? onDisplayMovies,
    List<Movie>? popularMovies,
    Map<int, List<Cast>>? moviesCast,
    bool? isLoading,
    List<Movie>? searchedMovies,
  }) {
    return MoviesState(
      onDisplayMovies: onDisplayMovies ?? this.onDisplayMovies,
      popularMovies: popularMovies ?? this.popularMovies,
      moviesCast: moviesCast ?? this.moviesCast,
      isLoading: isLoading ?? this.isLoading,
      searchedMovies: searchedMovies ?? this.searchedMovies,
    );
  }

  @override
  List<Object?> get props => [onDisplayMovies, popularMovies, moviesCast, isLoading, searchedMovies];
}
