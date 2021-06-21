import 'dart:convert';

import 'package:movies/Util/constants.dart';
import 'package:http/http.dart' as http;
import 'package:movies/model/movie_response.dart';
import 'package:movies/model/tv_show_response.dart';


class ApiHelper {
  static Future<MoviesResponse> getPopularMovies() async {
    var res = await http
        .get(Uri.parse(Constants.movieBaseUrl + "/popular" + Constants.apiKey));
    if (res.statusCode == 200) {
      return MoviesResponse.fromJson(json.decode(res.body));
    } else {
      return MoviesResponse(page: 0, results: [], totalPages: 0, totalResults: 0);
    }
  }

  static Future<TvShowsResponse> getPopularTvShows() async {
    var res = await http
        .get(Uri.parse(Constants.TvShowBaseUrl + "/popular" + Constants.apiKey));
    if (res.statusCode == 200) {
      return TvShowsResponse.fromJson(json.decode(res.body));
    } else {
      return TvShowsResponse(page: 0, results: [], totalPages: 0, totalResults: 0);
    }
  }

  static Future<MoviesResponse> findMovies(String query) async {
    var res = await http
        .get(Uri.parse(Constants.movieSearchBase + Constants.apiKey + Constants.queryPrefix + query));
    if (res.statusCode == 200) {
      return MoviesResponse.fromJson(json.decode(res.body));
    } else {
      return MoviesResponse(page: 0, results: [], totalPages: 0, totalResults: 0);
    }
  }

  static Future<TvShowsResponse> findTvShows(String query) async {
    var res = await http
        .get(Uri.parse(Constants.tvShowSearchBase + Constants.apiKey + Constants.queryPrefix + query));
    if (res.statusCode == 200) {
      return TvShowsResponse.fromJson(json.decode(res.body));
    } else {
      return TvShowsResponse(page: 0, results: [], totalPages: 0, totalResults: 0);
    }
  }
}


