import 'package:flutter/material.dart';
import 'package:peliculas/src/providers/peliculas_provider.dart';
import 'package:peliculas/src/widgets/card_swiper_widget.dart';

import 'models/pelicula_model.dart';
class HomePage extends StatelessWidget {
  final peliculasProvider = new PeliculasProvider();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Peliculas en cines'),
        backgroundColor: Colors.indigoAccent,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: (){},
          )
        ],
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround, //Espacio entre los elementos 
          children: <Widget>[
            _swipperTarjetas(),
            _footer(context),
          ],
        ),
      )
    );
  }

 Widget _swipperTarjetas() {
   return FutureBuilder(
     future: peliculasProvider.getEnCines(),
     builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
       if(snapshot.hasData ){
          return  CardSwiper( peliculas: snapshot.data);
       } else {
         return Container(
           height: 400.0,
           child: Center(
             child: CircularProgressIndicator(
               backgroundColor: Colors.red,
             ),
           ),
         );
       }
     },
   );
   //peliculasProvider.getEnCines();
   //return  CardSwiper(
     //peliculas: [1,2,3,4,6],
   //);
 }
 Widget _footer(BuildContext  context){
   print(peliculasProvider.getPopulares());
   return Container(
     width: double.infinity, //Que utilize todo el espacio 
     child: Column(
       children: <Widget>[
         Text('Populares', 
              style: Theme.of(context).textTheme.subhead, //Utiliza el subcolor del tema definido
          ),
          FutureBuilder(
            future: peliculasProvider.getPopulares(),
            builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
              //print(snapshot.data);
              snapshot.data?.forEach((p) => print(p.title)); // el '?' delante del data significa que si existe data
              return Container();
            },
          ),
       ],
     ),
   );

 }
}