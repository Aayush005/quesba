import 'dart:async';



import 'package:ml_text_recognition/src/model/item_model.dart';

import 'package:ml_text_recognition/src/model/question.dart';
import 'package:ml_text_recognition/src/model/question_list.dart';

import 'api_provider.dart';

class Repository {
  final moviesApiProvider = MovieApiProvider();


  Future<QuestionList> searchQuestion(String type) => moviesApiProvider.searchQuestion(type);

}