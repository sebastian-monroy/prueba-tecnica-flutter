import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:movies_list_app/widgets/card_swiper.dart';
import 'package:movies_list_app/models/movie.dart';
import 'package:movies_list_app/providers/movies_provider.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

// Mocks generados para MoviesProvider
class MockMoviesProvider extends Mock implements MoviesProvider {}

void main() {
  testWidgets('CardSwiper muestra correctamente las películas con un provider mockeado', (WidgetTester tester) async {
    // Simulación de una lista de películas
    final movies = [
      Movie(
        adult: false,
        backdropPath: '/backdrop1.jpg',
        genreIds: [28, 12],
        id: 1,
        originalLanguage: 'en',
        originalTitle: 'Original Title 1',
        overview: 'Overview of movie 1',
        popularity: 100.0,
        posterPath: '/poster1.jpg',
        releaseDate: '2024-01-01',
        title: 'Pelicula 1',
        video: false,
        voteAverage: 8.5,
        voteCount: 2000,
      ),
      Movie(
        adult: false,
        backdropPath: '/backdrop2.jpg',
        genreIds: [28, 35],
        id: 2,
        originalLanguage: 'en',
        originalTitle: 'Original Title 2',
        overview: 'Overview of movie 2',
        popularity: 150.0,
        posterPath: '/poster2.jpg',
        releaseDate: '2024-02-01',
        title: 'Pelicula 2',
        video: false,
        voteAverage: 7.8,
        voteCount: 3000,
      ),
    ];

    // Mock del MoviesProvider
    final mockMoviesProvider = MockMoviesProvider();
    when(mockMoviesProvider.onDisplayMovies).thenReturn(movies);

    // Construir el widget usando el provider simulado
    await tester.pumpWidget(
      ChangeNotifierProvider<MoviesProvider>.value(
        value: mockMoviesProvider,
        child: MaterialApp(
          home: Scaffold(
            body: CardSwiper(movies: movies),
          ),
        ),
      ),
    );

    // Verifica que las imágenes de las películas se muestran correctamente
    expect(find.byType(FadeInImage), findsNWidgets(2));

    // Simula el swipe para pasar de una película a otra
    await tester.drag(find.byType(CardSwiper), const Offset(-300.0, 0.0));
    await tester.pump();

    // Verifica que el swipe funciona
    expect(find.text('Pelicula 1'), findsNothing); // Película 1 debe desaparecer
    expect(find.text('Pelicula 2'), findsOneWidget); // Película 2 debe aparecer
  });
}

