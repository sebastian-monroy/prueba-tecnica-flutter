


import 'package:flutter/material.dart';
import 'package:movies_list_app/models/movie.dart';
import 'package:movies_list_app/providers/movies_provider.dart';
import 'package:provider/provider.dart';

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

    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);
      return FutureBuilder(
        future: moviesProvider.searchMovie(query), 
        builder: (_, AsyncSnapshot<List<Movie>> snapshot) {


          if(!snapshot.hasData) return _emptyContainer();

          final movies = snapshot.data!;

          return ListView.builder(
            itemCount: movies.length,
            itemBuilder: (_, int index) => _MovieItem(movies[index]),
          );
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