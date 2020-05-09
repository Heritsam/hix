import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:hix/models/model.dart';
import 'package:hix/services/service.dart';
import '../bloc.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  @override
  MovieState get initialState => MovieInitial();

  @override
  Stream<MovieState> mapEventToState(
    MovieEvent event,
  ) async* {
    if (event is FetchMovie) {
      List<Movie> movies = await MovieService.getMovies(1);
      List<Movie> upcomingMovies = await MovieService.getUpcomingMovies(1);

      yield MovieLoaded(movies: movies, upcomingMovies: upcomingMovies);
    }
  }
}
