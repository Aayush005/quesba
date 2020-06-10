
import 'package:ml_text_recognition/src/blocs/base.dart';
import 'package:ml_text_recognition/src/model/question.dart';
import 'package:ml_text_recognition/src/model/question_list.dart';
import 'package:ml_text_recognition/src/todo/base_list.dart';



class QuestionDetailBloc extends BaseBloc<QuestionList>  {

  Stream<QuestionList> get questionDetail => fetcher.stream;

   searchQuestion(String type) async {
     QuestionList itemModel = await repository.searchQuestion(type);
    fetcher.sink.add(itemModel);
    print("model test");

  }
}

final questionDetailBloc = QuestionDetailBloc();