
import 'package:flutter/material.dart';
import 'package:proyectolineados/Vista/Login.dart';
import 'package:proyectolineados/Vista/Geocalizacion.dart';
import 'package:proyectolineados/Vista/Vista_Tienda/Tiendas.dart';
import 'package:proyectolineados/Vista/moneda.dart';


class Menu extends StatefulWidget {
  @override
  MenuApp createState() => MenuApp();
}

class MenuApp extends State<Menu>{
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Proyecto Mi Tiendita',
      theme: ThemeData(primarySwatch: Colors.green),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Bienvenidos Al Menu Principal De Mi tiendita'),
          backgroundColor: Colors.green,
        ),
        body: SingleChildScrollView(
          //Osea que puede crecer verticalmente tanto como lo necesite
          child: Column(
            //Creamos una unica columna, por es se ve centrado
            //Con una seria de componentes dentro de un Array
            children: [
              Padding(padding: EdgeInsets.all(20),
                //La imagen iria centrada
                child: Center(
                  child: Container(
                    //Nos permite crear un contenedor para poner la imagen y configurar el tamaño que queramos
                    width: 500,
                    height: 500,
                    child: Image.asset('imagenes/menu.png'),
                  ),
                ),
              ),
              //El padding tiene caracteristicas de centrado,
              Padding (padding: EdgeInsets.only(left: 2, top: 2, right: 2),
                child: Center(
                  child: ElevatedButton(style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green, minimumSize: Size(200, 50)),
                    onPressed: (){
                      print('Boton De Geocalizacion Presionado');
                      // El materialpageroute sirve para direccionar la pagina que necesitamos
                      Navigator.push(context, MaterialPageRoute(builder: (_)=> Geocalizacion()) );
                    },
                    child: Text('Geocalizacion', style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
              ),
              Padding (padding: EdgeInsets.only(left: 20, top: 30, right: 10),
                child: Center(
                  child: ElevatedButton(style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green, minimumSize: Size(200, 50)),
                    onPressed: (){
                      print('Boton De Geocalizacion Presionado');
                      // El materialpageroute sirve para direccionar la pagina que necesitamos
                      Navigator.push(context, MaterialPageRoute(builder: (_)=> moneda()) );
                    },
                    child: Text('Cambio Moneda', style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
              ),
              Padding (padding: EdgeInsets.only(left: 20, top: 30, right: 10),
                child: Center(
                  child: ElevatedButton(style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green, minimumSize: Size(200, 50)),
                    onPressed: (){
                      print('Boton Api Presionado');
                      // El materialpageroute sirve para direccionar la pagina que necesitamos
                      // Navigator.push(context, MaterialPageRoute(builder: (_)=> rest()) );
                    },
                    child: Text('Api', style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
              ),

                Padding(padding: EdgeInsets.only(left: 20, top: 30, right: 10),
              //Padding(padding: EdgeInsets.only( top: 2),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green, minimumSize: Size(200, 50)),
                  onPressed: () {
                    print('´Boton Ingreso A La Tienda Presionado');
                    Navigator.push(context, MaterialPageRoute(builder: (_) => Tiendas()));
                  },
                  child: Text('Ingresar Tienda', style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
