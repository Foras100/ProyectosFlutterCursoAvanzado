import 'package:flutter/material.dart';


class Pagina1Page extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pagina 1'),
      ),
      body: InforrmacionUsuario(),
     floatingActionButton: FloatingActionButton(
       onPressed: () => Navigator.pushNamed(context, 'pagina2'),
       child: Icon(Icons.add),
     ),
   );
  }
}

class InforrmacionUsuario extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('General', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Divider(),
          ListTile(  title: Text('Nombre: ')),
          ListTile(  title: Text('Edad: ')),
          Text('Profesiones', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Divider(),
          ListTile(  title: Text('Profesion 1')),
          ListTile(  title: Text('Profesion 2')),
          ListTile(  title: Text('Profesion 3')),
        ],
      )
    );
  }
}