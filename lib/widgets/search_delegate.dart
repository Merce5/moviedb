//ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:practica_final_2/models/movie.dart';
import 'package:practica_final_2/screens/details_screen.dart';

class MovieSearch extends SearchDelegate<String> {
  final List<Movie> movieList;
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
    // TODO: implement buildResults
    throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final List<Movie>suggestionList = query.isEmpty
        ? movieList
        : movieList.where((movie) => movie.title.startsWith(query)).toList();
    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        onTap: () {
          Navigator.pushNamed(context, 'details', arguments: suggestionList[index]);
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
  }
}
