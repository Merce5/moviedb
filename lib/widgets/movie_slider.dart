import 'dart:async';

import 'package:flutter/material.dart';
import 'package:practica_final_2/models/models.dart';
import 'package:practica_final_2/screens/providers/movies_provider.dart';

class MovieSlider extends StatefulWidget {
  final List<Movie> movies;
  MovieSlider({Key? key, required this.movies}) : super(key: key);

  @override
  State<MovieSlider> createState() => _MovieSliderState();
}

class _MovieSliderState extends State<MovieSlider> {
  ScrollController _scrollController = new ScrollController();
  bool _estaCarregant = false;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    if (widget.movies.length == 0) {
      return Container(
        width: double.infinity,
        height: size.height * 0.5,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Container(
      width: double.infinity,
      height: 260,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text('Populars',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ),
          SizedBox(
            height: 5,
          ),
          Expanded(
            child: ListView.builder(
                controller: _scrollController,
                scrollDirection: Axis.horizontal,
                itemCount: 20,
                itemBuilder: (_, int index) => _MoviePoster(
                      movie: widget.movies[index],
                    )),
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      print(_scrollController.position.pixels);
      if (_scrollController.position.atEdge) {
        if (_scrollController.position.pixels == 0) {
          print('Scroll a l\'inici');
        } else {
          print('Scroll al final');
          //_carregaNou();
          fetchData();
        }
      }
    });
  }

  Future<Timer> fetchData() async {
    _estaCarregant = true;
    setState(() {});
    final duration = new Duration(seconds: 2);
    return Timer(duration, peticioHTTP);
  }

  void peticioHTTP() {
    _estaCarregant = false;
    _carregaNou();
    _scrollController.animateTo(_scrollController.position.pixels + 100,
        duration: Duration(milliseconds: 250), curve: Curves.fastOutSlowIn);
  }

  void _carregaNou() {
    MoviesProvider.refresh("2");
    setState(() {});
  }
}

class _MoviePoster extends StatelessWidget {
  final Movie movie;
  const _MoviePoster({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      height: 190,
      // color: Colors.green,
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          GestureDetector(
            onTap: () =>
                Navigator.pushNamed(context, 'details', arguments: movie),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                placeholder: AssetImage('assets/no-image.jpg'),
                image: NetworkImage(movie.getfullPosterPath()),
                width: 130,
                height: 190,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            movie.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
