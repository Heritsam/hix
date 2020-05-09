part of 'service.dart';

class MovieService {
  static Future<List<Movie>> getMovies(int page, {http.Client client}) async {
//    String url =
//        'https://api.themoviedb.org/3/discover/movie?api_key=$apiKey&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=$page';
    String url = 'https://api.themoviedb.org/3/movie/now_playing?api_key=$apiKey&language=en-US&page=$page';

    client ??= http.Client();

    final response = await client.get(url);

    if (response.statusCode != 200) {
      return [];
    }

    var data = json.decode(response.body);
    List result = data['results'];

    return result.map((item) => Movie.fromJson(item)).toList();
  }

  static Future<List<Movie>> getUpcomingMovies(int page, {http.Client client}) async {
    String url = 'https://api.themoviedb.org/3/movie/upcoming?api_key=$apiKey&language=en-US&page=$page';

    client ??= http.Client();

    final response = await client.get(url);

    if (response.statusCode != 200) {
      return [];
    }

    var data = json.decode(response.body);
    List result = data['results'];

    return result.map((item) => Movie.fromJson(item)).toList();
  }

  static Future<MovieDetail> getMovieDetail(Movie movie,
      {http.Client client}) async {
    String url =
        'https://api.themoviedb.org/3/movie/${movie.id}?api_key=$apiKey&language=en-US';

    client ??= http.Client();

    var response = await client.get(url);
    var data = json.decode(response.body);

    List genres = (data as Map<String, dynamic>)['genres'];
    String language;

    switch ((data as Map<String, dynamic>)['original_language'].toString()) {
      case 'ja':
        language = 'Japanese';
        break;
      case 'en':
        language = 'English';
        break;
      case 'id':
        language = 'Bahasa Indonesia';
        break;
      case 'ko':
        language = 'Japanese';
        break;
    }

    return MovieDetail(movie,
        language: language,
        genres: genres
            .map((item) => (item as Map<String, dynamic>)['name'].toString())
            .toList());
  }

  static Future<List<Credit>> getCredits(int movieId,
      {http.Client client}) async {
    String url =
        'https://api.themoviedb.org/3/movie/$movieId/credits?api_key=$apiKey';

    client ??= http.Client();

    var response = await client.get(url);
    var data = json.decode(response.body);

    print(data);

    return ((data as Map<String, dynamic>)['cast'] as List)
        .map((item) {
          return Credit(
            name: (item as Map<String, dynamic>)['name'],
            profilePath: (item as Map<String, dynamic>)['profile_path'],
          );
        })
        .take(8)
        .toList();
  }
}
