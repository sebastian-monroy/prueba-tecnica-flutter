import 'dart:convert';
import 'package:movies_list_app/layers/domain/models/movie.dart';

class NowPlayingResponse {
  final Dates dates;
  final int page; 
  final List<Movie> results; 
  final int totalPages; 
  final int totalResults; 

  NowPlayingResponse({
    required this.dates,
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  
  factory NowPlayingResponse.fromJson(String str) => NowPlayingResponse.fromMap(json.decode(str));

  factory NowPlayingResponse.fromMap(Map<String, dynamic> json) => NowPlayingResponse(
        dates: Dates.fromMap(json["dates"]),
        page: json["page"],
        results: List<Movie>.from(json["results"].map((x)=> Movie.fromMap(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );
}

class Dates {
  final DateTime maximum; 
  final DateTime minimum;

  Dates({
    required this.maximum,
    required this.minimum,
  });

  
  factory Dates.fromJson(String str) => Dates.fromMap(json.decode(str));

  
  factory Dates.fromMap(Map<String, dynamic> json) => Dates(
        maximum: DateTime.parse(json["maximum"]),
        minimum: DateTime.parse(json["minimum"]),
      );
}
