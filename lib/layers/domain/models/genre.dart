import 'dart:convert';

class Generos {
    final List<Genre> genres;

    Generos({
        required this.genres,
    });

    factory Generos.fromJson(String str) => Generos.fromMap(json.decode(str));

    factory Generos.fromMap(Map<String, dynamic> json) => Generos(
        genres: List<Genre>.from(json["genres"].map((x) => Genre.fromJson(x))),
    );
}

class Genre {
    final int id;
    final String name;

    Genre({
        required this.id,
        required this.name,
    });

    factory Genre.fromJson(String str) => Genre.fromMap(json.decode(str));

    factory Genre.fromMap(Map<String, dynamic> json) => Genre(
        id: json["id"],
        name: json["name"],
    );

  
}
