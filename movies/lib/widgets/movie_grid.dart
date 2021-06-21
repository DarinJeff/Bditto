import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies/Util/constants.dart';
import 'package:movies/model/movie_response.dart';
import 'package:movies/pages/movie_detail.dart';

class MovieGrid extends StatelessWidget {
  final MoviesResponse? movies;

  const MovieGrid({Key? key, required this.movies}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemCount: movies?.results?.length ?? 0,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          var movie = movies?.results?[index];
          return Padding(
            padding: const EdgeInsets.all(4.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MovieDetails(movie: movie)));
              },
              child: Container(
                height: 130,
                child: Stack(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 30.0),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(8.0),
                            border: Border.all(width: 1)),
                        height: 120,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 110.0, top: 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Flexible(
                                child: Text(movie?.title ?? "", maxLines: 3, overflow: TextOverflow.ellipsis,),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Row(
                                  children: <Widget>[
                                    Text(
                                      movie?.voteAverage.toString() ?? "N/A",
                                    ),
                                    const Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      left: 8,
                      child: Hero(
                        tag: '${movie?.id ?? 1}',
                        child: SizedBox(
                          width: 100,
                          height: 125,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: FadeInImage(
                              image: NetworkImage(
                                  "${Constants.baseImgUrl}${movie?.posterPath ?? "/qi6Edc1OPcyENecGtz8TF0DUr9e.jpg"}"),
                              fit: BoxFit.cover,
                              placeholder:
                                  const AssetImage('assets/images/loading.gif'),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
