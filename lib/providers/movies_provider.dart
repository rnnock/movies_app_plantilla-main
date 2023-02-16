//Clase MoviesProvider que se crea para almacenar las listas con el contenido de las películas en formato de objeto

import 'package:flutter/cupertino.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

import '../models/models.dart';

class MoviesProvider extends ChangeNotifier {
  //Variables creadas para las consultas al provider y así recibir la información solicitada a los distintos end points en formato JSON
  String _baseUrl = 'api.themoviedb.org'; //API del Provider
  String _apiKey = '6806871fddc11734d8766d24c4b7cefc'; //Token de validación
  String _language = 'es-ES';
  String _page = '1';

  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies = [];

  Map<int, List<Cast>> casting = {};

  MoviesProvider() {
    this.getOnDisplayMovies();
    this.getPopularMovies();
  }
//Método que hace una petición http y espera un JSON con la información solicitada
//Método que recibe una lista en formato JSON de las películas que actualmente están en cartelera
//Se declara el método async para que no se quede esperando a recibir la respuesta del http
  getOnDisplayMovies() async {
    var url = Uri.https(_baseUrl, '3/movie/now_playing',
        {'api_key': _apiKey, 'language': _language, 'page': _page});

    // Await the http get response, then decode the json-formatted response.
    //Creación de la variable final result que almacena el objeto JSON del get solicitado

    final result = await http.get(
        url); //Cláusula await que espera para que cuando se reciba la respuesta de la petición, se le asigne el valor a la variable result
    if (result.statusCode == 200) {
      //Se asigna a la variable final nowPlayinigResponse el resultado del contructor nombrado fromJson con parámetro tipo string result (string con el contenido del JSON)
      final nowPlayingResponse = NowPlayingResponse.fromJson(result.body);
      onDisplayMovies = nowPlayingResponse
          .results; //Asignación del valor con la lista de películas
      notifyListeners(); //Método que notifica a todo el árbol de Widgets de que se ha producido un cambio, ejecutando de nuevo el build por completo (repintando la App)
    } else {
      print('Request failed with status: ${result.statusCode}.');
    }
  }

  getPopularMovies() async {
    var url = Uri.https(_baseUrl, '3/movie/popular',
        {'api_key': _apiKey, 'language': _language, 'page': _page});

    // Await the http get response, then decode the json-formatted response.
    final result = await http.get(url);

    final popularMoviesResponse = PopularMoviesResponse.fromJson(result.body);
    popularMovies = popularMoviesResponse.results;
    notifyListeners();
  }

  Future<List<Cast>> getMovieCast(int idMovie) async {
    var url = Uri.https(_baseUrl, '3/movie/$idMovie/credits',
        {'api_key': _apiKey, 'language': _language});

    // Await the http get response, then decode the json-formatted response.
    final result = await http.get(url);

    final creditsResponse = CreditsResponse.fromJson(result.body);

    casting[idMovie] = creditsResponse.cast;

    return creditsResponse.cast;
  }
}
