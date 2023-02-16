/*
Clase CreditsResponse que da formato al objeto JSON recibido para poder mapear 
sus atributos y poder así llenar la App con el reparto de actores. Se crean las
distintas clases con sus métodos setter y getter de los objetos recibidos.
*/

import 'models.dart';

//Clase principal con su método constructor
class CreditsResponse {
  CreditsResponse({
    required this.id,
    required this.cast,
  });

//Variables locales de clase
  int id;
  List<Cast>
      cast; //Variable que almacena todos los actores recibidos en la llamada http

//Métodos fromJson y fromMap para mapear el cuerpo del JSON obtenido
  factory CreditsResponse.fromJson(String str) =>
      CreditsResponse.fromMap(json.decode(str));

  factory CreditsResponse.fromMap(Map<String, dynamic> json) => CreditsResponse(
        id: json["id"],
        cast: List<Cast>.from(json["cast"].map((x) => Cast.fromMap(x))),
      );
}
