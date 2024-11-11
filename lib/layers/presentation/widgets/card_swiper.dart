import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movies_list_app/layers/data/models/movie.dart';

class CardSwiper extends StatefulWidget {

  final List<Movie> movies;
  final String? title;
  final Function onNextPage;

  const CardSwiper({super.key, required this.movies, this.title, required this.onNextPage});

  @override
  State<CardSwiper> createState() => _CardSwiperState();
}

class _CardSwiperState extends State<CardSwiper> {

  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    
    super.initState();
    scrollController.addListener((){
      if(scrollController.position.pixels >= scrollController.position.maxScrollExtent - 500){
        widget.onNextPage();
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      height: 290,

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          if(this.widget.title != null)
          Padding(padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text(this.widget.title!, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
          ),

          Expanded(
            child: ListView.builder(
              controller: scrollController,
              itemCount: widget.movies.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) => _MovieImage(widget.movies[index])
            ),
          )
        ],
      ),
    );
  }
}

class _MovieImage extends StatelessWidget {

  final Movie movie;

  const _MovieImage(this.movie);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      height: 190,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        children: [
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, 'details', arguments: movie),
            child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                placeholder: AssetImage('assets/no-image.jpg'), 
                image: NetworkImage(movie.fullPosterImg),
                width: 150,
                height: 175,
                fit: BoxFit.cover,
              ),
            ),
          ),

          SizedBox(height: 5,),

          Text(
            movie.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
          RatingBarIndicator(
          rating: movie.voteAverage / 2,
          itemBuilder: (context, index) => Icon(
            Icons.star,
            color: Colors.amber,
          ),
            itemCount: 5,
            itemSize: 20.0,
            direction: Axis.horizontal,
          ),
        ],
      ),
    );
  }
}