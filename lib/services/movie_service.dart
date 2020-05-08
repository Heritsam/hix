part of 'service.dart';

class MovieService {
  static Future<List<Movie>> getMovies(int page, {http.Client client}) async {
    String url =
        'https://api.themoviedb.org/3/discover/movie?api_key=$apiKey&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=$page';

    client ??= http.Client();

    final response = await client.get(url);

    if (response.statusCode != 200) {
      return [];
    }

    var data = json.decode(response.body);
    List result = data['results'];

    return result.map((item) => Movie.fromJson(item)).toList();
  }
}
