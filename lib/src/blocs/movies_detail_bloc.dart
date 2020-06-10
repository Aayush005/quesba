
import 'package:ml_text_recognition/src/model/movie_detail_model.dart';


import 'base.dart';


class MovieDetailBloc extends BaseBloc<MovieDetailModel> {

  Stream<MovieDetailModel> get movieDetail => fetcher.stream;

  fetchMovieDetail(int movieId) async {
    MovieDetailModel itemModel = await repository.fetchMovieDetail(movieId);
    fetcher.sink.add(itemModel);

  }
}



final movieDetailBloc = MovieDetailBloc();