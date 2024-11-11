import 'package:http/http.dart' as http;
import 'package:movies_list_app/layers/domain/models/credits_response.dart';
import 'package:movies_list_app/layers/domain/models/now_playing_response.dart';
import 'package:movies_list_app/layers/domain/models/popular_response.dart';
import 'package:movies_list_app/layers/domain/models/search_response.dart';



class ApiService {
  final String _apikey = '8aafd2fe520929670422504724495f75';
  final String _baseUrl = 'api.themoviedb.org';
  final String _language = 'es-ES';
  final http.Client httpCient;

  ApiService({http.Client? client}) :

   httpCient = client ?? http.Client();

  //peliculas normales 
  Future<NowPlayingResponse?> getOnDisplayMovies() async {
    try {
      final jsonData = await _getJsonData('3/movie/now_playing');
      final nowPlayingResponse = NowPlayingResponse.fromJson(jsonData);
      return nowPlayingResponse;
    } catch (e) {
      return null;
      // print("Error loading on display movies: $e");
    }
  }

  //peliculas populares
  Future<PopularResponse?> getPopularMovies(int page) async {
    try {
      final jsonData = await _getJsonData('3/movie/popular', page);
      final popularResponse = PopularResponse.fromJson(jsonData);
      return popularResponse;
    } catch (e) {
      return null;
      // print("Error loading popular movies: $e");
    }
  }

  //cast o actores
  Future<CreditsResponse ?> getMovieCast(int movieId) async {
  try {
    final jsonData = await _getJsonData('3/movie/${movieId}/credits');
    final creditsResponse = CreditsResponse.fromJson(jsonData);
    return creditsResponse;
  } catch (e) {
    return null;
    // print("Error loading movie cast: $e");
  }
}

//filtro de busqueda
  Future<SearchResponse ?> searchMovie(String query) async {
    try {
      final url = Uri.https(_baseUrl, '3/search/movie', {
        'api_key': _apikey,
        'language': _language,
        'query': query,
      });
      final response = await http.get(url);
      final searchResponse = SearchResponse.fromJson(response.body);
      return searchResponse;
    } catch (e) {
      return null;
      // print("Error searching movie: $e");
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