import 'package:flutter/material.dart';
import 'package:statemanagment_example/src/bloc/home_bloc.dart';
import 'package:statemanagment_example/src/models/usuario.dart';

class HomePage extends StatefulWidget {
  
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  HomeBloc homeBloc = HomeBloc();

  TextEditingController _nombreController = TextEditingController();
  TextEditingController _edadController = TextEditingController();
  TextEditingController _apellidoController =TextEditingController();

  @override
  void initState() { 
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
      ),
      body: StreamBuilder(
        stream: homeBloc.listaUsuarioStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Usuario> usuarios = snapshot.data;

            return ListView.builder(
              itemCount: usuarios.length,
              itemBuilder: (context, index) {
                final usuario = usuarios[index];
                final nombre = usuario.nombre;
                final apellido = usuario.apellido;
                final edad = usuario.edad;

                return ListTile(
                  title: Text("$nombre $apellido"),
                  subtitle: Text("Edad: $edad"),
                  onTap: () => _mostrarDialogEdicion(usuario),
                );
              },
            );
          }

          return Center(
            child: CircularProgressIndicator(),
          );
        },
      )
    );
  }

  _mostrarDialogEdicion(Usuario mUsuario) {
    _nombreController.text = mUsuario.nombre ?? '';
    _apellidoController.text = mUsuario.apellido ?? '';
    _edadController.text = mUsuario.edad.toString() ?? "0";

    showDialog(
      context: context,
      builder: (context) {

        return AlertDialog(
          content: Column(
            children: [
              TextField(
                controller: _nombreController,
                decoration: InputDecoration(
                  labelText: "Nombre"
                ),
              ),
              TextField(
                controller: _apellidoController,
                decoration: InputDecoration(
                  labelText: "Apellido"
                ),
              ),
              TextField(
                controller: _edadController,
                decoration: InputDecoration(
                  labelText: "Edad"
                ),
              )
            ]
          ),
          actions: [
            FlatButton(
              child: Text("Guardar Cambios"),
              onPressed: () {
                String nombre = _nombreController.text;
                String apellido = _apellidoController.text;
                int edad = int.parse(_edadController.text);

                Usuario nuevoUsuario = Usuario(nombre: nombre, apellido: apellido, edad: edad);
                homeBloc.modificarUsuario(
                  mUsuario: mUsuario,
                  mNuevoUsuario: nuevoUsuario
                );

                Navigator.pop(context);
              },
            )
          ],
        );
      }
    );
  }
}