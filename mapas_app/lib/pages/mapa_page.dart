import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mapas_app/bloc/mapa/mapa_bloc.dart';
import 'package:mapas_app/bloc/mi_ubicacion/mi_ubicacion_bloc.dart';
import 'package:mapas_app/widgets/widgets.dart';

class MapaPage extends StatefulWidget {
  @override
  _MapaPageState createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage> {
  LatLng? ultimaPosicionCamara;

  @override
  void initState() {
    //context.read<MiUbicacionBloc>().iniciarSeguimiento();
    BlocProvider.of<MiUbicacionBloc>(context).iniciarSeguimiento();
    super.initState();
  }

  @override
  void dispose() {
    BlocProvider.of<MiUbicacionBloc>(context).cancelarSeguimiento();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BlocBuilder<MiUbicacionBloc, MiUbicacionState>(
            bloc: BlocProvider.of<MiUbicacionBloc>(context),
            builder: (_, state) => SafeArea(child: crearMapa(state)),
          ),
          

          Positioned(
            top: 15,
            child: SearchBar()
          ),
          
          MarcadorManual()
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          BtnUbicacion(),
          BtnSeguirUbicacion(),
          BtnMiRuta()
        ],
      ),
    );
  }

  Widget crearMapa(MiUbicacionState state){

    if(!state.existeUbicacion) return Center(child: Text('Ubicando...'));

    final mapaBloc = BlocProvider.of<MapaBloc>(context);

    mapaBloc.add(OnNuevaUbicacion(state.ubicacion!));

    final cameraPosition = CameraPosition(
      target: state.ubicacion!,
      zoom: 17
    );

    return BlocBuilder<MapaBloc,MapaState>(
      builder: (BuildContext context, _) 
      {
        return GoogleMap(
          initialCameraPosition: cameraPosition,
          mapType: MapType.normal,
          myLocationButtonEnabled: false,
          myLocationEnabled: true,
          zoomControlsEnabled: false,
          onMapCreated: mapaBloc.initMapa,
          polylines: mapaBloc.state.polylines.values.toSet(),
          onCameraMove: (cameraPosition){
            this.ultimaPosicionCamara = cameraPosition.target;
          },
          onCameraIdle: () => mapaBloc.add(OnMovioMapa(this.ultimaPosicionCamara!)),
        );
      },
    );
  }
}
