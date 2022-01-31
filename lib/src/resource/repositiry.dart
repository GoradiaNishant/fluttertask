import 'dart:async';
import 'package:fluttertask/src/model/item_model.dart';
import 'movieapi.dart';

class Repository {

  final moviesApiProvider = MovieApiProvider();

  Future fetchAllMovies() => moviesApiProvider.fetchMovieList();

}