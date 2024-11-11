import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_list_app/layers/data/models/models.dart';
import 'package:movies_list_app/layers/presentation/bloc/bloc_movie.dart';
import 'package:movies_list_app/layers/domain/usercase/movies_event.dart';
import 'package:movies_list_app/layers/domain/repository/movies_state.dart';


class CastingCards extends StatelessWidget {

  final int movieId;

  const CastingCards(this.movieId, {super.key});

  @override
  Widget build(BuildContext context) {

    
    final moviesBloc = BlocProvider.of<MoviesBloc>(context);

    moviesBloc.add(LoadMovieCast(movieId));

    return BlocBuilder<MoviesBloc, MoviesState>(
      builder: (context, state) {
        if (state.isLoading) {
          return Container(
            constraints: BoxConstraints(maxWidth: 150),
            height: 180,
            child: CupertinoActivityIndicator(),
          );
        }

        if (!state.moviesCast.containsKey(movieId)) {
          return _emptyContainer(); 
        }

        final List<Cast>? cast = state.moviesCast[movieId];

         if (cast == null || cast.isEmpty) {
          return _emptyContainer();  
        }

        return Container(
          margin: EdgeInsets.only( bottom: 20 ),
          width: double.infinity,
          height: 180,
          child: ListView.builder(
            itemCount: cast.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: ( _, int index) => _CastCard( cast[index] ),
          ),
        );
      },
    );
  }
  Widget _emptyContainer(){
    return Container(
      child: Center(
        child: Icon(Icons.movie_creation_outlined, color: Colors.black38, size: 100),
      ),
    );
  }
}

class _CastCard extends StatelessWidget {

  
  final Cast actor;

  const _CastCard( this.actor );
  

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      width: 110,
      height: 100,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: FadeInImage(
              placeholder: AssetImage('assets/no-image.jpg'), 
              image: NetworkImage(actor.fullProfilePath),
              height: 120,
              width: 100,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 5,),
          Text(
            actor.name, 
            maxLines: 2, 
            overflow: TextOverflow.ellipsis, 
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}