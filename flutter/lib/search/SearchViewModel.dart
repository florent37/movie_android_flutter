import 'package:mvvm_sample/omdb/OmdbRepository.dart';
import 'package:mvvm_sample/search/SearchViewState.dart';
import 'dart:async';

class SearchViewModel {
  //Stream <=> MediatorLiveData
  final StreamController<SearchViewState> _viewModelController = StreamController();
  final OmdbRepository _repository;

  //Stream <=> LiveData
  Stream<SearchViewState> get viewState => _viewModelController.stream;

  //constructor
  SearchViewModel(this._repository) {
    _start();
  }

  void _start(){
    this.search("avengers");
  }

  void search(String name) async {
    var movies = await _repository.searchMovies(name);
    _viewModelController.add(SearchViewState(movies: movies));
  }

}