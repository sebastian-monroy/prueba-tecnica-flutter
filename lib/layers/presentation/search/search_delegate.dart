import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_list_app/layers/data/models/movie.dart';
import 'package:movies_list_app/layers/presentation/bloc/bloc_movie.dart';
import 'package:movies_list_app/layers/domain/usercase/movies_event.dart';
import 'package:movies_list_app/layers/domain/repository/movies_state.dart';


class MovieSearchDelegate extends SearchDelegate{

  @override
  String get SearchFieldLabel => 'Buscar Peliculas';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: (){
          query = '';
        }, 
        icon: Icon(Icons.clear),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: (){
        close(context, null);
      }, 
      icon: Icon(Icons.arrow_back)
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return Text('BuildResults');
  }

  Widget _emptyContainer() {
    return Container(
        child: Center(
          child: Icon(Icons.movie_creation_outlined, color: Colors.black38, size: 100,),
        ),
      );
  }

  @override
  Widget buildSuggestions(BuildContext context) {

    if(query.isEmpty) {
      return _emptyContainer();
    }

    final moviesBloc = BlocProvider.of<MoviesBloc>(context);
    moviesBloc.add(SearchMovie(query)); 

    return BlocBuilder<MoviesBloc, MoviesState>(
      builder: (context, state){
        if(state.isLoading){
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state.searchedMovies.isEmpty){
          return _emptyContainer();
        } else {
          final movies = state.searchedMovies;
          return ListView.builder(
            itemCount: movies.length,
            itemBuilder: (_, int index)=>_MovieItem(movies[index])
          );
        }
      }
    );
  }

}

//este widget tiene la informacion de las pelis exactamente en el search o cuando se va a buscar una pelicula en especifico
class _MovieItem extends StatelessWidget {

  final Movie movie; 
  const _MovieItem(this.movie);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: FadeInImage(
        placeholder: AssetImage('assets/no-image.jpg'), 
        image: NetworkImage(movie.fullPosterImg),
        width: 50,
        fit: BoxFit.contain,
      ),
      title: Text(movie.title),
      subtitle: Text('fecha estreno: ${movie.releaseDate.toString()}'),
      onTap: (){
        Navigator.pushNamed(context, 'details', arguments: movie);
      },
    );
  }
}