import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movies/model/movie_response.dart';
import 'package:movies/model/tv_show_response.dart';
import 'package:movies/services/api_helper.dart';
import 'package:movies/pages/error.dart';
import 'package:movies/widgets/movie_grid.dart';
import 'package:movies/widgets/tv_show_grid.dart';

class MovieSearch extends SearchDelegate<void> {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(
        Icons.arrow_back,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder(
      future: ApiHelper.findMovies(query),
      builder: (BuildContext context, AsyncSnapshot<MoviesResponse> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.connectionState == ConnectionState.done) {
          print(snapshot.data);
          return ((snapshot.data?.results?.length ?? 0) > 0)
              ? MovieGrid(movies: snapshot.data)
              : Center(
                  child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const <Widget>[
                    SizedBox(
                      width: 50,
                      height: 50,
                      child: Icon(
                        FontAwesomeIcons.sadTear,
                        size: 50,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20.0),
                      child: Text(
                        'No matching results found',
                        style: TextStyle(fontSize: 20),
                      ),
                    )
                  ],
                ));
        } else {
          return Error(
              errorMessage: "Something went wrong",
              onRetryPressed: () {
                close(context, null);
              });
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Center(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: const <Widget>[
        SizedBox(
          width: 50,
          height: 50,
          child: Icon(
            Icons.search,
            size: 50,
          ),
        ),
        Text('Enter a Movie to search.')
      ],
    ));
  }
}

class TvShowSearch extends SearchDelegate<void> {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(
        Icons.arrow_back,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder(
      future: ApiHelper.findTvShows(query),
      builder: (BuildContext context, AsyncSnapshot<TvShowsResponse> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.connectionState == ConnectionState.done) {
          print(snapshot.data);
          return ((snapshot.data?.results?.length ?? 0) > 0)
              ? TvShowGrid(shows: snapshot.data)
              : Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const <Widget>[
                  SizedBox(
                    width: 50,
                    height: 50,
                    child: Icon(
                      FontAwesomeIcons.sadTear,
                      size: 50,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20.0),
                    child: Text(
                      'No matching results found',
                      style: TextStyle(fontSize: 20),
                    ),
                  )
                ],
              ));
        } else {
          return Error(
              errorMessage: "Something went wrong",
              onRetryPressed: () {
                close(context, null);
              });
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            SizedBox(
              width: 50,
              height: 50,
              child: Icon(
                Icons.search,
                size: 50,
              ),
            ),
            Text('Enter a TV Show to search.')
          ],
        ));
  }
}
