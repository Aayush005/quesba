import 'dart:async';
import 'dart:convert';


import 'package:http/http.dart' show Client;
import 'package:ml_text_recognition/src/model/item_model.dart';
import 'package:ml_text_recognition/src/model/movie_detail_model.dart';
import 'package:ml_text_recognition/src/model/movie_image_model.dart';
import 'package:ml_text_recognition/src/model/question.dart';

class MovieApiProvider {
  Client client = Client();
  final _apiKey = '802b2c4b88ea1183e50e6b285a27696e';

  Future<ItemModel> fetchMovieList(String type) async {
    final response = await client
        .get("http://api.themoviedb.org/3/movie/$type?api_key=$_apiKey");
//    print(response.request.url);
//    print(response.body.toString());
    if (response.statusCode == 200) {
      return ItemModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load post');
    }
  }

  Future<MovieDetailModel> fetchMovieDetail(int movieId) async {
    final response = await client
        .get("http://api.themoviedb.org/3/movie/$movieId?api_key=$_apiKey");
    // print(response.body.toString());
    if (response.statusCode == 200) {
      return MovieDetailModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load post');
    }
  }


  Future<MovieImageModel> fetchMovieImages(int movieId) async {
    final response = await client
        .get("http://api.themoviedb.org/3/movie/$movieId/images?api_key=$_apiKey");
    //  print(response.body.toString());
    if (response.statusCode == 200) {
      return MovieImageModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load post');
    }
  }

  Future<QuestionModel> searchQuestion(String type) async {



    final response = await client.post('http://apitesting.quesba.com/question/Search',headers: { "x-api-key":"e67c01f9-263b-47cb-a249-bf09067c9e68","Content-Type":"application/json"}, body: json.encode(type));

    print("Test Api");
    print(response.request.url);
    print(response.body.toString());
    print("End Test");
//    print(response.body.toString());
//    print(response.body.toString());
//    print(response.body.toString());
    if (response.statusCode == 200) {
      return QuestionModel.fromJson(json.decode(response.body.toString()));
    } else {
      throw Exception('Failed to load post');
    }
  }
}