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
  testWidgets('CardSwiper muestra imágenes correctamente y permite swipe y navegación', (WidgetTester tester) async {
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
    final poster1 = find.byWidgetPredicate(
      (Widget widget) =>
          widget is FadeInImage && widget.image.toString().contains('poster1.jpg'),
    );
    final poster2 = find.byWidgetPredicate(
      (Widget widget) =>
          widget is FadeInImage && widget.image.toString().contains('poster2.jpg'),
    );
    
    expect(poster1, findsOneWidget); // Verifica que la primera imagen se muestra
    expect(poster2, findsNothing);   // Verifica que solo se muestra la primera al inicio

    // Simula el swipe para pasar de una película a otra
    await tester.drag(find.byType(CardSwiper), const Offset(-300.0, 0.0));
    await tester.pump();

    // Verifica que después del swipe la segunda imagen está visible
    expect(poster1, findsNothing);   // La primera imagen ya no debe estar
    expect(poster2, findsOneWidget); // La segunda imagen debe estar visible

    // Verifica la navegación al tocar una película
    await tester.tap(poster2);
    await tester.pumpAndSettle();


    expect(find.text('Pelicula 2'), findsOneWidget); // Verifica que se navegó a detalles
  });
}
