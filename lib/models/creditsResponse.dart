// ignore_for_file: file_names

import 'dart:convert';

import 'models.dart';

class CreditsResponse {
    CreditsResponse({
        required this.id,
        required this.cast,
    });

    int id;
    List<Cast> cast;

    factory CreditsResponse.fromJson(String str) => CreditsResponse.fromMap(json.decode(str));

    factory CreditsResponse.fromMap(Map<String, dynamic> json) => CreditsResponse(
        id: json["id"],
        cast: List<Cast>.from(json["cast"].map((x) => Cast.fromMap(x))),
    );
}

