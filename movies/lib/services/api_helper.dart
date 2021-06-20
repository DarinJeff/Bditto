import 'dart:convert';

import 'package:movies/Util/constants.dart';
import 'package:http/http.dart' as http;
import 'package:movies/model/popular_movies.dart';
import 'package:movies/model/popular_tv_shows.dart';


class ApiHelper {
  static Future<PopularMovies> getPopularMovies() async {
    var res = await http
        .get(Uri.parse(Constants.movieBaseUrl + "/popular" + Constants.apiKey));
    if (res.statusCode == 200) {
      return PopularMovies.fromJson(json.decode(res.body));
    } else {
      return PopularMovies(page: 0, results: [], totalPages: 0, totalResults: 0);
    }
  }

  static Future<PopularTvShows> getPopularTvShows() async {
    var res = await http
        .get(Uri.parse(Constants.TvShowBaseUrl + "/popular" + Constants.apiKey));
    if (res.statusCode == 200) {
      return PopularTvShows.fromJson(json.decode(res.body));
    } else {
      return PopularTvShows(page: 0, results: [], totalPages: 0, totalResults: 0);
    }
  }

}


