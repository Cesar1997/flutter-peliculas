import 'package:flutter/material.dart';
import 'package:peliculas/src/models/pelicula_model.dart';

class MovieHorizontal extends StatelessWidget {
  final List<Pelicula> peliculas;
  final Function siguientePagina; //Funcion que espera
  MovieHorizontal({
    @required this.peliculas,
    @required this.siguientePagina
  });

  final _pageController = new PageController(    
    initialPage: 1,
    viewportFraction: 0.3
  );

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    _pageController.addListener((){
      if(_pageController.position.pixels >= _pageController.position.maxScrollExtent - 200){
        siguientePagina();
        //print('Llegandooo');
      }
    });


    return Container(
      height: _screenSize.height  * 0.25,
      child: PageView.builder( //Difrerencias entre el Pageview.builder es que los carga mientras lo necesite
        pageSnapping: false,
        itemCount: peliculas.length,
        itemBuilder: (context, i) => _crearTarjeta(context, peliculas[i]),
        //children: _tarjetas(context),
        controller: _pageController,
      ),
    );
  }

  Widget _crearTarjeta(BuildContext context,Pelicula pelicula){
    
    pelicula.uniqueId = '${pelicula.id}-poster';
    final tarjeta = Container(
        margin: EdgeInsets.only(right: 15.0),
        child: Column(
          children: <Widget>[
            Hero(
              tag: pelicula.uniqueId,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: FadeInImage(
                  image: NetworkImage(pelicula.getPosterImg()),
                  placeholder: AssetImage('assets/img/no-image.jpg'),
                  fit: BoxFit.cover,
                  height: 160.0,
                ),
              ),
            ),
            Text(
              pelicula.title,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.caption,
            )
          ],
        ),
    );

    return GestureDetector(
      onTap: (){
        print('ID DE LA PELICULA ${ pelicula.id}');
        Navigator.pushNamed(context, 'detalle', arguments: pelicula);
      },
      child: tarjeta,
    );
  }

  // List<Widget>  _tarjetas(BuildContext context) {
  //   return peliculas.map((pelicula){
  //       return Container(
  //         margin: EdgeInsets.only(right: 15.0),
  //         child: Column(
  //           children: <Widget>[
  //             ClipRRect(
  //               borderRadius: BorderRadius.circular(20.0),
  //               child: FadeInImage(
  //                 image: NetworkImage(pelicula.getPosterImg()),
  //                 placeholder: AssetImage('assets/img/no-image.jpg'),
  //                 fit: BoxFit.cover,
  //                 height: 160.0,
  //               ),
  //             ),
  //             Text(
  //               pelicula.title,
  //               overflow: TextOverflow.ellipsis,
  //               style: Theme.of(context).textTheme.caption,
  //             )
  //           ],
  //         ),
  //       );
  //   }).toList();
  // }
}