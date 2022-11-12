
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:proyectolineados/Menu.dart';
import 'package:proyectolineados/Vista/Login.dart';
import 'package:local_auth/auth_strings.dart';
import 'package:local_auth/local_auth.dart';
import 'package:proyectolineados/DTO/UserObject.dart';
import 'package:proyectolineados/Roles/MenuAdmin.dart';
import 'package:proyectolineados/Roles/MenuUser.dart';
import 'package:proyectolineados/Vista/Vista_Tienda/Tiendas.dart';

class Login extends StatefulWidget {
  @override
  LoginApp createState() => LoginApp();
}

class LoginApp extends State<Login>{
  TextEditingController doc = TextEditingController();
  TextEditingController pass = TextEditingController();

  final LocalAuthentication auth = LocalAuthentication();

  final firebase = FirebaseFirestore.instance;

  validarDatos() async {
    bool flag = false;
    try {
      CollectionReference ref = FirebaseFirestore.instance.collection("Usuarios");
      print('*1*');
      QuerySnapshot usuario = await ref.get();
      if (usuario.docs.length != 0) {
        print('*2*');
        for (var cursor in usuario.docs) {
          print('*3*');
          //print(doc.text+" doc");
          //print(cursor.get('Documento')+" cursor");
          if (doc.text == cursor.get('Documento')) {
            print('***CARGANDO...***');
            print('Documento Del Usuario Encontrado Correctamente');
            print(cursor.get('Documento'));
            if (pass.text == cursor.get('Contraseña')) {
              print('Buscando Contraseña Del Usuario');
              print(cursor.get('Contraseña'));
              UserObject userOb = UserObject();
            //  userOb.nombre = cursor.get('NombreUsuario');
              userOb.correo = cursor.get('CorreoUsuario');
              userOb.rol = cursor.get('Rol');
            //  mensaje('Mensaje', 'dato encontrado', userOb);

              print(cursor.id);
              //idUser= cursor.id.toString();
            //   flag = true;
            //  mensaje('Mensaje', 'dato encontrado',idUser);

              //mensaje("BIENVENIDO",'*-*-*- HAZ INGRESADO CORRECTAMENTE -*-*-*');
            }
          }
          // print(cursor.get('User'));
        }
       // if (!flag)
        // mensajeGeneral('Mensaje', 'Error: Informacion no encontrada en la base de datos');
      }else{
        print('Informacion no encontrada en la base de datos');
        //mensaje('Mensaje', 'Error: Informacion no encontrada en la base de datos');
      }
    } catch (e) {
      //mensajeGeneral('Error', e.toString());
      print('**************ERROR***********************' + e.toString());
      //mensaje("IMPOSIBLE",'*-*-*- NO HAZ PODIDO INGRESAR -*-*-*');
    }
   // mensaje("BIENVENIDO",'*-*-*- HAZ INGRESADO CORRECTAMENTE -*-*-*');
      print('´Boton Ingresar A La Tienda Presionado');
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Estas Ingresando'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(padding: EdgeInsets.only(top: 25),
              child: Center(
                child: Container(
                  width: 400,
                  height: 340,
                  child: Image.asset('imagenes/usuario.png'),
                ),
              ),
            ),
            Padding(padding: EdgeInsets.all(11),
              child: TextField(
                controller: doc,
                style: TextStyle(color: Colors.blueGrey),
                decoration: InputDecoration(
                    fillColor: Colors.greenAccent,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    labelText: 'Documento',
                    hintText: 'Escriba Su Documento'
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: pass,
                style: const TextStyle(color: Colors.blueGrey),
                decoration: InputDecoration(
                    fillColor: Colors.grey,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    labelText: 'Contraseña',
                    hintText: 'Escriba su contraseña'
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Center(
                child: ElevatedButton(
                  child: const Text('Entrar'),
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (_) => Menu()));
                    print('Botón Presionado');
                    print('*-*-*-*-*-*-*');
                    print('Felicitaciones, Haz Ingresado Exitosamente');
                    validarDatos();
                  },

                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(50, 50),
                  primary: Colors.black45,
                ),
                onPressed: () async {
                  print("Estas Dentro");
                  bool isSuccess = await biometrico();
                  print('Correcto --'+isSuccess.toString());

                  if (isSuccess){
                    print('Correcto');
                  }
                  print('success ' + isSuccess.toString());
                  print(' Bienvenido ');
                  mensaje("BIENVENIDO",'*-*-*- HAZ INGRESADO CORRECTAMENTE -*-*-*');
                },
                child: Icon(Icons.fingerprint, size: 80),

              ),
            ),
          ],

        ),
      ),
    );
  }

  Future<bool> biometrico() async {
    //print("biométrico");
    bool flag = true;
    bool authenticated = false;
    if (flag) {
      const androidString = const AndroidAuthMessages(
        cancelButton: "Cancelar",
        goToSettingsButton: "Ajustes",
        signInTitle: "Ingrese",
        goToSettingsDescription: "Confirme su huella",
        biometricHint: "Toque el sensor",
        biometricNotRecognized: "Huella no reconocida",
        biometricRequiredTitle: "Required Title",
        biometricSuccess: "Huella reconocida",
      );
      bool canCheckBiometrics = await auth.canCheckBiometrics;
      bool isBiometricSupported = await auth.isDeviceSupported();
      List<BiometricType> availableBiometrics =
      await auth.getAvailableBiometrics();
      print(canCheckBiometrics); //Returns trueB
      print("Soporte En -->" + isBiometricSupported.toString());
      print(
          availableBiometrics.toString());
      //Returns [BiometricType.fingerprint]
      try {
        authenticated = await auth.authenticate(
            localizedReason: "Autentíquese para acceder",
            useErrorDialogs: true,
            stickyAuth: true,
            biometricOnly: true,
            androidAuthStrings: androidString);
        if (!authenticated) {
          authenticated = false;
        }
      } on PlatformException catch (e) {
        print(e);
      }
      /* if (!mounted) {
        return authenticated;
      } */
    }
    return authenticated;

  }
  /*
  void mensaje(String titulo, String mess,UserObject userObj) {
    showDialog(
        context: context,
        builder: (buildcontext) {
          return AlertDialog(
            title: Text(titulo),
            content: Text(mess),
            actions: <Widget>[
              FloatingActionButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  if (userObj.rol == 'admin') {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => MenuAdmin(userObj)));
                  } else if (userObj.rol == 'guest') {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => MenuUser(userObj)));
                  }
                  pass.clear();
                  doc.clear();
                },
                child: Text("ok", style: TextStyle(color: Colors.white)),
              )
            ],
          );
        }
    );
  }
  */

  void mensaje(String titulo, String mess) {
    showDialog(
        context: context,
        builder: (buildcontext) {
          return AlertDialog(
            title: Text(titulo),
            content: Text(mess),
            actions: <Widget>[
              FloatingActionButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("Aceptar", style: TextStyle(color: Colors.black, fontSize: 11)),
                ),
             ],
            );
         }
        );
  }
}


