import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mvvm_sample/omdb/models/Movie.dart';
import 'package:mvvm_sample/omdb/models/SearchResponse.dart';

class OmdbRepository {
  final apiKey = "86850a46";
  const OmdbRepository();

  Future<List<Movie>> searchMovies(String byName) async {
    final response = await http.get('http://www.omdbapi.com/?s=$byName&apikey=$apiKey');
    final jsonValue = json.decode(response.body);
    return SearchResponse.fromJson(jsonValue).movies;
  }
}