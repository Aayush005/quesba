import 'package:ml_text_recognition/src/model/question.dart';
import 'package:ml_text_recognition/src/todo/base_list.dart';

import 'base_model.dart';

class QuestionList extends BaseModel {
  List<QuestionModel> question_list;



  QuestionList.fromJson(Map<String, dynamic> parsedJson) {
    question_list = QuestionModel.fromJsonArray(parsedJson["question"]);

  }

}