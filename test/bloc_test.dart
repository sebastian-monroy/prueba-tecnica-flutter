import 'package:http/http.dart' as http;
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movies_list_app/layers/presentation/bloc/bloc_movie.dart';
import 'package:movies_list_app/layers/presentation/bloc/movies_event.dart';
import 'package:movies_list_app/layers/presentation/bloc/movies_state.dart';

class MockMoviesBloc extends Mock implements MoviesBloc {}

void main() {
  group('MoviesBloc con datos reales', () {
    late MoviesBloc moviesBloc;

    setUp(() async {
      // Inyectamos un cliente http real al Bloc
      moviesBloc = MoviesBloc(client: http.Client());
    });

    tearDown(() {
      moviesBloc.close();
    });

    test('emite [isLoading, loaded] al cargar películas en pantalla', () async {
      moviesBloc.add(LoadOnDisplayMovies());

      expectLater(
        moviesBloc.stream,
        emitsInOrder([
          isA<MoviesState>().having((state) => state.isLoading, 'isLoading', true),
          isA<MoviesState>()
              .having((state) => state.isLoading, 'isLoading', false)
              .having((state) => state.onDisplayMovies.isNotEmpty, 'onDisplayMovies', isTrue),
        ]),
      );
    });

    test('emite [isLoading, loaded] al cargar películas populares', () async {
      moviesBloc.add(LoadPopularMovies());

      expectLater(
        moviesBloc.stream,
        emitsInOrder([
          isA<MoviesState>().having((state) => state.isLoading, 'isLoading', true),
          isA<MoviesState>()
              .having((state) => state.isLoading, 'isLoading', false)
              .having((state) => state.popularMovies.isNotEmpty, 'popularMovies', isTrue),
        ]),
      );
    });
  });
}
