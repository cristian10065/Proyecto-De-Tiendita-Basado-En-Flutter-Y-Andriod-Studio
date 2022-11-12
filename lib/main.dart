import 'package:flutter/material.dart';
import 'package:proyectolineados/Vista/Geocalizacion.dart';
import 'package:proyectolineados/Vista/Login.dart';
import 'package:proyectolineados/Vista/moneda.dart';
import 'package:proyectolineados/Vista/Vista_Tienda/Tiendas.dart';
import 'package:proyectolineados/Vista/rest.dart';
import 'package:proyectolineados/Vista/Registro.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:proyectolineados/Vista/Web.dart';
import 'firebase_options.dart';

void main() async{
 WidgetsFlutterBinding.ensureInitialized();
 await Firebase.initializeApp(
   options: DefaultFirebaseOptions.currentPlatform,);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  HomeStart createState() => HomeStart();
}

class HomeStart extends State<Home>{
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Proyecto Mi Tiendita',
      theme: ThemeData(primarySwatch: Colors.green),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Bienvenidos A Mi tiendita'),
          backgroundColor: Colors.green,
        ),
        body: SingleChildScrollView(
          //Osea que puede crecer verticalmente tanto como lo necesite
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              //Creamos una unica columna, por es se ve centrado
              //Con una seria de componentes dentro de un Array
              children: [
                Padding(padding: EdgeInsets.all(20),
                  //La imagen iria centrada
                  child: Center(
                    child: Container(
                      //Nos permite crear un contenedor para poner la imagen y configurar el tamaño que queramos
                      width: 900,
                      height: 400,
                      child: Image.asset('imagenes/img.png'),
                    ),
                  ),
                ),
                //El padding tiene caracteristicas de centrado
                Padding(padding: EdgeInsets.only(left: 20, top: 10, right: 10),
                  child: Center(
                    child: ElevatedButton(style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green, minimumSize: Size(200, 50)),
                      onPressed: (){
                        print('Boton Entrar Presionado');
                        // El materialpageroute sirve para direccionar la pagina que necesitamos
                        Navigator.push(context, MaterialPageRoute(builder: (_)=> Login()) );
                        theme: ThemeData(primarySwatch: Colors.blue);
                      },
                      child: Text('Entrar', style: TextStyle(color: Colors.white, fontSize: 22)),
                    ),
                  ),
                ),
                Padding (padding: EdgeInsets.only(left: 20, top: 30, right: 10),
                  child: Center(
                    child: ElevatedButton(style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green, minimumSize: Size(200, 50)),
                      onPressed: (){
                        print('Boton Registrar Presionado');
                        // El materialpageroute sirve para direccionar la pagina que necesitamos
                        Navigator.push(context, MaterialPageRoute(builder: (_)=> Registro()) );
                      },
                      child: Text('Registrar', style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                   ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
