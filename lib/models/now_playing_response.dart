/*
Clase NowPlayingResponse que da formato al objeto JSON recibido para poder mapear 
sus atributos y poder así llenar la App con las películas que actualmente están en
cartelera. Se crean las distintas clases con sus métodos setter y getter de los
objetos recibidos.
*/

import 'models.dart'; //Haciendo un único import, se reciben todos los exports del fichero models.dart

//Clase principal con su método constructor
class NowPlayingResponse {
  NowPlayingResponse({
    required this.dates,
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

//Variables locales de clase
  Dates dates;
  int page;
  List<Movie>
      results; //Variable que almacena todas las peliculas recibidas en la llamada http
  int totalPages;
  int totalResults;

  factory NowPlayingResponse.fromJson(String str) =>
      NowPlayingResponse.fromMap(json.decode(str));

  factory NowPlayingResponse.fromMap(Map<String, dynamic> json) =>
      NowPlayingResponse(
        dates: Dates.fromMap(json["dates"]),
        page: json["page"],
        results: List<Movie>.from(json["results"].map((x) => Movie.fromMap(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );
}

//Clase Dates con su constructor y atributos
class Dates {
  Dates({
    required this.maximum,
    required this.minimum,
  });

  DateTime maximum;
  DateTime minimum;

//Métodos fromJson y fromMap para mapear el cuerpo del JSON obtenido
  factory Dates.fromJson(String str) => Dates.fromMap(json.decode(str));

  factory Dates.fromMap(Map<String, dynamic> json) => Dates(
        maximum: DateTime.parse(json["maximum"]),
        minimum: DateTime.parse(json["minimum"]),
      );
}
