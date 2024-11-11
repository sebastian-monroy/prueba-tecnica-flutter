

import 'package:movies_list_app/layers/domain/models/credits_response.dart';
import 'package:movies_list_app/layers/domain/models/now_playing_response.dart';
import 'package:movies_list_app/layers/domain/models/popular_response.dart';
import 'package:movies_list_app/layers/domain/models/search_response.dart';

abstract class ApiRepository { //se conecta al puerto 


  //peliculas normales 
  Future<NowPlayingResponse?> getOnDisplayMovies();
  
  //peliculas populares
  Future<PopularResponse?> getPopularMovies(int page);

  //cast o actores
  Future<CreditsResponse?> getMovieCast(int movieId);

  //buscar peliculas
  Future<SearchResponse?> searchMovie(String query);
}