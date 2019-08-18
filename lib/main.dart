import 'package:flutter/material.dart';
import 'package:peliculas/src/home_page.dart';
import 'package:peliculas/src/widgets/pelicula_detalle.dart';
/*  
  UserAccount
  devflutterCesar
  devflutt3r

 */ 

void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Peliculas',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/' : (BuildContext context) => HomePage(),
        'detalle' : (BuildContext context) => PeliculaDetalle()
      },
    );
  }
}