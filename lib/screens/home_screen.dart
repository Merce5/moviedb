// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:practica_final_2/screens/providers/movies_provider.dart';
import 'package:practica_final_2/widgets/search_delegate.dart';
import 'package:practica_final_2/widgets/widgets.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context);
    final TextStyle style =
        TextStyle(fontWeight: FontWeight.bold, color: Colors.white);
    return Scaffold(
      appBar: AppBar(
        title: Text('Cartellera'),
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () {
                showSearch(
                    context: context,
                    delegate: MovieSearch(moviesProvider.popularMovies));
              },
              icon: Icon(Icons.search_outlined))
        ],
      ),
      drawer: Drawer(
        child: Container(
          color: Colors.indigo,
          child: ListView(
            children: [
              Container(
                height: 30,
              ),
              ListTile(
                title: Text("Made by: Mercè Alomar Bennassar", style: style),
                leading: Icon(
                  Icons.account_circle,
                  color: Colors.white,
                ),
              ),
              Divider(),
              ListTile(
                title:
                    Text("With the collab: Jaume Camps Fornari", style: style),
                leading: Icon(
                  Icons.account_circle,
                  color: Colors.white,
                ),
              ),
              Container(
                height: 550,
              ),
              ListTile(
                title: Text("Using: The Movie DB", style: style),
                leading: IconButton(
                  icon: Icon(
                    Icons.stacked_bar_chart_sharp,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    _launchURL();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              CardSwiper(movies: moviesProvider.onDisplayMovies),
              MovieSlider(
                movies: moviesProvider.popularMovies,
                type: 0,
              ),
              MovieSlider(
                movies: moviesProvider.ratedMovies,
                type: 1,
              ),
              MovieSlider(
                movies: moviesProvider.upcomingMovies,
                type: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }

  _launchURL() async {
    const url = 'https://www.themoviedb.org';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
