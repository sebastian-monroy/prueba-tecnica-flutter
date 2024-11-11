import 'package:equatable/equatable.dart';

abstract class MoviesEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadOnDisplayMovies extends MoviesEvent {}
class LoadPopularMovies extends MoviesEvent {}
class LoadMovieCast extends MoviesEvent {
  final int movieId;
  LoadMovieCast(this.movieId);
}

class SearchMovie extends MoviesEvent {
  final String query;
  SearchMovie(this.query);
}
