part of 'widgets.dart';

class SearchBar extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    
    return BlocBuilder<BusquedaBloc, BusquedaState>(
      builder: (BuildContext context, state) {
        if(state.seleccionManual){
          return Container();
        }
        else{
          return FadeInDown(
            duration: Duration(milliseconds: 500),
            child: buildSearchbar(context)
          );
        }
      });
  }
  
  Widget buildSearchbar(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        width: width,
        child: GestureDetector(
          onTap: () async {
            final proximidad = context.read<MiUbicacionBloc>().state.ubicacion;
            final historial = context.read<BusquedaBloc>().state.historial;
            final resultado = await showSearch(
              context: context,
              delegate: SearchDestination(proximidad!, historial)
            );
            this.retornoBusqueda(context, resultado);
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 13),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(100),
              boxShadow: [
                BoxShadow(color: Colors.black12, blurRadius: 5, offset: Offset(0,5))
              ]
            ),
            child: Text('¿Dónde quieres ir?', style: TextStyle(color: Colors.black87)),
          ),
        ),
      ),
    );
  }

  Future<void> retornoBusqueda(BuildContext context, SearchResult? result) async {
    if(result == null) return;

    if(result.cancelo) return;

    if(result.manual == true){
      BlocProvider.of<BusquedaBloc>(context).add(OnActivarMarcadorManual());
      return;
    }

    calculandoAlerta(context);

    //Calcular la ruta en base al valor del result
    final trafficService = TrafficService();
    final mapaBloc = context.read<MapaBloc>();

    final inicio = context.read<MiUbicacionBloc>().state.ubicacion;
    final destino = result.position;

    final drivingResponse = await trafficService.getCoordsInicioYFin(inicio!, destino!);
    final geometry = drivingResponse.routes[0].geometry;
    final duracion = drivingResponse.routes[0].duration;
    final distancia = drivingResponse.routes[0].distance;

    final points = Poly.Polyline.Decode(encodedString: geometry, precision: 6);
    final List<LatLng> rutaCoordenadas = points.decodedCoords.map((point) => LatLng(point[0], point[1])).toList();

    mapaBloc.add(OnCrearRutaInicioDestino(rutaCoordenadas, distancia, duracion));
    Navigator.of(context).pop();

    final busquedaBloc = context.read<BusquedaBloc>();
    busquedaBloc.add(OnAgregarHistorial(result));
  }

}