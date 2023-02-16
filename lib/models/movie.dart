/* 
Clase Movie con sus métodos, que es invocada desde cualquier Widget con el fin de encapsular
sus atributos y métodos y estructurar mejor el código, favoreciendo su mantenimento.
*/

import 'models.dart';

//Método constructor
class Movie {
  Movie({
    required this.adult,
    required this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.releaseDate,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

//Zona de declaración de atributos de la clase (obtenidos del cuerpo del JSON)
  bool adult;
  String backdropPath;
  List<int> genreIds;
  int id;
  String originalLanguage;
  String originalTitle;
  String overview;
  double popularity;
  String?
      posterPath; //Variable opcional porque puede haber películas sin carátulas
  DateTime releaseDate;
  String title;
  bool video;
  double voteAverage;
  int voteCount;

/*
 Getter para obtener la imagen de carátula para mostrar. Se comprueba que la variable
 posterPath contiene una imagen, en caso contrario se le asigna una imagen por defecto
 */
  get fullPosterPath {
    if (posterPath != 0) {
      //Se concatena el inicio de la URL con la variable 'posterPath' para hacer el método dinámico
      return 'https://image.tmdb.org/t/p/w500$posterPath';
    } else {
      //Se devuelve una imagen por defecto en caso de que no haya carátula para mostrar.
      return 'https://i.stack.imgur.com/GNhxO.png';
    }
  }

//Métodos fromJson y fromMap para mapear el cuerpo del JSON obtenido
  factory Movie.fromJson(String str) => Movie.fromMap(json.decode(str));

  factory Movie.fromMap(Map<String, dynamic> json) => Movie(
        adult: json["adult"],
        backdropPath: json["backdrop_path"],
        genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
        id: json["id"],
        originalLanguage: json["original_language"]!,
        originalTitle: json["original_title"],
        overview: json["overview"],
        popularity: json["popularity"]?.toDouble(),
        posterPath: json["poster_path"],
        releaseDate: DateTime.parse(json["release_date"]),
        title: json["title"],
        video: json["video"],
        voteAverage: json["vote_average"]?.toDouble(),
        voteCount: json["vote_count"],
      );
}
