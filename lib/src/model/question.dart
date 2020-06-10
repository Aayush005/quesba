import 'package:ml_text_recognition/src/model/question_list.dart';
import 'package:ml_text_recognition/src/todo/base_list.dart';

import 'base_model.dart';

class QuestionModel extends BaseModel {
  int id;
  int premiumSolutionCount;
  int freeSolutionCount;
  int statusCode;
  int subjectId;
  int topicId;
  String title;
  String description;
  bool isIndexable;
  bool isActive;
  String createdDate;

  QuestionModel.fromJson(Map<String, dynamic> parsedJson) {
    id = parsedJson['id'];
    premiumSolutionCount = parsedJson['premiumSolutionCount'];
    freeSolutionCount = parsedJson['freeSolutionCount'];
    statusCode = parsedJson['statusCode'];
    subjectId = parsedJson['subjectId'];
    topicId = parsedJson['topicId'];
    title = parsedJson['title'];
    description = parsedJson['description'];
    createdDate = parsedJson['createdDate'];
    isActive = parsedJson['isActive'];
    isIndexable = parsedJson['isIndexable'];
  }

  static List<QuestionModel> fromJsonArray(List jsonArray) {
    return jsonArray?.map((item) {
      return QuestionModel.fromJson(item);
    })?.toList();
  }
}