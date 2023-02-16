/*
Clase que contiene un Widget de tipo ListView que se utiliza para mostrar en la App las
carátulas de las películas más populares.
*/

import 'package:flutter/material.dart';
import '../models/models.dart';

class MovieSlider extends StatelessWidget {
  final List<Movie> movies;

  const MovieSlider({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    /*
    Eliminamos el bug inicial para que en lugar de salir el mensaje de error, salga un CircularProgressIndicator
    y así mejorar la apariencia para el usuario.
    */
    if (movies.length == 0) {
      return Container(
        width: double.infinity,
        height: size.height * 0.5,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    //Creación del ListView que mostrará las imagenes de las películas.
    return Container(
      width: double.infinity,
      height: 260,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text('Populares',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(
            height: 5,
          ),
          Expanded(
            //Método constructor nombrado
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: movies.length, //Tamaño de la List<Movie>

                //Llamada al método privado _MoviePoster para la película del index
                itemBuilder: (_, int index) =>
                    _MoviePoster(myMovie: movies[index])),
          )
        ],
      ),
    );
  }
}

//Creación del ClipRRect que mostrará las imagenes de las películas.
class _MoviePoster extends StatelessWidget {
  final Movie myMovie;

  const _MoviePoster({required this.myMovie});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      height: 190,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          //Al pulsar sobre una imagen, se navega a la pantalla de detalles de esa película
          GestureDetector(
            onTap: () =>
                Navigator.pushNamed(context, 'details', arguments: myMovie),

            //Se da formato y se rellenan las tarjetas con las imagenes correspondientes
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                placeholder: const AssetImage('assets/no-image.jpg'),
                image: NetworkImage(myMovie
                    .fullPosterPath), //Llamada al método getter para obtener la imagen de la película
                width: 130,
                height: 190,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            myMovie.title, //Titulo de la película con el método getter
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
