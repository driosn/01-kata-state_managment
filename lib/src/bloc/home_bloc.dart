import 'dart:async';

import 'package:statemanagment_example/src/models/usuario.dart';

import 'package:rxdart/rxdart.dart';

class HomeBloc {

  HomeBloc() {
    cambiarListaUsuario(List<Usuario>());
    llenarListaUsuarios();
  }

  llenarListaUsuarios() {
    List<Usuario> nuevaListaUsuarios = List<Usuario>();

    nuevaListaUsuarios.add(Usuario(nombre: "Manuel", apellido: "Rios", edad: 15));
    nuevaListaUsuarios.add(Usuario(nombre: "Paulo", apellido: "Corrales", edad: 40));
    nuevaListaUsuarios.add(Usuario(nombre: "Aya", apellido: "Madrid", edad: 25));
    nuevaListaUsuarios.add(Usuario(nombre: "Aurelio", apellido: "Lozano", edad: 12));
    nuevaListaUsuarios.add(Usuario(nombre: "Adam", apellido: "Adam", edad: 60));

    cambiarListaUsuario(nuevaListaUsuarios);
  }

  // Controller
  BehaviorSubject<List<Usuario>> _listaUsuariosController = BehaviorSubject<List<Usuario>>();

  // Stream
  Stream<List<Usuario>> get listaUsuarioStream => _listaUsuariosController.stream;

  // Input
  Function(List<Usuario>) get cambiarListaUsuario => _listaUsuariosController.sink.add;

  // Value
  List<Usuario> get listaUsuario => _listaUsuariosController.value;

  modificarUsuario({
    Usuario mUsuario,
    Usuario mNuevoUsuario
  }) {
    List<Usuario> usuariosActuales = listaUsuario ?? List<Usuario>();

    for(int i =0; i < usuariosActuales.length; i++) {
      if (usuariosActuales[i].nombre == mUsuario.nombre) {
        usuariosActuales[i] = mNuevoUsuario;
      }
    }

    cambiarListaUsuario(usuariosActuales);
  }

  void dispose() {
    _listaUsuariosController?.close();
  }

}