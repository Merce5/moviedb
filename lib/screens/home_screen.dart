// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:practica_final_2/screens/providers/movies_provider.dart';
import 'package:practica_final_2/widgets/search_delegate.dart';
import 'package:practica_final_2/widgets/widgets.dart';
import 'package:provider/provider.dart';


class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Cartellera'),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              showSearch(context: context, delegate: MovieSearch(moviesProvider.onDisplayMovie));
            },
            icon: Icon(Icons.search_outlined)
          )
        ],
      ),
      drawer: Drawer(),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            
            children: [
              CardSwiper(movies: moviesProvider.onDisplayMovie),
              MovieSlider(movies: moviesProvider.onDisplayPopulars,),
            ],
          ),
        )
      )
    );
  }
}
