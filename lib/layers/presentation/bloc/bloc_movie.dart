import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_list_app/app_locator.dart';
import 'package:movies_list_app/layers/domain/models/models.dart';
import 'package:movies_list_app/layers/domain/repositories/api_repository.dart';
import 'movies_event.dart';
import 'movies_state.dart';

class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  final apiRepository = locator<ApiRepository>();


  MoviesBloc() 
    :
    super(MoviesState()) {
    on<LoadOnDisplayMovies>(getOnDisplayMovies);
    on<LoadPopularMovies>(getPopularMovies);
    on<LoadMovieCast>(getMovieCast);
    on<SearchMovie>(searchMovie);
  }

  Future<void> getOnDisplayMovies(LoadOnDisplayMovies event, Emitter<MoviesState> emit) async {
    emit(state.copyWith(isLoading: true));
    try {
      final nowPlayingResponse = await apiRepository.getOnDisplayMovies();
      emit(state.copyWith(onDisplayMovies: nowPlayingResponse?.results ?? [], isLoading: false));
    } catch (e) {
      emit(state.copyWith(isLoading: false));
      print("Error loading on display movies: $e");
    }
  }

  Future<void> getPopularMovies(LoadPopularMovies event, Emitter<MoviesState> emit) async {
    emit(state.copyWith(isLoading: true));
    try {
      int popularPage = (state.popularMovies.length ~/ 20) + 1;
      final popularResponse = await apiRepository.getPopularMovies(popularPage);
      emit(state.copyWith(popularMovies: [...state.popularMovies, ...popularResponse?.results ?? [] ],
        isLoading: false,
      ));
    } catch (e) {
      emit(state.copyWith(isLoading: false));
      print("Error loading popular movies: $e");
    }
  }

Future<void> getMovieCast(LoadMovieCast event, Emitter<MoviesState> emit) async {
  if (state.moviesCast.containsKey(event.movieId)) return;
  try {
    final creditsResponse = await apiRepository.getMovieCast(event.movieId);
    final updatedCast = Map<int, List<Cast>>.from(state.moviesCast)..[event.movieId] = creditsResponse?.cast?? [];
    emit(state.copyWith(moviesCast: updatedCast));
  } catch (e) {
    print("Error loading movie cast: $e");
  }
}


  Future<void> searchMovie(SearchMovie event, Emitter<MoviesState> emit) async {
    emit(state.copyWith(isLoading: true));
    try {
      final searchResponse = await apiRepository.searchMovie(event.query);
      emit(state.copyWith(searchedMovies: searchResponse?.results?? [],
        isLoading: false,
      ));
    } catch (e) {
      emit(state.copyWith(isLoading: false));
      print("Error searching movie: $e");
    }
  }
}