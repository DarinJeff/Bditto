import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies/Util/constants.dart';
import 'package:movies/model/popular_movies.dart';

class MovieDetails extends StatelessWidget {
  final Movie? movie;

  const MovieDetails({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color color = Colors.deepPurple;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              Expanded(
                child: Stack(
                  children: <Widget>[
                    FadeInImage(
                      width: double.infinity,
                      height: double.infinity,
                      image: NetworkImage(
                          "${Constants.baseImgUrl}${movie?.backdropPath ?? "/qi6Edc1OPcyENecGtz8TF0DUr9e.jpg"}"),
                      fit: BoxFit.cover,
                      placeholder: const AssetImage(
                          'assets/images/loading.gif'),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          gradient: LinearGradient(
                              begin: FractionalOffset.bottomCenter,
                              end: FractionalOffset.topCenter,
                              colors: [
                                color,
                                color.withOpacity(0.3),
                                color.withOpacity(0.2),
                                color.withOpacity(0.1),
                              ],
                              stops: [0.0, 0.25, 0.5, 0.75])),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  color: color,
                ),
              )
            ],
          ),
          Column(
            children: <Widget>[
              AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0
              ),
              Expanded(
                child: Container(
                  color: Colors.transparent,
                  child: Stack(
                    children: <Widget>[
                      SizedBox(
                        width: double.infinity,
                        height: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(16, 75, 16, 16),
                          child: Card(
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            color: Colors.black54,
                            child: Column(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(left: 120.0),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.start,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(movie?.title ?? "", maxLines: 2, overflow: TextOverflow.ellipsis,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            children: <Widget>[
                                              Text(movie?.voteAverage.toString() ?? "N/A"),
                                              const Icon(Icons.star, color: Colors.amber),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: SingleChildScrollView(
                                    physics: const BouncingScrollPhysics(),
                                    child: Column(
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            Padding(padding: EdgeInsets.only(left: 8.0),
                                              child: Text('Overview',)
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(movie?.overview ?? "N/A"),
                                        ),
                                        Row(
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0, bottom: 4.0),
                                              child: Text('Release date : ${movie?.releaseDate}'),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 0,
                        left: 40,
                        child: Hero(
                          tag: 'movie',
                          child: SizedBox(
                            width: 100,
                            height: 150,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: FadeInImage(
                                image: NetworkImage("${Constants.baseImgUrl}${movie?.posterPath}"),
                                fit: BoxFit.cover,
                                placeholder: const AssetImage('assets/images/loading.gif'),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
