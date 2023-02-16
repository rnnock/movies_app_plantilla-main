//Clase MoviesProvider que se crea para almacenar las listas con el contenido de las películas en formato de objeto

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../models/models.dart';

class MoviesProvider extends ChangeNotifier {
  /*
  Variables creadas para las consultas al provider y así recibir la información solicitada a los
  distintos end points en formato JSON
   */
  final String _baseUrl = 'api.themoviedb.org'; //API del Provider
  final String _apiKey =
      '6806871fddc11734d8766d24c4b7cefc'; //Token de validación
  final String _language = 'es-ES';
  final String _page = '1';

  List<Movie> onDisplayMovies = []; //Películas en cartelera
  List<Movie> popularMovies = []; //Películas populares

  Map<int, List<Cast>> casting = {}; //Reparto de actores

//Método MoviesProvider instanciado para rellenar el HomePage con la información de películas
  MoviesProvider() {
    getOnDisplayMovies();
    getPopularMovies();
  }

  /*
  Método asíncrono que realiza una petición http y espera recibir una lista en formato JSON con
  la información de las películas que están actualmente en cartelera. Se declara el método async
  para que no se quede esperando a recibir la respuesta de la llamada http.
  */
  getOnDisplayMovies() async {
    var url = Uri.https(_baseUrl, '3/movie/now_playing',
        {'api_key': _apiKey, 'language': _language, 'page': _page});

    /*
    Creación de la variable final 'result', que almacena el objeto JSON del get solicitado.
    Se incluye la cláusula 'await', que espera para que cuando se reciba la respuesta de la petición,
    se le asigne el valor a la variable result.
    */
    final result = await http.get(url);
    if (result.statusCode == 200) {
      /*
      Se asigna a la variable final nowPlayinigResponse el resultado del contructor nombrado fromJson
      con parámetro tipo String result (String con el contenido/body del JSON)
      */
      final nowPlayingResponse = NowPlayingResponse.fromJson(result.body);

      //Asignación del valor con la lista de películas
      onDisplayMovies = nowPlayingResponse.results;

      /*
      Método que notifica a todo el árbol de Widgets de que se ha producido un cambio, ejecutando de
      nuevo el build por completo (repintando la App)
      */
      notifyListeners();
    } else {
      print('Request failed with status: ${result.statusCode}.');
    }
  }

  /*
  Método asíncrono que realiza una petición http y espera recibir una lista en formato JSON con
  la información de las películas más populares. Se declara el método async para que no se quede
  esperando a recibir la respuesta de la llamada http.
  */
  getPopularMovies() async {
    var url = Uri.https(_baseUrl, '3/movie/popular',
        {'api_key': _apiKey, 'language': _language, 'page': _page});

    /*
    Creación de la variable final 'result', que almacena el objeto JSON del get solicitado.
    Se incluye la cláusula 'await', que espera para que cuando se reciba la respuesta de la petición,
    se le asigne el valor a la variable result.
    */
    final result = await http.get(url);

    /*
    Se asigna a la variable final popularMoviesResponse el resultado del contructor nombrado fromJson
    con parámetro tipo String result (String con el contenido/body del JSON)
    */
    final popularMoviesResponse = PopularMoviesResponse.fromJson(result.body);

    //Asignación del valor con la lista de películas
    popularMovies = popularMoviesResponse.results;

    /*
    Método que notifica a todo el árbol de Widgets de que se ha producido un cambio, ejecutando de
    nuevo el build por completo (repintando la App)
    */
    notifyListeners();
  }

  /*
  Método asíncrono que realiza una petición http y espera recibir una lista en formato JSON con la información
  del reparto de actores para una película determinada por parámetro. Se declara el método async para que no se
  quede esperando a recibir la respuesta de la llamada http.

    @arguments idMovie: int con el ID de la película deseada.
    @return Future<List<Cast>>: listado del reparto de actores.
  */
  Future<List<Cast>> getMovieCast(int idMovie) async {
    var url = Uri.https(_baseUrl, '3/movie/$idMovie/credits',
        {'api_key': _apiKey, 'language': _language});

    /*
    Creación de la variable final 'result', que almacena el objeto JSON del get solicitado.
    Se incluye la cláusula 'await', que espera para que cuando se reciba la respuesta de la petición,
    se le asigne el valor a la variable result.
    */
    final result = await http.get(url);

    /*
    Se asigna a la variable final creditsResponse el resultado del contructor nombrado fromJson
    con parámetro tipo String result (String con el contenido/body del JSON)
    */
    final creditsResponse = CreditsResponse.fromJson(result.body);

    //Asignación del valor con la lista de actores para un índice recibido por parámetro.
    casting[idMovie] = creditsResponse.cast;

    return creditsResponse.cast;
  }
}
