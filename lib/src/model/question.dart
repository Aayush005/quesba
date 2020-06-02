import 'base_model.dart';

class QuestionModel extends BaseModel {
  int id;
  int premiumSolutionCount;
  int freeSolutionCount;
  int statusCode;
  String subjectId;
  String topicId;
  String title;
  String description;
  bool isIndexable;
  bool isActive;
  DateTime createdDate;

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