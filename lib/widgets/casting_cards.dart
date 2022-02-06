// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:practica_final_2/models/models.dart';
import 'package:practica_final_2/screens/providers/movies_provider.dart';
import 'package:provider/provider.dart';

class CastingCards extends StatelessWidget {
  final int id;
  CastingCards(this.id);

  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);
    return FutureBuilder(
      future: moviesProvider.getMovieCast(id),
      builder: (BuildContext context, AsyncSnapshot<List<Cast>> snapshot) {
        if (!snapshot.hasData) {
          return Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          final casting = snapshot.data;
          return Container(
            margin: EdgeInsets.only(bottom: 30),
            width: double.infinity,
            height: 180,
            // color: Colors.red,
            child: ListView.builder(
                itemCount: 10,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) => _CastCard(casting![index])),
          );
        }
      },
    );
  }
}

class _CastCard extends StatelessWidget {
  final Cast cast;
  const _CastCard(this.cast);
  
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      width: 110,
      height: 100,
      // color: Colors.green,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
              placeholder: AssetImage('assets/no-image.jpg'),
              image: NetworkImage(cast.fullProfilePath),
              height: 140,
              width: 100,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            cast.name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
