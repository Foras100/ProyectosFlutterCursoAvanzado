import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;
import 'package:mapas_app/models/search_response.dart' show SearchResponse;
import 'package:mapas_app/models/search_result.dart';
import 'package:mapas_app/services/traffic_service.dart';

class SearchDestination extends SearchDelegate<SearchResult> {

  @override
  final String searchFieldLabel;
  final TrafficService _trafficService;
  final LatLng proximidad;
  final List<SearchResult> historial;

  SearchDestination(this.proximidad, this.historial) 
  : this.searchFieldLabel = 'Buscar...',
  this._trafficService = new TrafficService();

  @override
  List<Widget> buildActions(BuildContext context) {    
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () => this.query = ''
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back_ios),
      onPressed: () => this.close(context, SearchResult(cancelo: true))
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    
    return this._construirResultadosSugerencias();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if(this.query.length == 0){
      return ListView(
        children: [
          ListTile(
            leading: Icon(Icons.location_on),
            title: Text('Colocar ubicación manualmente'),
            onTap: () {
              //TODO: Retornar algo
              this.close(context, SearchResult(cancelo: false, manual: true));
            },
          ),

          ...this.historial.map(
            (result) => ListTile(
              leading: Icon(Icons.history),
              title: Text(result.nombreDestino!),
              subtitle: Text(result.descripcion!),
              onTap: () => this.close(context, SearchResult(cancelo: false, manual: false, position: result.position, nombreDestino: result.nombreDestino, descripcion: result.descripcion))
            )
          ).toList().reversed
        ],
      );
    }
    
    return this._construirResultadosSugerencias();
    
  }

  Widget _construirResultadosSugerencias() {
    if(this.query.length == 0){
      return Container();
    }
    this._trafficService.getSugerenciasPorQuery(this.query.trim(), this.proximidad);

    //this._trafficService.getResultadosPorQuery(this.query.trim(), this.proximidad)
    return StreamBuilder(
      stream: this._trafficService.sugerenciasStream,
      builder: (BuildContext context, AsyncSnapshot<SearchResponse> snapshot) {
        if(!snapshot.hasData){
          return Center(child: CircularProgressIndicator());
        }
        
        final lugares = snapshot.data!.features;
        if(lugares.length == 0){
          return ListTile(
            title: Text('No hay resultado con $query'),
          );
        }

        return ListView.separated(
          itemBuilder: (_, i) {
            final lugar = lugares[i];
            return ListTile(
              leading: Icon(Icons.place),
              title: Text(lugar.text),
              subtitle: Text(lugar.placeName),
              onTap: (){
                this.close(context, SearchResult(
                  cancelo: false,
                  manual: false,
                  position: LatLng(lugar.center[1], lugar.center[0]),
                  nombreDestino: lugar.text,
                  descripcion: lugar.placeName
                ));
              },
            );
          },
          separatorBuilder: (_, i) => Divider(),
          itemCount: lugares.length
        );
      },
    );
  }

}