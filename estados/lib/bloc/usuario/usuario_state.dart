part of 'usuario_bloc.dart';

class UsuarioState {

  final bool existeUsuario;
  final Usuario? usuario;

  UsuarioState({Usuario? user})
  : this.usuario = user ?? null,
  existeUsuario = (user != null) ? true : false;

  //Si el estado tiene mas propiedades tambien deberiamos usar un metodo copyWith como en el modelo de usuario

  UsuarioState copyWith({Usuario? usuario}) => UsuarioState(
    user: usuario ?? this.usuario
  );

  UsuarioState estadoInicial() => new UsuarioState();

}