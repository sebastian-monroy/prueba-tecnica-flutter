import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:movies_list_app/layers/data/models/models.dart';
import 'package:movies_list_app/layers/data/models/search_response.dart';
import '../../domain/usercase/movies_event.dart';
import '../../domain/repository/movies_state.dart';

class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  final String _apikey = '8aafd2fe520929670422504724495f75';
  final String _baseUrl = 'api.themoviedb.org';
  final String _language = 'es-ES';
  final http.Client httpCient;


  MoviesBloc({http.Client? client}) 
    
    : httpCient = client ?? http.Client(),
    super(MoviesState()) {
    on<LoadOnDisplayMovies>(getOnDisplayMovies);
    on<LoadPopularMovies>(getPopularMovies);
    on<LoadMovieCast>(getMovieCast);
    on<SearchMovie>(searchMovie);
  }

  Future<void> getOnDisplayMovies(
      LoadOnDisplayMovies event, Emitter<MoviesState> emit) async {
    emit(state.copyWith(isLoading: true));
    try {
      final jsonData = await _getJsonData('3/movie/now_playing');
      final nowPlayingResponse = NowPlayingResponse.fromJson(jsonData);
      emit(state.copyWith(
          onDisplayMovies: nowPlayingResponse.results, isLoading: false));
    } catch (e) {
      emit(state.copyWith(isLoading: false));
      print("Error loading on display movies: $e");
    }
  }

  Future<void> getPopularMovies(
      LoadPopularMovies event, Emitter<MoviesState> emit) async {
    emit(state.copyWith(isLoading: true));
    try {
      int popularPage = (state.popularMovies.length ~/ 20) + 1;
      final jsonData = await _getJsonData('3/movie/popular', popularPage);
      final popularResponse = PopularResponse.fromJson(jsonData);
      emit(state.copyWith(
        popularMovies: [...state.popularMovies, ...popularResponse.results],
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
    final jsonData = await _getJsonData('3/movie/${event.movieId}/credits');
    final creditsResponse = CreditsResponse.fromJson(jsonData);
    final updatedCast = Map<int, List<Cast>>.from(state.moviesCast)
      ..[event.movieId] = creditsResponse.cast;
    emit(state.copyWith(moviesCast: updatedCast));
  } catch (e) {
    print("Error loading movie cast: $e");
  }
}


  Future<void> searchMovie(
      SearchMovie event, Emitter<MoviesState> emit) async {
    emit(state.copyWith(isLoading: true));
    try {
      final url = Uri.https(_baseUrl, '3/search/movie', {
        'api_key': _apikey,
        'language': _language,
        'query': event.query,
      });
      final response = await http.get(url);
      final searchResponse = SearchResponse.fromJson(response.body);
      emit(state.copyWith(
        searchedMovies: searchResponse.results,
        isLoading: false,
      ));
    } catch (e) {
      emit(state.copyWith(isLoading: false));
      print("Error searching movie: $e");
    }
  }

  Future<String> _getJsonData(String endpoint, [int page = 1]) async {
    final url = Uri.https(_baseUrl, endpoint, {
      'api_key': _apikey,
      'language': _language,
      'page': '$page',
    });
    final response = await httpCient.get(url);
    return response.body;
  }
}