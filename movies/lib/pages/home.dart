import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:movies/controller/app_state.dart';
import 'package:movies/model/popular_tv_shows.dart';
import 'package:movies/pages/error.dart';
import 'package:movies/model/popular_movies.dart';
import 'package:movies/services/api_helper.dart';
import 'package:movies/widgets/movie_grid.dart';
import 'package:movies/widgets/tv_show_grid.dart';

GetIt getIt = GetIt.instance;

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AppState appState = getIt.get<AppState>();

  @override
  void initState() {
    super.initState();
    appState.homeStateStream.listen((status) {
      if (status == HomeStatus.retry) {
        appState.setHomeStatus(HomeStatus.loading);
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "Show Time",
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          bottom: const TabBar(
            tabs: [
              Tab(
                icon: Icon(FontAwesomeIcons.film),
              ),
              Tab(icon: Icon(FontAwesomeIcons.tv))
            ],
          ),
        ),
        body: TabBarView(
          children: [
            FutureBuilder(
              future: ApiHelper.getPopularMovies(),
              builder: (BuildContext context,
                  AsyncSnapshot<PopularMovies> snapshot) {
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
              future: ApiHelper.getPopularTvShows(),
              builder: (BuildContext context,
                  AsyncSnapshot<PopularTvShows> snapshot) {
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
                  return TvShowGridGrid(shows: snapshot.data);
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
