import 'package:estados/bloc/usuario/usuario_bloc.dart';
import 'package:estados/models/usuario.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class Pagina2Page extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final usuarioBloc = BlocProvider.of<UsuarioBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Pagina 2'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MaterialButton(
              child: Text('Establecer Usuario', style: TextStyle(color: Colors.white),),
              color: Colors.blue,
              onPressed: (){
                final newUser = Usuario(nombre:'Foras', edad: 28, profesiones: ['FullStack Developer','Catador de Hamburguesas']);
                usuarioBloc.add(ActivarUsuario(newUser));
              }
            ),
            MaterialButton(
              child: Text('Cambiar Edad', style: TextStyle(color: Colors.white),),
              color: Colors.blue,
              onPressed: (){
                usuarioBloc.add(CambiarEdad(30));
              }
            ),
            MaterialButton(
              child: Text('Añadir Profesion', style: TextStyle(color: Colors.white),),
              color: Colors.blue,
              onPressed: (){
                usuarioBloc.add(AgregarProfesion('Nuevo profesion'));
              }
            ),
          ],
        )
     ),
   );
  }
}