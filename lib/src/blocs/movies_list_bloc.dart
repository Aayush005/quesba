
import 'package:ml_text_recognition/src/blocs/base.dart';
import 'package:ml_text_recognition/src/model/item_model.dart';
import 'package:rxdart/rxdart.dart';


class MovieListBloc extends BaseBloc<ItemModel> {

  Stream<ItemModel> get movieList => fetcher.stream;

  fetchMovieList(String type) async {
    ItemModel itemModel = await repository.fetchMovieList(type);
    fetcher.sink.add(itemModel);
  }
}

final movieListBloc = MovieListBloc();