part of 'usuario_cubit.dart';

@immutable
abstract class UsuarioState { }

class UsuarioInitial extends UsuarioState{
  final existeUsuario = false;

  // @override
  // String toString() {
  //   return 'UsuarioInicial => existeUsuario: false';
  // }
}

class UsuarioActivo extends UsuarioState{
  final existeUsuario = true;
  final Usuario usuario;

  UsuarioActivo(this.usuario);
}