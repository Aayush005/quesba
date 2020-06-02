
import 'package:ml_text_recognition/src/blocs/base.dart';
import 'package:ml_text_recognition/src/model/question.dart';



class QuestionDetailBloc extends BaseBloc<QuestionModel> {

  Stream<QuestionModel> get questionDetail => fetcher.stream;

  searchQuestion(String type) async {
    QuestionModel itemModel = await repository.searchQuestion(type);
    fetcher.sink.add(itemModel);
    print("model test");
    print(itemModel.description);
  }
}

final questionDetailBloc = QuestionDetailBloc();