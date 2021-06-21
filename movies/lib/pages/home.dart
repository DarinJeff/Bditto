import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:movies/controller/app_state.dart';
import 'package:movies/model/tv_show_response.dart';
import 'package:movies/pages/error.dart';
import 'package:movies/model/movie_response.dart';
import 'package:movies/pages/search_results.dart';
import 'package:movies/services/api_helper.dart';
import 'package:movies/widgets/movie_grid.dart';
import 'package:movies/widgets/tv_show_grid.dart';

GetIt getIt = GetIt.instance;

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home>{
  final AppState appState = getIt.get<AppState>();
  late Future<MoviesResponse> movies;
  late Future<TvShowsResponse> shows;

  @override
  void initState() {
    super.initState();
    movies = ApiHelper.getPopularMovies();
    shows = ApiHelper.getPopularTvShows();
    appState.homeStateStream.listen((status) {
      if (status == HomeStatus.retry) {
        appState.setHomeStatus(HomeStatus.loading);
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Color color = Colors.orange;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "Show  Time",
            style: TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.bold,
              fontFamily: 'DelaGothicOne',
              letterSpacing: 1
            ),
          ),
          actions: [IconButton(
            icon: Icon(Icons.search, color: color),
            onPressed: () async {
                if((DefaultTabController.of(context)?.index ?? 0) == 0){
                  await showSearch(
                      context: context,
                      delegate: MovieSearch());
                } else {
                  await showSearch(
                      context: context,
                      delegate: TvShowSearch());
                }

            },
          )],
          bottom: TabBar(
            tabs: [
              Tab(
                icon: Icon(FontAwesomeIcons.film, color: color,),
              ),
              Tab(icon: Icon(FontAwesomeIcons.tv, color: color,))
            ],
          ),
        ),
        body: TabBarView(
          children: [
            FutureBuilder(
              future: movies,
              builder: (BuildContext context,
                  AsyncSnapshot<MoviesResponse> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  appState.setHomeStatus(HomeStatus.error);
                  return Error(
                    errorMessage: snapshot.error.toString(),
                    onRetryPressed: () {
                      appState.setHomeStatus(HomeStatus.retry);
                    },
                  );
                } else if (snapshot.connectionState == ConnectionState.done) {
                  appState.setHomeStatus(HomeStatus.completed);
                  return MovieGrid(movies: snapshot.data);
                } else {
                  appState.setHomeStatus(HomeStatus.error);
                  return Error(
                      errorMessage: "Something went wrong",
                      onRetryPressed: () {
                        appState.setHomeStatus(HomeStatus.retry);
                      });
                }
              },
            ),
            FutureBuilder(
              future: shows,
              builder: (BuildContext context,
                  AsyncSnapshot<TvShowsResponse> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  appState.setHomeStatus(HomeStatus.error);
                  return Error(
                    errorMessage: snapshot.error.toString(),
                    onRetryPressed: () {
                      appState.setHomeStatus(HomeStatus.retry);
                    },
                  );
                } else if (snapshot.connectionState == ConnectionState.done) {
                  appState.setHomeStatus(HomeStatus.completed);
                  return TvShowGrid(shows: snapshot.data);
                } else {
                  appState.setHomeStatus(HomeStatus.error);
                  return Error(
                      errorMessage: "Something went wrong",
                      onRetryPressed: () {
                        appState.setHomeStatus(HomeStatus.retry);
                      });
                }
              },
            )
          ],
        ));
  }
}
