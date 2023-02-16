/*
Clase que contiene un Widget de tipo ListView que se utiliza para mostrar en la App las
carátulas de los actores que han participado en una película en concreto.
*/

import 'package:flutter/material.dart';
import 'package:movies_app/models/models.dart';
import 'package:movies_app/providers/movies_provider.dart';
import 'package:provider/provider.dart';

class CastingCards extends StatelessWidget {
  final int idMovie;

  const CastingCards(this.idMovie, {super.key});
  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);

    //Método constructor FutureBuilder que devuelve una lista de actores (tipo List<Cast>)
    return FutureBuilder(
      future: moviesProvider.getMovieCast(
          idMovie), //Método getter para la ID pasada por parámetro
      builder: (BuildContext context, AsyncSnapshot<List<Cast>> snapshot) {
        //Si la lista está vacía, se muestra un CircularProgressIndicator (círculo de carga de datos)
        if (!snapshot.hasData) {
          return Container(
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        //Declaración e inicialización del objeto casting que siempre tendrá valor.
        final List<Cast> casting = snapshot.data!;

        //Creación del ListView que mostrará las imagenes de los actores.
        return Container(
          margin: const EdgeInsets.only(bottom: 30),
          width: double.infinity,
          height: 180,

          //Método constructor nombrado
          child: ListView.builder(
            itemCount: casting.length, //Tamaño de la List<Cast>
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) => _CastCard(casting[
                index]), //Llamada al método privado _CastCard para el actor del index
          ),
        );
      },
    );
  }
}

//Creación del ClipRRect que mostrará las imagenes de los actores del reparto.
class _CastCard extends StatelessWidget {
  final Cast myCast;

  const _CastCard(this.myCast);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      width: 110,
      height: 100,
      child: Column(
        children: [
          //Se da formato y se rellenan las tarjetas con las imagenes correspondientes
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
              placeholder: const AssetImage('assets/no-image.jpg'),
              image: NetworkImage(myCast
                  .fullProfilePath), //Llamada al método getter para obtener la imagen del actor
              height: 140,
              width: 100,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            myCast.name, //Nombre del actor
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
