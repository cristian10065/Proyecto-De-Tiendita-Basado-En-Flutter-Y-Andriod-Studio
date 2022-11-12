
//Importar para poder hacer la renderizacion de los componentes
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:encrypt/encrypt.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:proyectolineados/Vista/UserAdmin.dart';


class Registro extends StatefulWidget {
  @override
  RegistroApp createState() => RegistroApp();
}

class RegistroApp extends State<Registro> {
  //Dentro del Registro ponemos lo que queremos crear en esta crear un nuevo registro
  var _currentSelectedDate;
  TextEditingController usuario = TextEditingController();
  TextEditingController doc = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController correo = TextEditingController();
  TextEditingController fecha = TextEditingController();


  //TextEditingController rol = TextEditingController();
  //Es un objeto apartir de una clase = Instance
  final firebase=FirebaseFirestore.instance;

  //Creamos nuestra funcion de registro
  //async metodo asincrono para web y tiene la capacidad de lineas de codigo simultaneamente, se hace por temas de optimizacion
  registroUsuario() async{
    //async una manera de ejecucion no lineal
    //es una manera de hacer una manejo de roles, es decir para manejar posibles errores
    // y evitar que nuestro codigo de rompa y se quede esperando infinitamente a funcionar
    // donde solo se ejecuta si todas las condiciones son favorables
    try{
      //Quiere decir que solo se ejecuta esta liena de codigo, cuando las demas lineas se han ejecutado
      await firebase.collection('Usuarios').doc().set({
        //.doc() nos crea una id del documento al azar
        // await sirve para esperar el dato en una funcion asyncrona
        "Nombre":usuario.text,
        "Documento":doc.text,
        "Contraseña":pass.text,
        "Correo":correo.text,
        "Fecha":fecha.text,
        "Estado":true,
        "Rol": "Usuario"
        });
      print("**REGISTRADO CORRECTAMENTE**");
      mensaje("Usuario","*-*-*-*-*-*- Registrado Correctamente -*-*-*-*-*-*");
    }catch (e) {
      print('Error...'+e.toString());
    }
    print(usuario.toString());
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Registro Nuevo Usuario'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(10),
              //La imagen iria centrada
              child: Center(
                child: Container(
                  //Nos permite crear un contenedor para poner la imagen y configurar el tamaño que queramos
                  width: 450,
                  height: 300,
                  child: Image.asset('imagenes/registro.png'),

                ),
              ),
            ),
            Padding(padding: EdgeInsets.only(left: 10, top: 25, right: 10),
              child: TextField(
                controller: usuario,
                //Estamos relacionando osea lo que sea que suceda, quede guardado en usuario
                decoration: InputDecoration(
                  labelText: 'Nombre Del Nuevo Usuario',
                  hintText: 'Digite Su Nombre De Usuario',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(22)),
                ),
              ),
            ),

            Padding(padding: EdgeInsets.only(left: 10, top: 10, right: 10),
              child: TextField(
                controller: doc,
                decoration: InputDecoration(
                  labelText: 'Documento Del Usuario',
                  hintText: 'Digite Su Documento',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(22)),
                ),
              ),
            ),

            Padding(padding: EdgeInsets.only(left: 10, top: 10, right: 10),
              child: TextField(
                controller: pass,
                decoration: InputDecoration(
                  labelText: 'Contraseña',
                  hintText: 'Digite Su Contraseña',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(22)),
                ),
              ),
            ),
            Padding(padding: EdgeInsets.only(left: 10, top: 10, right: 10),
              child: TextField(
                controller: correo,
                decoration: InputDecoration(
                  labelText: 'Correo',
                  hintText: 'Digite Su Correo Electronico',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(22)),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 15, top: 10, right: 15),
              child: Stack(
                alignment: const Alignment(1.0, 1.0),
                children: <Widget>[
                  new TextField(
                    enabled: false,
                    controller: fecha,
                    style: TextStyle(color: Colors.blueGrey),
                    decoration: InputDecoration(
                      fillColor: Colors.green,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      labelText: 'Fecha de nacimiento',
                      hintText: 'Digite Su Fecha De Nacimiento',
                    ),
                  ),
                  new FloatingActionButton(
                      onPressed: () {callDataPcker();
                        },
                      child: new Icon(Icons.date_range_outlined))
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10, top: 10, right: 10, bottom: 0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Colors.blue, minimumSize: Size(400, 50)),
                onPressed: () {
                  print('Registrando***');
                  //inserDatatUser();

                  final key = encrypt.Key.fromSecureRandom(32);
                  final iv = IV.fromSecureRandom(16);
                  final encrypter = Encrypter(AES(key));
                  final encrypted = encrypter.encrypt(pass.text, iv: iv);
                  // print(decrypted);
                  print(key);
                  print('Password----->'+encrypted.bytes.toString());
                  print(encrypted.base16);
                  print(encrypted.base64);
                  pass.text=encrypted.base64;

                  registroUsuario();
                  usuario.clear();
                  doc.clear();
                  pass.clear();
                  correo.clear();
                  fecha.clear();
                },
                child: Text('Registrar Datos', style: TextStyle(color: Colors.white, fontSize: 22),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  void callDataPcker() async {
    var selectedDate = await getDatePickerWidget();
    setState(() {
      _currentSelectedDate = selectedDate;
      if (selectedDate != null) {
        fecha.text = selectedDate.toString().substring(0, 10);
        //fecha.text='1940-01-01';
      }
    });
  }
  Future<DateTime?> getDatePickerWidget() {
    return showDatePicker(
        context: context,
        initialDate: DateTime(2022),
        firstDate: DateTime(1930),
        lastDate: DateTime.now(),
        fieldHintText: "DIA/MES/AÑO",
        fieldLabelText: "Día/Mes/Año",
        helpText: "FECHA DE NACIMIENTO",
        errorFormatText: "Ingrese una fecha válida",
        errorInvalidText: "Fecha fuera de rango",
        initialEntryMode: DatePickerEntryMode.input,
        builder: (context, child) {
          return Theme(data: ThemeData.dark(), child: Center(child: child));
        });
  }
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
                child:
                Text(" Aceptar ", style: TextStyle(color: Colors.blue, fontSize: 11)),

              )
            ],
          );
        });
  }
}


