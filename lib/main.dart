/*
Esta App permite visualizar las películas que están actualmente en cartelera, así como las películas
favoritas. Al seleccionar una imagen, se navegará a la pantalla de detalles donde se muestra información
adicional de la película seleccionada (título original, valoración y reparto).

Con este proyecto se ha continuado trabajando con la navegación de pantallas, paso de parámetros y cásting de
objetos, así como la incorporación de las consultas a un REST API para obtener la información directamente de
un provider (métodos asíncronos). La interacción se ha realizado con el Widget GestureDetector.

Finalmente, se ha trabajado una nueva forma de estructurar el proyecto, así como los imports en una sola línea, 
gracias a la utilización de la palabra reservada 'export'.
*/

import 'package:flutter/material.dart';
import 'package:movies_app/providers/movies_provider.dart';
import 'package:movies_app/screens/screens.dart';
import 'package:provider/provider.dart';

//Se inicia el programa desde el método principal main()
void main() => runApp(const AppState());

class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    //Se utiliza MultiProvider por simplicidad, aunque solo tengamos un único provider
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          /*Creación de la primera instancia de MoviesProvider, que hará la petición http
            para almacenar las películas a mostrar en la App
          */
          create: (_) => MoviesProvider(),
          lazy: false,
        ),
      ],
      child: MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pel·lícules',
      initialRoute: 'home', //Pantalla inicial HomeScreen()
      routes: {
        'home': (BuildContext context) => HomeScreen(),
        'details': (BuildContext context) => DetailsScreen(),
      },
      theme: ThemeData.light()
          .copyWith(appBarTheme: const AppBarTheme(color: Colors.indigo)),
    );
  }
}
