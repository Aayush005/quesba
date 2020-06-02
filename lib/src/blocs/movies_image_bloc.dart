

import 'package:ml_text_recognition/src/blocs/base.dart';
import 'package:ml_text_recognition/src/model/movie_image_model.dart';



class MovieImageBloc extends BaseBloc<MovieImageModel> {

  Stream<MovieImageModel> get movieImages => fetcher.stream;

  fetchMovieImages(int movieId) async {
    MovieImageModel itemModel = await repository.fetchMovieImages(movieId);
    fetcher.sink.add(itemModel);
  }
}

final movieImageBloc = MovieImageBloc();