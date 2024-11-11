import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_list_app/layers/presentation/bloc/bloc_movie.dart';
import 'package:movies_list_app/layers/presentation/bloc/bloc_theme.dart';
import 'package:movies_list_app/layers/domain/usercase/movies_event.dart';
import 'package:movies_list_app/layers/domain/repository/movies_state.dart';
import 'package:movies_list_app/layers/presentation/search/search_delegate.dart';
import 'package:movies_list_app/layers/presentation/widgets/card_swiper.dart';
import '../widgets/movie_silder.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final moviesBloc = BlocProvider.of<MoviesBloc>(context);

   
    if (moviesBloc.state.onDisplayMovies.isEmpty) {
      moviesBloc.add(LoadOnDisplayMovies());  
    }

    if(moviesBloc.state.popularMovies.isEmpty) {
      moviesBloc.add(LoadPopularMovies());
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 50),
              decoration: const BoxDecoration(
                color: Color(0xff4f87b2),
                // borderRadius: BorderRadius.only(
                //   bottomLeft: Radius.circular(30),
                //   bottomRight: Radius.circular(30),
                // ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () {
                      // Modo claro y modo oscuro
                      context.read<ThemeBloc>().add(ThemeEvent.toggle);
                    },
                    icon: const Icon(Icons.nightlight_outlined, color: Colors.white),
                  ),
                  const Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 35),
                    child: Text(
                      'Hello, what do you',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 35),
                    child: Text(
                      'want to watch ?',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  GestureDetector(
                    onTap: () {
                      showSearch(context: context, delegate: MovieSearchDelegate());
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 10,
                            offset: Offset(0, 5),
                          ),
                        ],
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.search, color: Colors.white),
                          SizedBox(width: 8),
                          Text(
                            'Search ...',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "RECOMMENDED FOR YOU",
                    style: TextStyle(
                      fontWeight: FontWeight.bold
                    )
                  ),
                  Text(
                    'See all',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            
            BlocBuilder<MoviesBloc, MoviesState>(
              builder: (context, state) {
                if (state.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return CardSwiper(
                    movies: state.onDisplayMovies,
                    onNextPage: () {
                      moviesBloc.add(LoadOnDisplayMovies());
                    },
                  );
                }
              },
            ),

            const SizedBox(height: 5),
            
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "TOP RATED",
                    style: TextStyle(
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  Text('See all', style: Theme.of(context).textTheme.bodyMedium),
                ],
              ),
            ),
            const SizedBox(height: 8),

          
          BlocBuilder<MoviesBloc, MoviesState>(
              builder: (context, state) {
                if (state.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return MovieSilder(
                    movies: state.popularMovies,
                    onNextPage: () {
                      moviesBloc.add(LoadPopularMovies());
                    },
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}