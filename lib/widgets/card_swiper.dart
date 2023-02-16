//Widget de tipo Swiper que se utiliza para mostrar en la App las carátulas de las películas que actualmente están en cartelera

import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import '../models/models.dart';

class CardSwiper extends StatelessWidget {
  final List<Movie> movies;

  const CardSwiper({Key? key, required this.movies}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    //Eliminamos el bug inicial para que en lugar de salir el mensaje de error, salga un CircularProgressIndicator y así mejorar la apariencia
    if (this.movies.length == 0) {
      return Container(
        width: double.infinity,
        height: size.height * 0.5,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    return Container(
        width: double.infinity,
        // Aquest multiplicador estableix el tant per cent de pantalla ocupada 50%
        height: size.height * 0.5,
        // color: Colors.red,
        child: Swiper(
          itemCount: movies.length, //Tamaño dinámico según lista
          layout: SwiperLayout.STACK,
          itemWidth: size.width * 0.6,
          itemHeight: size.height * 0.4,
          //itemBuilder: Creación de cada una de las tarjetas
          itemBuilder: (BuildContext context, int index) {
            final movie = movies[
                index]; //Variable que almacena el objeto Movie, del índice recibido desde el itemBuilder
            return GestureDetector(
              onTap: () =>
                  Navigator.pushNamed(context, 'details', arguments: movie),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: FadeInImage(
                    //placeholder: muestra la imagen por defecto - sin imagen
                    placeholder: AssetImage('assets/no-image.jpg'),
                    //image: muestra la imagen de la película en el index correspondiente
                    image: NetworkImage(movie
                        .fullPosterPath), //llamada al método getter para obtener la carátula
                    fit: BoxFit.cover),
              ),
            );
          },
        ));
  }
}
