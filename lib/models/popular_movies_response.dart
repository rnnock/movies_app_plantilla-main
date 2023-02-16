/*
Clase PopularMoviesResponse que da formato al objeto JSON recibido para poder mapear 
sus atributos y poder así llenar la App con las películas más populares. Se crean las
distintas clases con sus métodos setter y getter de los objetos recibidos.
*/

import 'models.dart';

//Clase principal con su método constructor
class PopularMoviesResponse {
  PopularMoviesResponse({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

//Variables locales de clase
  int page;
  List<Movie>
      results; //Variable que almacena todas las peliculas recibidas en la llamada http
  int totalPages;
  int totalResults;

//Métodos fromJson y fromMap para mapear el cuerpo del JSON obtenido
  factory PopularMoviesResponse.fromJson(String str) =>
      PopularMoviesResponse.fromMap(json.decode(str));

  factory PopularMoviesResponse.fromMap(Map<String, dynamic> json) =>
      PopularMoviesResponse(
        page: json["page"],
        results: List<Movie>.from(json["results"].map((x) => Movie.fromMap(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );
}
