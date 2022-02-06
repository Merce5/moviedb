// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:practica_final_2/screens/providers/movies_provider.dart';
import 'package:practica_final_2/widgets/widgets.dart';
import 'package:provider/provider.dart';


class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context);
    print(moviesProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text('Cartellera'),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search_outlined)
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            
            children: [

              // Targetes principals
              CardSwiper(movies: moviesProvider.onDisplayMovie),
              
              // Slider de pel·licules
              MovieSlider(movies: moviesProvider.onDisplayPopulars,),
              // Poodeu fer la prova d'afegir-ne uns quants, veureu com cada llista és independent
              // MovieSlider(),
              // MovieSlider(),

            ],
          ),
        )
      )
    );
  }
}
