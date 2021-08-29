import 'dart:async';

import 'package:estados/models/usuario.dart';

class _UsuarioService {

  Usuario? _usuario;

  StreamController<Usuario> _usuarioStreamController = StreamController<Usuario>();

  Usuario? get usuario => this._usuario;
  bool get existeUsuario => this._usuario != null ? true : false;
  Stream<Usuario?> get usuarioStream => _usuarioStreamController.stream;

  void cargarUsuario(Usuario user){
    this._usuario = user;
  }

  void cambiarEdad(int edad){
    this._usuario!.edad = edad;
  }
}

final usuarioService = _UsuarioService();