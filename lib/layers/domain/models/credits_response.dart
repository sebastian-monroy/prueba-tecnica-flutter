import 'dart:convert';

class CreditsResponse {
    final int id;
    final List<Cast> cast;
    final List<Cast> crew;

    CreditsResponse({
        required this.id,
        required this.cast,
        required this.crew,
    });

    factory CreditsResponse.fromJson(String srt) => CreditsResponse.fromMap(json.decode(srt));

    factory CreditsResponse.fromMap(Map<String, dynamic> json) => CreditsResponse(
      id: json["id"], 
      cast: List<Cast>.from(json["cast"].map((x)=> Cast.fromMap(x))), 
      crew: List<Cast>.from(json["crew"].map((x)=> Cast.fromMap(x)))
    );
}

class Cast {
    final bool adult;
    final int gender;
    final int id;
    final String knownForDepartment;
    final String name;
    final String originalName;
    final double popularity;
    String ? profilePath;
    int ?castId;
    String ?character;
    String creditId;
    int ?order;
    String ?department;
    String ? job;

    Cast({
        required this.adult,
        required this.gender,
        required this.id,
        required this.knownForDepartment,
        required this.name,
        required this.originalName,
        required this.popularity,
        this.profilePath,
        this.castId,
        this.character,
        required this.creditId,
        this.order,
        this.department,
        this.job,
    });

    get fullProfilePath {

      if(this.profilePath != null)
      return 'https://image.tmdb.org/t/p/w500${this.profilePath}';

      return 'https://www.mdvacationclub.com/wp-content/uploads/2018/12/Placeholder.png';
    }

    factory Cast.fromJson(String srt) => Cast.fromMap(json.decode(srt));

    factory Cast.fromMap(Map<String, dynamic> json) => Cast(
        adult: json["adult"],
        gender: json["gender"],
        id: json["id"],
        knownForDepartment: json["known_for_department"],
        name: json["name"],
        originalName: json["original_name"],
        popularity: json["popularity"].toDouble(),
        profilePath: json["profile_path"] == null ? null : json["profile_path"],
        castId: json["cast_id"]== null ? null : json["cast_id"],
        character: json["character"]== null ? null : json["character"],
        creditId: json["credit_id"],
        order: json["order"]== null ? null : json["order"],
        department: json["department"]== null ? null : json["department"],
        job: json["job"]== null ? null : json["job"],
    );
}
