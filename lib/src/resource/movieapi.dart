import 'dart:async';
import 'dart:convert';
import 'package:fluttertask/src/model/item_model.dart';
import 'package:http/http.dart' show Client;
import 'package:http/http.dart' as http;

class MovieApiProvider {
  Client client = Client();

  var url = Uri.parse("http://api.themoviedb.org/3/movie/popular?api_key=9f89def99f515606ba79c720a33e3d4c");

  Future<ItemModel> fetchMovieList() async {
    print("entered");

    var response = await http
        .get(url, headers: {"Accept": "application/json"});
    print(response.body.toString());
    if (response.statusCode == 200) {
      return ItemModel.fromJson(json.decode(response.body));
    } else {

      throw Exception('Failed to load post');
    }
  }
}