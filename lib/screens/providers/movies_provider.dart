import 'package:flutter/cupertino.dart';

import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:practica_final_2/models/PopularsResponse.dart';
import 'package:practica_final_2/models/creditsResponse.dart';
import 'package:practica_final_2/models/models.dart';

class MoviesProvider extends ChangeNotifier {
  String _baseUrl = 'api.themoviedb.org';
  String _apiKey = '0378aa288a22271e7f44a1e6986417c0';
  String _language = 'es-ES';
  String _page = '1';

  List<Movie> onDisplayMovie = [];
  List<Movie> onDisplayPopulars = [];

  Map<int, List<Cast>> casting = {};

  MoviesProvider() {
    print('Movies Provider inicialitzat!');
    this.getOnDisplayMovies();
    this.getOnDisplayPopularMovies();
  }

  getOnDisplayMovies() async {
    print('getOnDisplayMovies');
    var url = Uri.https(_baseUrl, '3/movie/now_playing',
    {'api_key': _apiKey, 'language': _language, 'page': _page});

    final result = await http.get(url);

    final nowPlayingResponse = NowPlayingResponse.fromJson(result.body);

    onDisplayMovie = nowPlayingResponse.results;

    notifyListeners();
  }

  getOnDisplayPopularMovies() async {
    print('getOnDisplayPopularMovies');
    var url = Uri.https(_baseUrl, '3/movie/now_playing',
    {'api_key': _apiKey, 'language': _language, 'page': _page});

    final result = await http.get(url);

    final popularsResponse = PopularsResponse.fromJson(result.body);

    onDisplayPopulars = popularsResponse.results;

    notifyListeners();
  }

  Future <List<Cast>> getMovieCast(int movieID) async {
    print('getMovieCast');

    var url = Uri.https(_baseUrl, '3/movie/${movieID}/credits',
    {'api_key': _apiKey, 'language': _language});

    final result = await http.get(url);

    final creditsResponse = CreditsResponse.fromJson(result.body);

    casting[movieID] = creditsResponse.cast;

    return creditsResponse.cast;
  }
}
