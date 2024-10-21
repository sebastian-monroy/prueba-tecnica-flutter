import 'package:flutter/material.dart';
import 'package:movies_list_app/providers/movies_provider.dart';
import 'package:movies_list_app/search/search_delegate.dart';
import 'package:movies_list_app/widgets/card_swiper.dart';
import 'package:provider/provider.dart';
import '../widgets/movie_silder.dart';



class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final moviesProvider = Provider.of<MoviesProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Peliculas en cines',style: TextStyle(color: Colors.white),),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: (){
              showSearch(
                context: context, 
                delegate: MovieSearchDelegate()
              );
            }, 
            icon: const Icon(Icons.search, color: Colors.white,)
          )
        ],
      ),
      body:Column(
        children: [
          
          CardSwiper(movies:moviesProvider.onDisplayMovies),
      

          MovieSilder(
           movies: moviesProvider.popularMovies,
           title: 'peliculas populares',
           onNextPage: () => {
            moviesProvider.getPopularMovies()
           },
          )
      
        ],
      ),
    );
  }
}