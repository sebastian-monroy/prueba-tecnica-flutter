import 'package:movies_list_app/layers/data/datasource/api_service.dart';
import 'package:movies_list_app/layers/domain/models/credits_response.dart';
import 'package:movies_list_app/layers/domain/models/now_playing_response.dart';
import 'package:movies_list_app/layers/domain/models/popular_response.dart';
import 'package:movies_list_app/layers/domain/models/search_response.dart';
import 'package:movies_list_app/layers/domain/repositories/api_repository.dart';

class ApiRepositoryImpl implements ApiRepository { //esta clase es el puerto, traer servicios del api service
  final ApiService apiService;
  ApiRepositoryImpl({required this.apiService});


  //peliculas normales 
  @override
  Future<NowPlayingResponse?> getOnDisplayMovies() async {
    return await apiService.getOnDisplayMovies();
  }

  //peliculas populares
  @override
  Future<PopularResponse?> getPopularMovies(int page) async {
    return await apiService.getPopularMovies(page);
  }

    //cast o actores
  @override
  Future<CreditsResponse ?> getMovieCast(int movieId) async {
    return await apiService.getMovieCast(movieId);
  }

  //busqueda de peliculas
  @override
  Future<SearchResponse ?> searchMovie(String query) async {
    return await apiService.searchMovie(query);
  }

}