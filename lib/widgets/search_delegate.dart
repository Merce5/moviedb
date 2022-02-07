//ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:practica_final_2/models/movie.dart';
import 'package:practica_final_2/screens/details_screen.dart';
import 'package:practica_final_2/screens/providers/movies_provider.dart';
import 'package:provider/provider.dart';

class MovieSearch extends SearchDelegate<String> {
  final List<Movie> movieList;
  Movie? movie;
  MovieSearch(this.movieList);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = "";
        },
        icon: Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, "");
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return DetailsScreen.search(movie!, true);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);
    final List<Movie> suggestionList = movieList;

    if (query.isEmpty) {
      return ListView.builder(
        itemBuilder: (context, index) => ListTile(
          onTap: () {
            Navigator.pushNamed(context, 'details',
                arguments: suggestionList[index]);
          },
          leading: FadeInImage(
              width: 50,
              placeholder: AssetImage('assets/no-image.jpg'),
              image: NetworkImage(suggestionList[index].getfullPosterPath()),
              fit: BoxFit.fitWidth),
          title: RichText(
            text: TextSpan(
              text: suggestionList[index].title.substring(0, query.length),
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
              children: [
                TextSpan(
                  text: suggestionList[index].title.substring(query.length),
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ),
        itemCount: suggestionList.length,
      );
    } else {
      return FutureBuilder(
          future: moviesProvider.getOnDisplaySearch(query),
          builder: (BuildContext context, AsyncSnapshot<List<Movie>> snapshot) {
            if (!snapshot.hasData) {
              return Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else {
              final movies = snapshot.data;
              if (movies!.length > 0) {
                movie = movies[0];
              } else {
                movie = movieList[0];
              }
              return ListView.builder(
                itemBuilder: (context, index) => ListTile(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      'details',
                      arguments: movies[index],
                    );
                  },
                  leading: FadeInImage(
                      width: 50,
                      placeholder: AssetImage('assets/no-image.jpg'),
                      image: NetworkImage(movies[index].getfullPosterPath()),
                      fit: BoxFit.fitWidth),
                  title: RichText(
                    text: TextSpan(
                        children:
                            highlightOccurrences(movies[index].title, query),
                        style: TextStyle(color: Colors.grey)),
                  ),
                ),
                itemCount: movies.length,
              );
            }
          });
    }
  }

  List<TextSpan> highlightOccurrences(String source, String query) {
    if (query == null ||
        query.isEmpty ||
        !source.toLowerCase().contains(query.toLowerCase())) {
      return [TextSpan(text: source)];
    }
    final matches = query.toLowerCase().allMatches(source.toLowerCase());

    int lastMatchEnd = 0;

    final List<TextSpan> children = [];
    for (var i = 0; i < matches.length; i++) {
      final match = matches.elementAt(i);

      if (match.start != lastMatchEnd) {
        children.add(TextSpan(
          text: source.substring(lastMatchEnd, match.start),
        ));
      }

      children.add(TextSpan(
        text: source.substring(match.start, match.end),
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
      ));

      if (i == matches.length - 1 && match.end != source.length) {
        children.add(TextSpan(
          text: source.substring(match.end, source.length),
        ));
      }

      lastMatchEnd = match.end;
    }
    return children;
  }
}
