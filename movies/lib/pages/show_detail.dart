import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movies/Util/constants.dart';
import 'package:movies/model/tv_show_response.dart';

class ShowDetails extends StatelessWidget {
  final Show? show;
  final SnackBar sadSnack = const SnackBar(
    backgroundColor: Colors.black38,
    content: Text(
      "Rating a TV show has not been implemented 😢",
      style: TextStyle(color: Colors.white),
    ),
    duration: Duration(milliseconds: 1500),
  );

  const ShowDetails({Key? key, required this.show}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double posterWidth = 210;
    double posterHeight = 260;
    Color color = Colors.white;
    String date =
        DateFormat("yyyy-MM-dd").format(show?.firstAirDate ?? DateTime.now());
    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 5.0, right: 5),
        child: FloatingActionButton(
          backgroundColor: Colors.black.withOpacity(0.6),
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(sadSnack);
          },
          child: const Icon(
            Icons.star,
            color: Colors.amber,
          ),
        ),
      ),
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
                          "${Constants.baseImgUrl}${show?.backdropPath ?? show?.posterPath ?? "/qi6Edc1OPcyENecGtz8TF0DUr9e.jpg"}"),
                      fit: BoxFit.cover,
                      placeholder:
                          const AssetImage('assets/images/loading.gif'),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: FractionalOffset.bottomCenter,
                              end: FractionalOffset.topCenter,
                              colors: [
                            color.withOpacity(0.5),
                            color.withOpacity(0.4),
                            Colors.transparent,
                          ],
                              stops: const [
                            0.0,
                            0.125,
                            0.4
                          ])),
                    )
                  ],
                ),
              ),
            ],
          ),
          Column(
            children: <Widget>[
              AppBar(backgroundColor: Colors.transparent, elevation: 0),
              Expanded(
                child: Container(
                  color: Colors.transparent,
                  child: Stack(
                    children: <Widget>[
                      SizedBox(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height / 1.4,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(13, 100, 13, 8),
                          child: Card(
                            elevation: 20,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            color: Colors.black54,
                            child: Column(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(
                                      right: 20, top: 120),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      Text(
                                        show?.voteAverage.toString() ?? "N/A",
                                        style: const TextStyle(fontSize: 19),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      const Icon(Icons.star,
                                          size: 28, color: Colors.amber)
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 8.0, left: 8, right: 8, bottom: 8),
                                  child: Center(
                                    child: Text(
                                      show?.name ?? "",
                                      textAlign: TextAlign.center,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                const Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 13.0),
                                  child: Divider(
                                      thickness: 0.5, color: Colors.amber),
                                ),
                                Expanded(
                                  child: SingleChildScrollView(
                                    physics: const BouncingScrollPhysics(),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        const Padding(
                                            padding:
                                                EdgeInsets.only(left: 13.0),
                                            child: Text(
                                              'Overview',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                            )),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 8, horizontal: 18),
                                          child: Text(show?.overview ?? "N/A"),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 13.0, bottom: 4.0),
                                          child: Text('Release : $date'),
                                        ),
                                        Padding(
                                            padding: const EdgeInsets.only(
                                                left: 13.0, bottom: 4.0),
                                            child: Text(
                                                "Original Language: ${show?.originalLanguage ?? "--"}"))
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          Positioned(
            left: MediaQuery.of(context).size.width / 2 - posterWidth / 2 - 30,
            top: 75,
            child: Hero(
              tag: '${show?.id ?? 1}',
              child: SizedBox(
                width: posterWidth,
                height: posterHeight,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: FadeInImage(
                    image: NetworkImage(
                        "${Constants.baseImgUrl}${show?.posterPath}"),
                    fit: BoxFit.cover,
                    placeholder: const AssetImage('assets/images/loading.gif'),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
