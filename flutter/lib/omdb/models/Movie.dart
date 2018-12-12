import 'package:json_annotation/json_annotation.dart';

/// This allows the `Movie` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'Movie.g.dart';

@JsonSerializable()
class Movie {
  @JsonKey(name: "Title")
  final String title;
  @JsonKey(name: "Year")
  final String year;
  @JsonKey(name: "ImdbID")
  final String imdbID;
  @JsonKey(name: "Type")
  final String type;
  @JsonKey(name: "Poster")
  final String poster;

  Movie({this.title, this.year, this.imdbID, this.type, this.poster});

  factory Movie.fromJson(Map<String, dynamic> json) => _$MovieFromJson(json);
  Map<String, dynamic> toJson() => _$MovieToJson(this);
    
}