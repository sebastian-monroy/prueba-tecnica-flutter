# movies_list_app

A new Flutter project.

## Getting Started

## instalacion 
antes que nada recomiendo mucho tener la version 3.24.3 de flutter y la ultima version de android studio para no tener problemas con versiones de sdk ni de kotlin.

- Flutter SDK instalado (puedes descargarlo [aquí](https://flutter.dev/docs/get-started/install))

para descargar el proyecto se hara lo siguiente:

1. clonar el proyecto con git
 - vamos a ubicarnos en una carpeta en donde quieran abrir el proyecto y abrimos la consola (cmd)y vamos a digitar este comando:
   ## git clone https://github.com/sebastian-monroy/ https://github.com/sebastian-monroy/prueba-tecnica-flutter.git

2. Instalando dependencias
 - una vez tengan el proyecto clonado y descargado lo abren con visual studio code y para instalacion de dependencias abren la    terminal dentro de la carpeta y ejecutan:
   ## flutter pub get

3. ejecucion del proyecto
  despues de que las dependencias les instale, ejecutan el proyecto en un dispositivo o emulador usando:
  ## flutter run o simplemente dandole clic en run y luego en start debugin (f5)

## NOTA: tener configurado el entorno de flutter y un dispositivo fisico en modo developer o emulador de android studio


## Explicacion de la app
Este es un proyecto de flutter en donde se muestra un listado de peliculas en forma de slider en donde se permiten buscar por medio de un searchdelegate el cual es un flitro de busqueda que implementamos en el appbar de la pantalla principal. la informacion vienen del backend llamado "the movie database"(https://www.themoviedb.org/), en donde se extrajo el api y se genero un api_key para poder hacer dicha interaccion de la informacion con la presente aplicacion. Durante el desarrollo se implemento widgets personalizados, los cuales estan ubicados en una carpeta llamasa "widgets". En estos widgets tenemos las listas de las peliculas junto con su informacion como las imagenes de cada pelicula, las fechas en que se estrenaron y el titulo y demas caracteristicas como por ejemplo la parte de los actores y el rating. El search esta en una carpeta llamada search que es en donde implementamos la parte logica para realizar la busqueda de una pelicula en especifico y poder ir directamente a las caracteristicas de esta. 

Por otra parte, el tema de las pantallas esta ubicado en la carpeta screens que es en donde tenemos lo que es la parte de la UI en donde llamamos a los widgets personalizados para que se logre visualizar lo hecho anteriormente exportando cada componente de su ruta correspondiente, siendo el homescreen nuestra pantalla inicial y el details screen es la pantalla en donde encontramos el resto de la informacion de cada pelicula, en la cual al tocar cualquier pelicula de la pantalla inicial y de cuando la buscamos en el search delegate esta nos navegara a esa pantalla de detalles que es la details screen.

Para el tema de gestores de estados utilizamos provider. En el provider manejamos toda la parte logica de nuestro aplicativo en donde en nuestro movies_provider.dart encontramos las peticiones http que se realizaron al api, en donde tenemos como strings la apikey que se genero directamente desde el sitio del api , las cuales fueron probadas en postman antes de ser utilizadas dentro de nuestro programa y se implementaron clases tambien que hacen posible la interaccion de la informacion que se suministra y hace que encaje con lo esperado, aparte de las peticiones, tambien se implento la parte de la busqueda por medio de una funcion que se encarga de ejecutar dicho proceso; para usar el provider y tener acceso a las funciones se implemento en el main.dart un multiprovider en donde a futuros cambios vamos a poder integrar mas apis y nuevos servicios que ayuden con la interaccion de nuestra app y de la info. En ese multiprovider llamamos a nuestro movies_provider para que abarque en toda la app a nivel general y poder realizar ese llamado por medio de variables. 

Ademas, tenemos una carpeta de models que como lo mencione anteriormente gracias a estos modelos creados es que podemos recibir esa parte de la data que buscamos traer y hace que interactue y evalue como va llegando cada dato de nuestro api rest ya sean strings, dates, ints, o listas. estos modelos los llamamos por medio de variables final en cada componente y se les pasa los argumentos para poder recibir esa interaccion


El tema de las rutas del proyecto lo tenemos en el main.dart en el widget inicial de myapp, dentro de nuestro material app exactamente de esta manera: 

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Peliculas App',
      initialRoute: 'home',
      routes: { //estas son las rutas
        'home': (_) => HomeScreen(),
        'details': (_) => DetailsScreen()
      },
      theme: ThemeData.light().copyWith(
        appBarTheme: AppBarTheme(
          color: Colors.indigo
        )
      ),
    );
  }
}

## estructura de carpetas
la estructura del proyecto como tal esta de esta manera:

MOVIE-LIST/
lib/
  models/
    credits_response.dart
    models.dart
    movie.dart
    now_playing_response.dart
    popular_response.dart
    search_response.dart
  providers/
    movies_provider.dart
  screens/
    details_screen.dart
    home_screen.dart
    screens.dart //el screens.dart es para que cada que se traiga una pantalla nos las importe por medio de este archivo, para optimizar
  search/
    search_delegate.dart
  widgets/
    card_swiper.dart
    casting_cards.dart
    movie_slider.dart
    widgets.dart //este archivo hace lo mismo que el screens.dart, me trae los widgets en un solo import cada que se llamen
main.dart
test/
  cast_swiper_test.dart
  widget_test.dart

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
