import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_list_app/app_locator.dart';
import 'package:movies_list_app/layers/presentation/bloc/bloc_movie.dart';
import 'package:movies_list_app/layers/presentation/bloc/bloc_theme.dart';
import 'package:movies_list_app/layers/presentation/bloc/movies_event.dart';
import 'package:movies_list_app/layers/presentation/screens/screens.dart';
import 'package:provider/provider.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await registerDependencies();
  runApp(const AppState());
} 

class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    //providers y servicios 
    return MultiProvider(
      providers: [
        BlocProvider<MoviesBloc>(create: (_)=> MoviesBloc()..add(LoadOnDisplayMovies())),
        BlocProvider<ThemeBloc>(create: (_) => ThemeBloc())
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    final themeBloc = Provider.of<ThemeBloc>(context);

    return BlocBuilder<ThemeBloc, ThemeData>(
      builder: (context, theme){
        return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Peliculas App',
        initialRoute: 'home',
        routes: {
          'home': (_) => HomeScreen(),
          'details': (_) => DetailsScreen()
        },
        theme: theme
      );
      }
    );
  }
}