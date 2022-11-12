import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:encrypt/encrypt.dart';
import 'package:flutter/material.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:proyectolineados/DTO/UserObject.dart';

class UserAdmin extends StatefulWidget {
  @override
  UserAdminApp createState() =>UserAdminApp();
}

class UserAdminApp extends State<UserAdmin> {
  DateTime selectedDate = DateTime.now();
  var _currentSelectedDate;
  TextEditingController correo = TextEditingController();
  TextEditingController nombre = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController fecha = TextEditingController();
  UserObject usuario=UserObject();
  final key = encrypt.Key.fromUtf8('PKwJSEhYLB88Lc8PEEPmKXdP6u3n9F5J');
  final iv = IV.fromLength(16);

  final firebase = FirebaseFirestore.instance;
  inserDatatUser(String passEncripted) async {
    print('1****');
    try {
      // almacenando en BBDD
      await firebase.collection("Users").doc().set({
        "NombreUsuario": nombre.text,
        "CorreoUsuario": correo.text,
        "Pass": pass.text,
        "Fecha": fecha.text,
        "Estado": true,
        "Rol": "guest"
      });
      print("CORRECTO*****************");

      mensaje("Ingreso", "Usuario registrado correctamente");
    } catch (e) {
      print('ERROR--> ' + e.toString());
    }
    //String clave=KEY_LOCAL_AUTH_ENABLED;
    print(usuario.toString());
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registro usuario'),
        backgroundColor: Colors.black45,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: nombre,
                style: TextStyle(color: Colors.blueGrey),
                decoration: InputDecoration(
                  fillColor: Colors.grey,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  labelText: 'Nombre usuario',
                  hintText: 'Digite su nombre',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: correo,
                style: TextStyle(color: Colors.blueGrey),
                decoration: InputDecoration(
                  fillColor: Colors.grey,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  labelText: 'Correo',
                  hintText: 'Digite su correo',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: pass,

                obscureText: true,
                style: TextStyle(color: Colors.blueGrey),
                decoration: InputDecoration(
                  fillColor: Colors.grey,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  labelText: 'Contraseña',
                  hintText: 'Digite su contraseña',
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
                      hintText: 'Digite la fecha de nacimiento',
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
                    backgroundColor: Colors.black45, minimumSize: Size(400, 50)),
                onPressed: ()  {
                  print('Ingreso resgitro datos');

                  final encrypter = Encrypter(AES(key));
                  final encrypted = encrypter.encrypt(pass.text, iv: iv);
                  // print(decrypted);
                  // print(key);
                  print('Password----->' + encrypted.bytes.toString());
                  //  print(encrypted.base16);
                  print(key.bytes);
                  print(encrypted.base64);
                  // print(encrypter);
                  inserDatatUser(encrypted.base64);
                },
                child: Text(
                  'Ingresar datos',
                  style: TextStyle(color: Colors.white, fontSize: 20),
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
                  pass.clear();
                  fecha.clear();
                  nombre.clear();
                  correo.clear();
                },
                child: Text("ok", style: TextStyle(color: Colors.white)),
              )
            ],
          );
        });
  }
}
