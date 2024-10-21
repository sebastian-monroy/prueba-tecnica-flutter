import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movies_list_app/models/models.dart';
import 'package:movies_list_app/models/search_response.dart';

class MoviesProvider extends ChangeNotifier {

  final String _apikey = '8aafd2fe520929670422504724495f75';
  final String _baseUrl = 'api.themoviedb.org';
  final String _language = 'es-ES';

  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies = [];

  //para los actores
  Map<int, List<Cast>> moviesCast = {};

  int _popularPage = 0;

//optimizacion de consultas http
Future<String> _getJsonData(String endpoint, [int page = 1]) async {
  var url = Uri.https(this._baseUrl, endpoint, {
    'api_key': _apikey,
    'language': _language,
    'page': '$page'
  });

  final response = await http.get(url);
  return response.body;
}


  MoviesProvider(){
    print('MoviesProvider inicializado');
    getOnDisplayMovies();
    getPopularMovies();
  }
  
  getOnDisplayMovies()async{
   
  final jsonData = await this._getJsonData('3/movie/now_playing');

  final nowPlayingResponse = NowPlayingResponse.fromJson(jsonData);

  onDisplayMovies = nowPlayingResponse.results;
  notifyListeners();
  }


  getPopularMovies() async {

  _popularPage++;

  final jsonData = await this._getJsonData('3/movie/popular', _popularPage);
  final popularResponse = PopularResponse.fromJson(jsonData);

  popularMovies = [...popularMovies,...popularResponse.results];
  notifyListeners();
  }

  //metodo para llamar al reparto de cada pelicula
  Future<List<Cast>>getMovieCast(int movieId) async {

    if(moviesCast.containsKey(movieId)) return moviesCast[movieId]!;

    print(movieId);

    final jsonData = await this._getJsonData('3/movie/$movieId/credits');
    final creditsResponse = CreditsResponse.fromJson(jsonData);

    moviesCast[movieId] = creditsResponse.cast;

    return creditsResponse.cast;

  }

  //metodo para buscar cada pelicula
  Future<List<Movie>>searchMovie(String query) async {
    final url = Uri.https(this._baseUrl, '3/search/movie', {
    'api_key': _apikey,
    'language': _language,
    'query': query
  });

    final response = await http.get(url);
    final searchResponse = SearchResponse.fromJson(response.body);

    return searchResponse.results;
  }

}