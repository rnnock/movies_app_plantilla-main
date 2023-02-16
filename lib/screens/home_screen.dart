/*
Pantalla inicial que muestra las imágenes de las películas en cartelera y las películas más populares.
Al pulsar sobre una imagen, se navega a la pantalla DetailsScreen, que contiene la información detallada
de la película seleccionada.
*/

import 'package:flutter/material.dart';
import 'package:movies_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

import '../providers/movies_provider.dart';

/*
Clase HomeScreen que muestra la información de la pantalla inicial, junto con los métodos necesarios
para mostrar los detalles de una determinada película.
*/
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    /*
    Asignación de la instancia de Provider a la variable final moviesProvider. Se indica que es de tipo
    'MoviesProvider' creada en el main, para saber qué instancia debe ser asignada.
    */
    final moviesProvider = Provider.of<MoviesProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cartelera'),
        elevation: 0,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search_outlined))
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              /*
              Widget CardSwiper que llama al método onDisplayMovies para mostrar
              las portadas de las películas que actualmente están en cartelera.
              */
              CardSwiper(movies: moviesProvider.onDisplayMovies),

              /*
              Widget MovieSlider que llama al método popularMovies para mostrar
              las portadas de las películas más populares.
              */
              MovieSlider(movies: moviesProvider.popularMovies),
            ],
          ),
        ),
      ),
    );
  }
}
