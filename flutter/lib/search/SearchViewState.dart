
import 'package:mvvm_sample/omdb/models/Movie.dart';

class SearchViewState {
  final List<Movie> movies;
  SearchViewState({this.movies}) : assert(movies != null);
}