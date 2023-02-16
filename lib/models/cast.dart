/* 
Clase Cast con sus métodos que es invocada desde cualquier Widget con el fin de encapsular
sus atributos y métodos y estructurar mejor el código, favoreciendo su mantenimento.
*/

import 'models.dart';

//Método constructor
class Cast {
  Cast({
    required this.adult,
    required this.gender,
    required this.id,
    required this.knownForDepartment,
    required this.name,
    required this.popularity,
    required this.profilePath,
    required this.character,
    required this.originalName,
    required this.creditId,
    required this.order,
    required this.castId,
    this.department,
    required this.job,
  });

//Método getter que devuelve el String con la imagen de los actores que intervienen en una película determinada
  get fullProfilePath {
    if (profilePath != 0) {
      return 'https://image.tmdb.org/t/p/w500$profilePath';
    } else {
      //Si la consulta no contiene la imagen del actor, se muestra una imagen por defecto.
      return 'https://i.stack.imgur.com/GNhxO.png';
    }
  }

//Zona de declaración de atributos de la clase (obtenidos del cuerpo del JSON)
  bool adult;
  int gender;
  int id;
  String knownForDepartment;
  String name;
  String originalName;
  double popularity;
  String? profilePath;
  int? castId;
  String? character;
  String creditId;
  int? order;
  String? department;
  String? job;

//Métodos fromJson y fromMap para mapear el cuerpo del JSON obtenido
  factory Cast.fromJson(String str) => Cast.fromMap(json.decode(str));

  factory Cast.fromMap(Map<String, dynamic> json) => Cast(
        adult: json["adult"],
        gender: json["gender"],
        id: json["id"],
        knownForDepartment: json["known_for_department"],
        name: json["name"],
        originalName: json["original_name"],
        popularity: json["popularity"]?.toDouble(),
        profilePath: json["profile_path"],
        castId: json["cast_id"],
        character: json["character"],
        creditId: json["credit_id"],
        order: json["order"],
        department: json["department"],
        job: json["job"],
      );
}
