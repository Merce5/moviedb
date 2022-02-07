import 'package:flutter/cupertino.dart';

import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:practica_final_2/models/populars_response.dart';
import 'package:practica_final_2/models/credits_response.dart';
import 'package:practica_final_2/models/models.dart';

class MoviesProvider extends ChangeNotifier {
  String page = "1";
  String _baseUrl = 'api.themoviedb.org';
  String _apiKey = '0378aa288a22271e7f44a1e6986417c0';
  String _language = 'es-ES';
  

  List<Movie> onDisplayMovie = [];
  List<Movie> onDisplayPopulars = [];

  Map<int, List<Cast>> casting = {};

  MoviesProvider(this.page) {
    print('Movies Provider inicialitzat!');
    this.getOnDisplayMovies(page);
    this.getOnDisplayPopularMovies(page);
    print(page);
  }

  MoviesProvider.refresh(this.page) {
    this.getOnDisplayPopularMovies(page);
    print(page);
  }

  getOnDisplayMovies(String page) async {
    print('getOnDisplayMovies');
    var url = Uri.https(_baseUrl, '3/movie/now_playing',
    {'api_key': _apiKey, 'language': _language, 'page': page});

    final result = await http.get(url);

    final nowPlayingResponse = NowPlayingResponse.fromJson(result.body);

    onDisplayMovie = nowPlayingResponse.results;

    notifyListeners();
  }

  getOnDisplayPopularMovies(String page) async {
    print('getOnDisplayPopularMovies');
    var url = Uri.https(_baseUrl, '3/movie/now_playing',
    {'api_key': _apiKey, 'language': _language, 'page': page});

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
