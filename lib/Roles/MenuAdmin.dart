import 'package:flutter/material.dart';

import '../DTO/UserObject.dart';

class MenuAdmin extends StatefulWidget {
  final UserObject userOb1;
  MenuAdmin(this.userOb1);
  MenuAdminApp createState() => MenuAdminApp();
}

class MenuAdminApp extends State<MenuAdmin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hola ' + widget.userOb1.doc + ' administrador'),
        backgroundColor: Colors.indigo,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 10, top: 40, right: 10, bottom: 0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo, minimumSize: Size(400, 50)),
                onPressed: () {},
                child: Text(
                  'Gestión de usuario',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10, top: 20, right: 10, bottom: 0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo, minimumSize: Size(400, 50)),
                onPressed: () {},
                child: Text(
                  'Gestión de usuario',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}