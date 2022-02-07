import 'dart:convert';

import 'package:practica_final_2/models/models.dart';

class RatedResponse {
    RatedResponse({
        required this.page,
        required this.results,
        required this.totalPages,
        required this.totalResults,
    });

    int page;
    List<Movie> results;
    int totalPages;
    int totalResults;

    factory RatedResponse.fromJson(String str) => RatedResponse.fromMap(json.decode(str));

    factory RatedResponse.fromMap(Map<String, dynamic> json) => RatedResponse(
        page: json["page"],
        results: List<Movie>.from(json["results"].map((x) => Movie.fromMap(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
    );
}