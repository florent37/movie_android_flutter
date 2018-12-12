import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:mvvm_sample/omdb/OmdbRepository.dart';
import 'package:mvvm_sample/omdb/models/Movie.dart';
import 'package:mvvm_sample/search/SearchViewState.dart';
import 'package:mvvm_sample/search/SearchViewModel.dart';

const OmdbRepository repo = OmdbRepository();

class SearchPage extends StatefulWidget {
  @override
  SearchPageState createState() {
    return new SearchPageState();
  }
}

class SearchPageState extends State<SearchPage> {
  final viewModel = SearchViewModel(repo);

  Movie _currentMovie;
  var _editTextController = TextEditingController();

  void _searchMovie(String name) {
    viewModel.search(name);
  }

  void _changeCurrentMovie(Movie movie) {
    setState(() {
      _currentMovie = movie;
    });
  }

  Widget _currentMovieBackground() {
    if (_currentMovie != null) {
      return Column(mainAxisSize: MainAxisSize.max, children: <Widget>[
        Expanded(
            child: Container(
                constraints: BoxConstraints.expand(),
                color: Colors.black,
                child: new Container(
                  decoration: new BoxDecoration(
                    image: new DecorationImage(
                      image: new NetworkImage(_currentMovie.poster),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: new BackdropFilter(
                    filter: new ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
                    child: new Container(
                      decoration: new BoxDecoration(
                          color: Colors.black45.withAlpha(100)),
                    ),
                  ),
                ))),
      ]);
    } else {
      return Container(
        color: Colors.white,
      );
    }
  }

  Widget _currentMovieHeader() {
    if (_currentMovie != null) {
      return SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              _currentMovie.title.replaceAll(" ", "\n").toUpperCase(),
              style: TextStyle(
                  shadows: [
                    Shadow(
                        offset: Offset(2.0, 2),
                        blurRadius: 2.0,
                        color: Colors.black87)
                  ],
                  color: Colors.white,
                  fontSize: 44,
                  fontFamily: 'Raleway',
                  fontWeight: FontWeight.w700),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 16),
              height: 5,
              width: 30,
              color: Colors.red[200],
            ),
            Text(_currentMovie.type + " (" + _currentMovie.year + ")",
                style: TextStyle(
                    shadows: [
                      Shadow(
                          offset: Offset(2.0, 2),
                          blurRadius: 2.0,
                          color: Colors.black87)
                    ],
                    fontFamily: 'Raleway',
                    fontWeight: FontWeight.normal,
                    color: Colors.white,
                    fontSize: 20))
          ],
        ),
      );
    } else {
      return Container();
    }
  }

  Widget _buildInputText() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Material(
        elevation: 20.0,
        shadowColor: Colors.black,
        color: Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16))),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Row(
            children: [
              Flexible(
                child: TextField(
                  decoration:
                      InputDecoration.collapsed(hintText: "Search movie"),
                  onSubmitted: (text) {
                    _searchMovie(_editTextController.text);
                  },
                  controller: _editTextController,
                ),
              ),
              IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  _searchMovie(_editTextController.text);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildListView(SearchViewState viewmodel) {
    return Container(
      height: 250,
      margin: EdgeInsets.only(bottom: 10),
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, position) {
            var movie = viewmodel.movies[position];
            return Padding(
              padding:
                  const EdgeInsets.only(left: 12.0, right: 12.0, bottom: 20),
              child: GestureDetector(
                onTap: () {
                  _changeCurrentMovie(movie);
                },
                child: AspectRatio(
                  aspectRatio: 10 / 16,
                  child: Card(
                    elevation: 10.0,
                    clipBehavior: Clip.antiAlias,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0))),
                    child: Image.network(
                      movie.poster,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            );
          },
          itemCount: viewmodel.movies.length),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SearchViewState>(
        stream: viewModel.viewState,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var viewmodel = snapshot.data;
            if (_currentMovie == null) {
              _currentMovie =
                  viewmodel.movies.length > 0 ? viewmodel.movies[0] : null;
            }
            return Stack(
              children: [
                _currentMovieBackground(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildInputText(),
                    _currentMovieHeader(),
                  ],
                ),
                Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: _buildListView(viewmodel),
                ),
              ],
            );
          }
        });
  }
}
