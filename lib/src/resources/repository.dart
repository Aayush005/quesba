import 'dart:async';



import 'package:ml_text_recognition/src/model/item_model.dart';
import 'package:ml_text_recognition/src/model/movie_detail_model.dart';
import 'package:ml_text_recognition/src/model/movie_image_model.dart';
import 'package:ml_text_recognition/src/model/question.dart';
import 'package:ml_text_recognition/src/model/question_list.dart';

import 'api_provider.dart';

class Repository {
  final moviesApiProvider = MovieApiProvider();

  Future<MovieDetailModel> fetchMovieDetail(int movieId) => moviesApiProvider.fetchMovieDetail(movieId);

  Future<MovieImageModel> fetchMovieImages(int movieId) => moviesApiProvider.fetchMovieImages(movieId);

  Future<ItemModel> fetchMovieList(String type) => moviesApiProvider.fetchMovieList(type);

  Future<QuestionList> searchQuestion(String type) => moviesApiProvider.searchQuestion(type);

}