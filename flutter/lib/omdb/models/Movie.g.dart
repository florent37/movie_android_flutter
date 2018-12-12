// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Movie.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Movie _$MovieFromJson(Map<String, dynamic> json) {
  return Movie(
      title: json['Title'] as String,
      year: json['Year'] as String,
      imdbID: json['ImdbID'] as String,
      type: json['Type'] as String,
      poster: json['Poster'] as String);
}

Map<String, dynamic> _$MovieToJson(Movie instance) => <String, dynamic>{
      'Title': instance.title,
      'Year': instance.year,
      'ImdbID': instance.imdbID,
      'Type': instance.type,
      'Poster': instance.poster
    };
