import 'package:json_annotation/json_annotation.dart';
import 'package:mvvm_sample/omdb/models/Movie.dart';

/// This allows the `SearchResponse` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'SearchResponse.g.dart';

@JsonSerializable()
class SearchResponse {
  @JsonKey(name: "Search")
  List<Movie> movies;

  SearchResponse({this.movies});

  factory SearchResponse.fromJson(Map<String, dynamic> json) => _$SearchResponseFromJson(json);
  Map<String, dynamic> toJson() => _$SearchResponseToJson(this);
}