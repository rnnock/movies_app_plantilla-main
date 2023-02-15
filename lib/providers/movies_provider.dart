import 'package:flutter/cupertino.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

import '../models/models.dart';

class MoviesProvider extends ChangeNotifier {
  String _baseUrl = 'api.themoviedb.org';
  String _apiKey = '6806871fddc11734d8766d24c4b7cefc';
  String _language = 'es-ES';
  String _page = '1';

  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies = [];

  Map<int, List<Cast>> casting = {};

  MoviesProvider() {
    this.getOnDisplayMovies();
    this.getPopularMovies();
  }

  getOnDisplayMovies() async {
    var url = Uri.https(_baseUrl, '3/movie/now_playing',
        {'api_key': _apiKey, 'language': _language, 'page': _page});

    // Await the http get response, then decode the json-formatted response.
    final result = await http.get(url);

    final nowPlayingResponse = NowPlayingResponse.fromJson(result.body);
    onDisplayMovies = nowPlayingResponse.results;
    notifyListeners();
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
