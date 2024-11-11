MOVIE-LIST 
prueba tecnica

REPOSITORIO DE GIT: https://github.com/sebastian-monroy/prueba-tecnica-flutter

INTRODUCCION:
Esta es una app de películas en donde tenemos dos listados de manera horizontal de películas, una de recomendadas y otras de las más populares en donde estas son las más calificadas o de mejor rating; También tienen un search delegate o barra de búsqueda que permite buscar todas las películas por su nombre, en donde al tocarlas se redirige a la pantalla de detalles en donde encontramos los detalles de cada película como los actores o los que hacen las voces, la fecha en que se estrenó, el rating de popularidad, y el nombre original de las películas. Además, la aplicación cuenta con un modo claro y un modo oscuro ya a preferencia del usuario que se acciona con un botón que se implementó en el homescreen.
## INSTALACION :
antes que nada, recomiendo mucho tener la última versión de flutter y la ultima versión de android studio para no tener problemas con versiones de sdk ni de kotlin.
- Flutter SDK instalado (puedes descargarlo [aquí](https://flutter.dev/docs/get-started/install))
para descargar el proyecto se hará lo siguiente:
1. clonar el proyecto con git
 - vamos a ubicarnos en una carpeta en donde quieran abrir el proyecto y abrimos la consola (cmd)y vamos a digitar este comando:
   ## git clone https://github.com/sebastian-monroy/prueba-tecnica-flutter.git
2. Instalando dependencias
 - una vez tengan el proyecto clonado y descargado lo abren con visual studio code y para instalacion de dependencias abren la    terminal dentro de la carpeta y ejecutan:
   ## flutter pub get


3. ejecución del proyecto
  después de que las dependencias les instale, ejecutan el proyecto en un dispositivo o emulador usando:
  ## flutter run o simplemente dandole clic en run y luego en start debugin (f5)

## NOTA: tener configurado el entorno de flutter y un dispositivo fisico en modo developer o emulador de android studio

Arquitectura del proyecto:
Para el proyecto utilizamos clean Arquitecture o arquitectura limpia para lo cual nuestra estructura quedo así:

Movie-List
Lib/
      layers/  (capas de la aplicacion)
	data/
		datasource/
			api_services.dart // peticiones http al backend TMDB
		repositories/
			api_repository_impl.dart  //trae los servicios del api service
	domain/
		models/  (modelos de donde viene la informacion)
			credits_response.dart
			genre.dart
			models.dart
			movie.dart
			now_playing_response.dart
			popular_response.dart
			search_response.dart
		repositories/
			api_repository.dart //se conecta con el api_repository_impl
	presentation/
		bloc/
			bloc_movie.dart
			bloc_theme.dart //manejo del tema claro y oscuro 
			movies_event.dart
			movies_state.dart
		screens/
			search/
				search_delegate.dart  //  filtro de busqueda
			details_screen.dart
			home_screen.dart
			screens.dart
		widgets/
			card_swiper.dart
			casting_cards.dart
			movie_slider.dart
			widgets.dart
  app_locator.dart
  main.dart
test/
        bloc_test.dart  //pruebas unitarias de nuestro bloc para el llamado de las películas

Patrón de arquitectura: Usamos Clean Architecture (arquitectura limpia) para este caso y era lo requerido según las reglas y nos sirve de buena practica para trabajar un código limpio y fácil de leer


This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
