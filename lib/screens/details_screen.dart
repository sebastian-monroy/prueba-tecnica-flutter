import 'package:flutter/material.dart';
import 'package:movies_list_app/widgets/widgets.dart';

import '../models/movie.dart';


class DetailsScreen extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {

    final Movie movie = ModalRoute.of(context)!.settings.arguments as Movie;


    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _CustomAppBar(movie),
          SliverList(
            delegate: SliverChildListDelegate([
              _PosterAndTile(movie),
              _Overview(movie),
              CastingCards(movie.id)
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
      iconTheme: IconThemeData(
        color: Colors.white
      ),
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
          padding: EdgeInsets.only(bottom: 10, left: 20, right: 10),
          color: Colors.black12,
          child: Text(movie.title, style: TextStyle(fontSize: 13, color: Colors.white54),),
        ),
        background: FadeInImage(
          placeholder: AssetImage('assets/loading.gif'), 
          image: NetworkImage(movie.fullbackdropPath),
          fit: BoxFit.cover,
        ),
      ),

    );
  }
}


class _PosterAndTile extends StatelessWidget {

  final Movie movie;

  const _PosterAndTile(this.movie);

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
              placeholder: AssetImage('assets/no-image.jpg'), 
              image: NetworkImage(movie.fullPosterImg),
              height: 150,
              width: 110,
            ),
          ),

          SizedBox(width: 20,),

          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: size.width - 190),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
            
                Text(movie.title, style: Theme.of(context).textTheme.headlineMedium, overflow: TextOverflow.ellipsis, maxLines: 2,),
            
                
                Text(movie.originalTitle, style: Theme.of(context).textTheme.bodySmall, overflow: TextOverflow.ellipsis,maxLines: 2,),
                Row(
                  children: [
                    Icon(Icons.star_outline, size: 15, color: Colors.grey,),
                    SizedBox(width: 5,),
                    Text('${movie.voteAverage}', style: Theme.of(context).textTheme.bodySmall,)
                  ],
                ),
                Text('Fecha estreno: ${movie.releaseDate!}')
              ],
            ),
          )
        ],
      ),
    );
  }
}


class _Overview extends StatelessWidget {

  final Movie movie;

  const _Overview(this.movie);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Text(movie.overview, textAlign: TextAlign.justify, style: Theme.of(context).textTheme.bodyMedium,),
    );
  }
}