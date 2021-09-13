part of 'widgets.dart';

class BtnUbicacion extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final mapaBloc = BlocProvider.of<MapaBloc>(context);
    final miUbicacioBloc = BlocProvider.of<MiUbicacionBloc>(context);

    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: CircleAvatar(
        backgroundColor: Colors.white,
        radius: 25,
        child: IconButton(
          icon: Icon(Icons.my_location, color: Colors.black87),
          onPressed: (){
            final destino = BlocProvider.of<MiUbicacionBloc>(context).state.ubicacion;
            mapaBloc.moverCamara(destino!);
          },
        ),
      ),
    );
  }
}