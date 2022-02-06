// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:practica_final_2/models/models.dart';
import 'package:practica_final_2/widgets/widgets.dart';

class DetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Movie movie = ModalRoute.of(context)?.settings.arguments as Movie;

    return Scaffold(
        body: CustomScrollView(
          slivers: [
            _CustomAppBar(movie),
            SliverList(
              delegate: SliverChildListDelegate([
                _PosterAndTitile(movie),
                _Overview(movie),
                _Overview(movie),
                CastingCards()
              ])
            )
          ],
        )
    );
  }
}

class _CustomAppBar extends StatelessWidget {
  final Movie movie;
  const _CustomAppBar(this.movie);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.indigo,
      expandedHeight: 200,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: EdgeInsets.all(0),
        title: Container(
          width: double.infinity,
          alignment: Alignment.bottomCenter,
          color: Colors.black12,
          padding: EdgeInsets.only(bottom: 10),
          child: Text(movie.title,
            style: TextStyle(fontSize: 16)
            ,
          ),
        ),

        background: FadeInImage(
          placeholder: AssetImage('assets/loading.gif'),
          image: NetworkImage(movie.getfullPosterPath()),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _PosterAndTitile extends StatelessWidget {
  final Movie movie;
  _PosterAndTitile(this.movie);

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Container(
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
              placeholder: AssetImage('assets/loading.gif'),
              image: NetworkImage(movie.getfullPosterPath()),
              height: 150,
            ),
          ),
          SizedBox(width: 20,),
          Column(
            children: [
              Text(movie.title, style: textTheme.headline5, overflow: TextOverflow.ellipsis, maxLines: 2,),
              Text(movie.originalTitle, style: textTheme.subtitle1, overflow: TextOverflow.ellipsis, maxLines: 2,),
              Row(
                children: [
                  Icon(Icons.star_outline,size: 15, color: Colors.grey),
                  SizedBox(width: 5,),
                  Text('${movie.voteAverage}', style: textTheme.caption),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}

class _Overview extends StatelessWidget {
  final Movie movie;
  _Overview(this.movie);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Text(movie.overview,
        textAlign: TextAlign.justify,
        style: Theme.of(context).textTheme.subtitle1,
      ),
    );
  }
}