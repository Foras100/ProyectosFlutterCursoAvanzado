import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;
import 'package:meta/meta.dart';

part 'mi_ubicacion_event.dart';
part 'mi_ubicacion_state.dart';

class MiUbicacionBloc extends Bloc<MiUbicacionEvent, MiUbicacionState> {
  MiUbicacionBloc() : super(MiUbicacionState());

  StreamSubscription<Position>? _positionSubscription;

  void iniciarSeguimiento(){
    // final locationOptions = LocationOptions(
    //   accuracy: LocationAccuracy.high,
    //   distanceFilter: 10
    // );
    this._positionSubscription = GeolocatorPlatform.instance.getPositionStream(
      desiredAccuracy: LocationAccuracy.high,
      distanceFilter: 10
    ).listen((Position position) {
      print(position);
      final nuevaUbicacion = LatLng(position.latitude,position.longitude);
      add(OnUbicacionCambio(nuevaUbicacion));
    });
  }

  void cancelarSeguimiento(){
    this._positionSubscription?.cancel();
  }


  @override
  Stream<MiUbicacionState> mapEventToState(MiUbicacionEvent event) async* {
    if(event is OnUbicacionCambio){
      yield state.copyWith(
        existeUbicacion: true,
        ubicacion: event.ubicacion
      );
    }
  }
}
