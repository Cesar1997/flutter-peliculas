


import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:peliculas/src/models/pelicula_model.dart';

class PeliculasProvider {
  String _apiKey    = '0b5c6b902490db711ef7956d6be7f418';
  String _url       = 'api.themoviedb.org';
  String _language  = 'es-ES';

  int _popularesPage = 1;
  bool _cargando = false;

  List<Pelicula> _populares = new List();

  //Steam , corriente de datos.
  //Si no se agrega el broadcast, solo habra una escucha(listener), al agregarle el broadcast varios widget podran escuchar.

  final _popularesStreamController = StreamController<List<Pelicula>>.broadcast();


  //Para agregar
  Function(List<Pelicula>) get popularesSink => _popularesStreamController.sink.add;

  //Para escuchar
  Stream<List<Pelicula>> get popularesStream => _popularesStreamController.stream;


  //Los streams se tienen que cerrar para que no abra muchos hilos
  void disposeStreams(){
    _popularesStreamController?.close(); //el ? es para decirle que si existe el metodo close lo llame
  }
  

  Future<List<Pelicula>> _procesarRespuesta(Uri url) async{
    
      final resp = await http.get(url);
      final decodedData = json.decode(resp.body);

      final peliculas = new Peliculas.fromJsonList(decodedData['results']);
      return peliculas.items;
  }

  Future <List<Pelicula>> getEnCines() async{
    final url = Uri.https(_url, '3/movie/now_playing',{
      'api_key'   : _apiKey,
      'language'  : _language
    }); 

    return await _procesarRespuesta(url);

  }

  Future <List<Pelicula>> getPopulares() async{
      if(_cargando) return [];

      _cargando = true;

      _popularesPage++;
      final url = Uri.https(_url, '3/movie/popular',{
        'api_key' : _apiKey,
        'language' : _language,
        'page'     : _popularesPage.toString()
      });
      final resp = await _procesarRespuesta(url);
      _populares.addAll(resp);
      popularesSink(_populares);
      _cargando = false;
      return resp;
      //return await _procesarRespuesta(url);

  }
}

