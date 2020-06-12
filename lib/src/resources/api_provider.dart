import 'dart:async';
import 'dart:convert';


import 'package:http/http.dart' show Client;
import 'package:ml_text_recognition/src/model/item_model.dart';

import 'package:ml_text_recognition/src/model/question.dart';
import 'package:ml_text_recognition/src/model/question_list.dart';

class MovieApiProvider {
  Client client = Client();



  Future<QuestionList> searchQuestion(String type) async {

    final response = await client.post('http://apitesting.quesba.com/question/Search',headers: { "x-api-key":"e67c01f9-263b-47cb-a249-bf09067c9e68","Content-Type":"application/json"}, body: json.encode(type));

    print("Test Api");
    print(response.request.url);
    print(response.body.toString());
    print("End Test");

    if (response.statusCode == 200) {
      return QuestionList.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load post');
    }
  }

}