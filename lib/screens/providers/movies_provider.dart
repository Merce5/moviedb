import 'package:flutter/cupertino.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:practica_final_2/models/credits_response.dart';
import 'package:practica_final_2/models/models.dart';
import 'package:practica_final_2/models/movie.dart';
import 'package:practica_final_2/models/now_playing_response.dart';
import 'package:practica_final_2/models/populars_response.dart';
import 'package:practica_final_2/models/rated_response.dart';
import 'package:practica_final_2/models/search_response.dart';
import 'package:practica_final_2/models/upcoming_response.dart';

class MoviesProvider extends ChangeNotifier {
  String _baseUrl = 'api.themoviedb.org';
  String _apiKey = 'bd5e8190ec48ff95b2d91b8041d3ac66';
  String _language = 'es-ES';
  String _page = '1';
  int pagePopulars = 1;
  int pageRated = 1;
  int pageUpcoming = 1;

  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies = [];
  List<Movie> ratedMovies = [];
  List<Movie> upcomingMovies = [];
  Map<int, List<Cast>> casting = {};

  MoviesProvider() {
    print('Provider inicialitzat');
    this.getOnDisplayMovies();
    this.getPopularMovies();
    this.getRatedMovies();
    this.getUpcomingMovies();
  }

  getOnDisplayMovies() async {
    print('getOnDisplayMovies');
    var url = Uri.https(_baseUrl, '/3/movie/now_playing',
        {'api_key': _apiKey, 'language': _language, 'page': _page});

    // Await the http get response, then decode the json-formatted response.
    final result = await http.get(url);
    final nowPlayingResponse = NowPlayingResponse.fromJson(result.body);
    onDisplayMovies = nowPlayingResponse.results;

    notifyListeners();
  }

  getPopularMovies() async {
    print('getPopularMovies');
    var url = Uri.https(_baseUrl, '/3/movie/popular',
        {'api_key': _apiKey, 'language': _language, 'page': '$pagePopulars'});
    pagePopulars++;
    // Await the http get response, then decode the json-formatted response.
    final result = await http.get(url);
    final popularResponse = PopularsResponse.fromJson(result.body);
    popularMovies = [...popularMovies, ...popularResponse.results];

    notifyListeners();
  }

  getRatedMovies() async {
    print('getRatedMovies');
    var url = Uri.https(_baseUrl, '/3/movie/top_rated',
        {'api_key': _apiKey, 'language': _language, 'page': '$pageRated'});
    pageRated++;
    // Await the http get response, then decode the json-formatted response.
    final result = await http.get(url);
    final ratedResponse = RatedResponse.fromJson(result.body);
    ratedMovies = [...ratedMovies, ...ratedResponse.results];

    notifyListeners();
  }

  getUpcomingMovies() async {
    print('getUpcomingMovies');
    var url = Uri.https(_baseUrl, '/3/movie/upcoming',
        {'api_key': _apiKey, 'language': _language});
    pageUpcoming++;
    // Await the http get response, then decode the json-formatted response.
    final result = await http.get(url);
    final upcomingResponse = UpcomingResponse.fromJson(result.body);
    upcomingMovies = [...upcomingMovies, ...upcomingResponse.results];

    notifyListeners();
  }

  Future<List<Cast>> getMovieCast(int idMovie) async {
    var url = Uri.https(_baseUrl, '/3/movie/$idMovie/credits',
        {'api_key': _apiKey, 'language': _language, 'page': _page});
    final result = await http.get(url);
    final creditsResponse = CreditsResponse.fromJson(result.body);

    casting[idMovie] = creditsResponse.cast;
    return creditsResponse.cast;
  }

  Future<List<Movie>> getOnDisplaySearch(String query) async {
    print('getOnDisplayPopularMovies');
    var url = Uri.https(_baseUrl, '/3/search/movie',
        {'api_key': _apiKey, 'language': _language, 'query': query});

    final result = await http.get(url);

    final searchResponse = SearchResponse.fromJson(result.body);

    return searchResponse.results;
  }
}
