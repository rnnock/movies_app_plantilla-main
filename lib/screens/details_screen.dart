/*
Pantalla que muestra los detalles de una película en concreto y que es instanciada desde el HomeScreen.
Aquí se muestra la carátula de una determinada película, la sinopsis y una galería con las imágenes de los
actores que componen esa película, entre otra información mostrada. Desde aquí se puede navegar de nuevo al
HomeScreen, pulsando la flecha de regreso.
*/

import 'package:flutter/material.dart';
import 'package:movies_app/widgets/widgets.dart';

import '../models/models.dart';

//Clase DetailsScreen que instancia a los métodos necesarios para mostrar los detalles de una determinada película.
class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    /*
    Declaración e inicialización del objeto tipo Movie que es utilizado como argumento en las distintas llamadas
    a los métodos de la clase.
    */
    final Movie peli = ModalRoute.of(context)?.settings.arguments
        as Movie; //Casting a tipo Movie

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _CustomAppBar(movie: peli),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                _PosterAndTitle(
                    movie:
                        peli), //Cabecera de la pantalla con la imagen de la pelicula seleccionada
                _Overview(movie: peli), //Sinopsis de la película
                CastingCards(peli.id), //Actores de reparto
              ],
            ),
          ),
        ],
      ),
    );
  }
}

//Clase privada _CustomAppBar que devuelve la imagen de la película para mostrarla en la parte superior de la pantalla
class _CustomAppBar extends StatelessWidget {
  final Movie movie;

  //Método constructor nombrado
  const _CustomAppBar({required this.movie});
  @override
  Widget build(BuildContext context) {
    //Se da formato a la información
    return SliverAppBar(
      backgroundColor: Colors.indigo,
      expandedHeight: 200,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: const EdgeInsets.all(0),
        title: Container(
          width: double.infinity,
          alignment: Alignment.bottomCenter,
          color: Colors.black12,
          padding: const EdgeInsets.only(bottom: 10),
          child: Text(
            movie.title, //Título de la película obtenida con el método getter
            style: const TextStyle(fontSize: 16),
          ),
        ),
        background: FadeInImage(
          //Imagen por defecto si no se encuentra una portada
          placeholder: const AssetImage('assets/loading.gif'),
          //Carátula de la película obtenida con el método getter
          image: NetworkImage(movie.fullPosterPath),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

/*
Clase privada _PosterAndTitle que devuelve la imagen de la película, el título y su título original, así como
la nota media de valoración.
*/
class _PosterAndTitle extends StatelessWidget {
  final Movie movie;

  //Método constructor nombrado
  const _PosterAndTitle({required this.movie});

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    //Se da formato a la información
    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
              //Imagen por defecto si no se encuentra una portada
              placeholder: const AssetImage('assets/loading.gif'),
              //Carátula de la película obtenida con el método getter
              image: NetworkImage(movie.fullPosterPath),
              height: 150,
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: Column(
              children: [
                Text(
                  movie
                      .title, //Título de la película obtenida con el método getter
                  style: textTheme.headlineSmall,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                ),
                Text(
                  'Título original: ${movie.originalTitle}', //Título original de la película
                  style: textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                Row(
                  children: [
                    const Icon(Icons.star_outline,
                        size: 15, color: Colors.grey),
                    const SizedBox(width: 5),
                    Text(
                      'Nota media: ${movie.voteAverage}', //Valoración
                      style: textTheme.bodySmall,
                      textAlign: TextAlign.center,
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

//Clase privada _Overview que devuelve la sinopsis de la película.
class _Overview extends StatelessWidget {
  final Movie movie;
  const _Overview({required this.movie});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Text(
        movie.overview, //Sinopsis de la película obtenida con el método getter
        textAlign: TextAlign.justify,
        style: Theme.of(context).textTheme.titleMedium,
      ),
    );
  }
}
