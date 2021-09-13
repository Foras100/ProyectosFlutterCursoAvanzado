import 'dart:async';

import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;
import 'package:mapas_app/helpers/debouncer.dart';
import 'package:mapas_app/models/driving_response.dart';
import 'package:mapas_app/models/search_response.dart';

class TrafficService {

  //Singleton
  TrafficService._privateConstructor();
  static final TrafficService _instance = TrafficService._privateConstructor() ;
  factory TrafficService(){
    return _instance;
  }

  final _dio = new Dio();
  final debouncer = Debouncer<String>(duration: Duration(milliseconds: 400 ));
  final StreamController<SearchResponse> _sugerenciasStreamController = StreamController<SearchResponse>.broadcast();
  Stream<SearchResponse> get sugerenciasStream => this._sugerenciasStreamController.stream;
  final _baseUrlDir = 'https://api.mapbox.com/directions/v5';
  final _baseUrlGeo = 'https://api.mapbox.com/geocoding/v5';
  final _apiKey = 'pk.eyJ1IjoibHVjaWFub2ZvcmFzIiwiYSI6ImNrNXYya21xNzBxNHkzbmswbDZ2b3VkeGcifQ.Y8Pihn9y2xTwraRRy6LVjQ';
  
  Future<DrivingResponse> getCoordsInicioYFin(LatLng inicio, LatLng destino) async {
    print(inicio);
    print(destino);

    final coordString = '${inicio.longitude},${inicio.latitude};${destino.longitude},${destino.latitude}';
    final url = '${this._baseUrlDir}/mapbox/driving/$coordString';

    final resp = await this._dio.get(url, queryParameters: {
      "alternatives" : "true",
      "access_token" : this._apiKey,
      "geometries"   : "polyline6",
      "steps"        : "false",
      "language"     : "es",
    });

    final data = DrivingResponse.fromJson(resp.data);

    return data;
  }

  Future<SearchResponse> getResultadosPorQuery(String busqueda, LatLng proximidad) async {
    print('Buscando...');
    final url = '${this._baseUrlGeo}/mapbox.places/$busqueda.json';

    try {
      final resp = await this._dio.get(url, queryParameters: {
        "access_token" : this._apiKey,
        "autocomplete" : true,
        "proximity"    : '${proximidad.longitude},${proximidad.latitude}',
        "language"     : 'es'
      });

      final searchResponse = searchResponseFromJson(resp.data);
      return searchResponse;
      
    } catch (e) {
      return SearchResponse(attribution: '', query: [], features: [], type: '');
    }

    
  }

  void getSugerenciasPorQuery( String busqueda, LatLng proximidad ) {
    debouncer.value = '';
    debouncer.onValue = ( value ) async {
      final resultados = await this.getResultadosPorQuery(value, proximidad);
      this._sugerenciasStreamController.add(resultados);
    };

    final timer = Timer.periodic(Duration(milliseconds: 200), (_) {
      debouncer.value = busqueda;
    });

    Future.delayed(Duration(milliseconds: 201)).then((_) => timer.cancel()); 

  }

}